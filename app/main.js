// Generated by CoffeeScript 1.7.1
(function() {
  var app;

  app = angular.module('math', []);

  app.factory('QuestionGenerator', function() {
    var service;
    service = [];
    service.generate = function(num, operators, max) {
      var answer, index, operator, questions, val1, val2, _i;
      if (max == null) {
        max = 12;
      }
      questions = [];
      for (index = _i = 0; 0 <= num ? _i < num : _i > num; index = 0 <= num ? ++_i : --_i) {
        val1 = Math.floor(Math.random() * max) + 1;
        val2 = Math.floor(Math.random() * max) + 1;
        operator = operators[Math.floor(Math.random() * operators.length)];
        answer = 0;
        switch (operator) {
          case "+":
            answer = val1 + val2;
            break;
          case "-":
            answer = val1 - val2;
            break;
          case "x":
            answer = val1 * val2;
            break;
          case "/":
            answer = val1 / val2;
        }
        questions.push({
          'equation': {
            'val1': val1,
            'val2': val2,
            'operator': operator
          },
          'answer': answer,
          'user_answer': null
        });
      }
      return questions;
    };
    return service;
  });

  app.controller('MathController', function($scope, QuestionGenerator) {
    $scope.correct = 0;
    $scope.popover = false;
    $scope.max = 5;
    $scope.questions = [];
    $scope.generate = function() {
      return $scope.questions = QuestionGenerator.generate(100, ['+', '-', 'x'], $scope.max);
    };
    $scope.generate();
    this.isCorrect = function(question) {
      var answer, user_answer;
      user_answer = parseInt(question.user_answer);
      answer = parseInt(question.answer);
      return answer === user_answer;
    };
    $scope.popoverVisible = function() {
      return $scope.popover;
    };
    $scope.popoverToggle = function() {
      return $scope.popover = !$scope.popover;
    };
    $scope.$watch('questions', (function() {
      $scope.correct = 0;
      return _.each($scope.questions, function(question) {
        var answer, user_answer;
        user_answer = parseInt(question.user_answer);
        answer = parseInt(question.answer);
        if (answer === user_answer) {
          question.correct = true;
          return $scope.correct = $scope.correct + 1;
        } else {
          return question.correct = false;
        }
      });
    }), true);
  });

}).call(this);
