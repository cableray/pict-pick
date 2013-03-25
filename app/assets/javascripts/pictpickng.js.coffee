# All this logic will automatically be available in application.js.

@app = angular.module('pictpick',['ng-rails-csrf'])

@app.directive 'rating', ()->
  {
    scope:
      currentRating:'@'
      maxRating:'@'
      voteCount:'@'
      showStats:'@'
      action:'@'
      method:'@'
    restrict: 'E'
    template: """
    <div ng-show="showStats" class="rating-stats">
      Average&nbsp;Rating: {{rating.currentRating() | number:2}}
      <span ng-show="rating.voteCount()"> | Number&nbsp;of&nbsp;Votes: {{rating.voteCount() | number}}</span>
      <span ng-show="rating.pendingRating"> | My&nbsp;Rating: {{rating.pendingRating | number:2}}</span>
    </div>
    <div class="progress" ng-class="classes()" style="cursor:pointer;">
      <div class="bar" style="width:{{rating.displayPercent()}}%">{{rating.displayRating() | number}}/{{maxRating | number}}</div>
    </div>
    """
    controller: ($scope,$attrs,$http)->
      # scope and model setup
      $scope.rating=
        displayPercent: ->
          if $scope.mouseIn
            @mousePercent()
          else
            @pendingRatingPercent() || @currentRatingPercent()
        displayRating: ->
          if $scope.mouseIn
            @mouseRating
          else
            @currentRating()
        currentRatingPercent: ->
          @currentRating()/$attrs.maxRating *100
        currentRating: ->
          $attrs.currentRating
        setCurrentRating: (value)->
          $attrs.currentRating= value
        mousePercent: ->
          @mouseRating/$attrs.maxRating *100 || @currentRatingPercent
        setMouseRating: (offset,width)->
          @mouseRating= Math.round offset/width * $attrs.maxRating
        pendingRatingPercent: ->
          @pendingRating/$attrs.maxRating *100
        setVoteCount: (value)->
          $attrs.voteCount= "#{value}"
        voteCount: ->
          $attrs.voteCount

      $scope.classes= ->
        'progress-success': !$scope.mouseIn && !$scope.error
        'progress-striped': !!($scope.rating.pendingRating)
        'progress-danger': !!$scope.error
        'active': !!$scope.submitting
      # controller methods

      submit: ->
        $scope.submitting= true
        $http.post($attrs.action, { value: $scope.rating.pendingRating }).success( (data)->
            $scope.submitting= false
            $scope.error= false
            $scope.rating.setCurrentRating data.average_rating
            $scope.rating.pendingRating= null
            $scope.rating.setVoteCount data.rating_count
            console.log data
            # $scope.$apply()
          ).error (data, status, headers)->
            $scope.error= true
            $scope.submitting= false
            console.log {data:data,status:status,headers:headers()}

    link: (scope, element, attrs, controller)->
      well = element.find '.progress' #requires jquery to use this selector.
      bar = well.find '.bar'
      attrs.maxRating ||= 10
      scope.mouseIn= false
      well.bind 'mouseenter', (event)->
        #well.removeClass 'progress-success'
        scope.mouseIn= true
        scope.rating.setMouseRating(event.offsetX,well.width())
        scope.$apply()
      well.bind 'mouseleave', (event)->
        scope.mouseIn= false
        #well.addClass 'progress-success'
        scope.$apply()
      well.bind 'mousemove', (event)->
        scope.rating.setMouseRating(event.offsetX,well.width())
        scope.$apply()
      well.bind 'click', (event)->
        scope.rating.pendingRating= scope.rating.setMouseRating(event.offsetX,well.width())
        #well.addClass 'progress-striped'
        scope.$apply()
        controller.submit()
  }
