app = angular.module 'math', []

app.factory 'QuestionGenerator', ->
  service = []

  service.generate = (num, operators, max = 12) ->
    questions = []

    for index in [0...num]
      val1 = Math.floor(Math.random() * max) + 1
      val2 = Math.floor(Math.random() * max) + 1
      operator = operators[Math.floor(Math.random() * operators.length)]
      answer = 0

      switch operator
        when "+" then answer = val1 + val2
        when "-" then answer = val1 - val2
        when "x" then answer = val1 * val2
        when "/" then answer = val1 / val2

      questions.push {
        'equation': {
          'val1': val1
          'val2': val2
          'operator': operator
        }
        'answer': answer
        'user_answer': null
      }

    return questions

  return service

app.controller 'MathController', ($scope, QuestionGenerator) ->
  $scope.correct = 0
  $scope.popover = false
  $scope.max = 5
  $scope.questions = []
  
  $scope.generate = ->
    operations = ['+', '-', 'x']
    $scope.questions = QuestionGenerator.generate 100, operations, $scope.max
    
  $scope.generate()
  
  @isCorrect = (question) ->
    user_answer = parseInt question.user_answer
    answer = parseInt question.answer
    return answer is user_answer
  
  $scope.popoverVisible = ->
    return $scope.popover
    
  $scope.popoverToggle = ->
    $scope.popover = ! $scope.popover

  $scope.$watch 'questions', (->
    $scope.correct = 0
    _.each $scope.questions, (question) ->
      user_answer = parseInt question.user_answer
      answer = parseInt question.answer
      if answer is user_answer
        question.correct = true
        $scope.correct = $scope.correct + 1
      else
        question.correct = false
  ), true

  return