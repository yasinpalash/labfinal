import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => QuizScreen()),
            );
          },
          child: Text('Start Quiz'),
        ),
      ),
    );
  }
}

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentIndex = 0;
  int _score = 0;

  List<Map<String, dynamic>> questions = [
    {
      'category': 'Geography',
      'question': 'What is the capital of France?',
      'options': ['Berlin', 'Madrid', 'Paris', 'Rome'],
      'correctAnswer': 'Paris',
    },
    {
      'category': 'Science',
      'question': 'What is the powerhouse of the cell?',
      'options': ['Nucleus', 'Mitochondria', 'Endoplasmic Reticulum', 'Ribosome'],
      'correctAnswer': 'Mitochondria',
    },
    {
      'category': 'History',
      'question': 'Who was the first President of the United States?',
      'options': ['George Washington', 'Thomas Jefferson', 'John Adams', 'James Madison'],
      'correctAnswer': 'George Washington',
    },
    {
      'category': 'Mathematics',
      'question': 'What is the value of pi (π) to two decimal places?',
      'options': ['3.14', '3.15', '3.16', '3.17'],
      'correctAnswer': '3.14',
    },
    {
      'category': 'General Knowledge',
      'question': 'Which planet is known as the Red Planet?',
      'options': ['Venus', 'Mars', 'Jupiter', 'Saturn'],
      'correctAnswer': 'Mars',
    },
    {
      'category': 'Technology',
      'question': 'Who is the CEO of Tesla and SpaceX?',
      'options': ['Bill Gates', 'Jeff Bezos', 'Elon Musk', 'Mark Zuckerberg'],
      'correctAnswer': 'Elon Musk',
    },
    // Add more questions...
  ];

  void _checkAnswer(String selectedAnswer) {
    String correctAnswer = questions[_currentIndex]['correctAnswer'];
    bool isCorrect = selectedAnswer == correctAnswer;

    if (isCorrect) {
      _score++;
    }

    _nextQuestion();
  }

  void _nextQuestion() {
    if (_currentIndex < questions.length - 1) {
      setState(() {
        _currentIndex++;
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(score: _score, questions: questions),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App - ${questions[_currentIndex]['category']} - Question ${_currentIndex + 1}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(questions[_currentIndex]['question']),
            SizedBox(height: 20),
            Column(
              children: List.generate(
                questions[_currentIndex]['options'].length,
                    (index) {
                  return ElevatedButton(
                    onPressed: () {
                      _checkAnswer(questions[_currentIndex]['options'][index]);
                    },
                    child: Text(questions[_currentIndex]['options'][index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ResultScreen extends StatelessWidget {
  final int score;
  final List<Map<String, dynamic>> questions;

  ResultScreen({required this.score, required this.questions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Result'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Your Score: $score'),
            _getFeedback(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => AuthScreen()),
                );
              },
              child: Text('Restart Quiz'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getFeedback() {
    if (score == questions.length) {
      return Text('Congratulations! You answered all questions correctly.');
    } else if (score >= questions.length ~/ 2) {
      return Text('Good job! You scored $score out of ${questions.length} questions.');
    } else {
      return Text('Keep practicing. You scored $score out of ${questions.length} questions.');
    }
  }
}
