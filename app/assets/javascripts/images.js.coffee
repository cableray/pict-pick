# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


@app = angular.module('pictpick',[])

@app.directive 'rating', ()->
  {
    scope:
      currentRating:'@'
      maxRating:'@'
      action:'@'
      method:'@'
    restrict: 'E'
    template: """
    <div class="progress progress-success center" style="width:200px;">
      <div class="bar" style="width:{{percent}}%"></div>
    </div><div>{{percent}}%</div>
    """,
    controller: ($scope,$attrs)->
      displayPercent: ->
        if $scope.mouseIn
          @mousePercent()
        else
          @currentRatingPercent()
      currentRatingPercent: ->
        $attrs.currentRating/$attrs.maxRating *100
      mousePercent: ->
        $scope.mouseRating/$attrs.maxRating *100 || @currentRatingPercent
      mouseRating: (offset,width)->
        Math.round offset/width * $attrs.maxRating

    link: (scope, element, attrs, controller)->
      well = element.find '.progress' #requires jquery to use this selector.
      bar = well.find '.bar'
      attrs.maxRating ||= 10
      scope.ratingPercent= controller.currentRatingPercent
      scope.mouseIn= false
      scope.percent= controller.displayPercent()
      well.bind 'mouseenter', (event)->
        well.removeClass 'progress-success'
        scope.mouseIn= true
        scope.mouseRating= controller.mouseRating(event.offsetX,well.width())
        scope.percent= controller.displayPercent()
        scope.$apply()
      well.bind 'mouseleave', (event)->
        scope.mouseIn= false
        scope.percent= controller.displayPercent()
        well.addClass 'progress-success'
        scope.$apply()
      well.bind 'mousemove', (event)->
        scope.mouseRating= controller.mouseRating(event.offsetX,well.width())
        scope.percent= controller.displayPercent()
        scope.$apply()
      well.bind 'click', (event)->
        attrs.currentRating= controller.mouseRating(event.offsetX,well.width())
        scope.$apply()
  }
