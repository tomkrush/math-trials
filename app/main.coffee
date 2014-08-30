app = angular.module 'math', []

app.factory 'QuestionGenerator', ->
  service = []

  service.generate = (num, operators) ->
    questions = []

    for index in [0...num]
      val1 = Math.floor(Math.random() * 12) + 1
      val2 = Math.floor(Math.random() * 12) + 1
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
  $scope.questions = QuestionGenerator.generate 100, ['+', '-', 'x']
  $scope.correct = 0

  @isCorrect = (question) ->
      user_answer = parseInt question.user_answer
      answer = parseInt question.answer
      return answer is user_answer

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