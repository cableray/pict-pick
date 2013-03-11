# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


@app = angular.module('pictpick',[])

@app.directive 'rating', ()->
  {
    scope:
      currentRating:'@'
      maxRating:'@'
      voteCount:'@'
      action:'@'
      method:'@'
    restrict: 'E'
    template: """
    <div class="rating-stats">
      Average&nbsp;Rating: {{rating.currentRating()}}
      <span ng-show="voteCount"> | Number&nbsp;of&nbsp;Votes:{{voteCount}}</span>
      <span ng-show="rating.pendingRating"> | My&nbsp;Rating:{{rating.pendingRating}}</span>
    </div>
    <div class="progress progress-success">
      <div class="bar" style="width:{{rating.displayPercent()}}%"></div>
    </div><div>{{rating.displayRating()}} ({{rating.displayPercent()}}%)</div>
    """
    controller: ($scope,$attrs)->
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

    link: (scope, element, attrs, controller)->
      well = element.find '.progress' #requires jquery to use this selector.
      bar = well.find '.bar'
      attrs.maxRating ||= 10
      scope.mouseIn= false
      well.bind 'mouseenter', (event)->
        well.removeClass 'progress-success'
        scope.mouseIn= true
        scope.rating.setMouseRating(event.offsetX,well.width())
        scope.$apply()
      well.bind 'mouseleave', (event)->
        scope.mouseIn= false
        well.addClass 'progress-success'
        scope.$apply()
      well.bind 'mousemove', (event)->
        scope.rating.setMouseRating(event.offsetX,well.width())
        scope.$apply()
      well.bind 'click', (event)->
        scope.rating.pendingRating= scope.rating.setMouseRating(event.offsetX,well.width())
        well.addClass 'progress-striped'
        scope.$apply()
  }
