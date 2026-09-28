import 'package:flutter/material.dart';

void main() {
  runApp(const QuizzlerApp());
}

// =====================================================
// MODEL: Question
// =====================================================

class Question {
  final String text;
  final bool answer;

  const Question({
    required this.text,
    required this.answer,
  });
}

// =====================================================
// APP
// =====================================================

class QuizzlerApp extends StatelessWidget {
  const QuizzlerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quizzler',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const QuizzlerPage(),
    );
  }
}

// =====================================================
// QUIZZLER PAGE
// =====================================================

class QuizzlerPage extends StatefulWidget {
  const QuizzlerPage({super.key});

  @override
  State<QuizzlerPage> createState() => _QuizzlerPageState();
}

class _QuizzlerPageState extends State<QuizzlerPage> {
  // ===================================================
  // DANH SÁCH CÂU HỎI
  // ===================================================

  final List<Question> _questions = const [
    Question(
      text: 'The Earth is the third planet from the Sun.',
      answer: true,
    ),
    Question(
      text: 'Flutter is a programming language.',
      answer: false,
    ),
    Question(
      text: 'The Pacific Ocean is the largest ocean on Earth.',
      answer: true,
    ),
    Question(
      text: '2 + 2 = 5.',
      answer: false,
    ),
    Question(
      text: 'Dart is the programming language used by Flutter.',
      answer: true,
    ),
    Question(
      text: 'The Sun is a planet.',
      answer: false,
    ),
    Question(
      text: 'Water freezes at 0 degrees Celsius.',
      answer: true,
    ),
  ];

  // ===================================================
  // TRẠNG THÁI
  // ===================================================

  int _questionNumber = 0;

  final List<Icon> _scoreKeeper = [];

  // ===================================================
  // XỬ LÝ CÂU TRẢ LỜI
  // ===================================================

  void _checkAnswer(bool userAnswer) {
    final bool correctAnswer = _questions[_questionNumber].answer;

    setState(() {
      if (userAnswer == correctAnswer) {
        _scoreKeeper.add(
          const Icon(
            Icons.check,
            color: Colors.green,
            size: 30,
          ),
        );
      } else {
        _scoreKeeper.add(
          const Icon(
            Icons.close,
            color: Colors.red,
            size: 30,
          ),
        );
      }
    });

    // Nếu còn câu hỏi
    if (_questionNumber < _questions.length - 1) {
      setState(() {
        _questionNumber++;
      });
    } else {
      _showResultDialog();
    }
  }

  // ===================================================
  // HIỂN THỊ KẾT QUẢ
  // ===================================================

  void _showResultDialog() {
    final int correctAnswers = _scoreKeeper
        .where((icon) => icon.icon == Icons.check)
        .length;

    final int totalQuestions = _questions.length;

    Future.delayed(const Duration(milliseconds: 300), () {
      if (!mounted) {
        return;
      }

      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'Quiz Completed!',
              textAlign: TextAlign.center,
            ),
            content: Text(
              'Correct answers: $correctAnswers / $totalQuestions',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();

                  setState(() {
                    _questionNumber = 0;
                    _scoreKeeper.clear();
                  });
                },
                child: const Text('PLAY AGAIN'),
              ),
            ],
          );
        },
      );
    });
  }

  // ===================================================
  // GIAO DIỆN
  // ===================================================

  @override
  Widget build(BuildContext context) {
    final Question currentQuestion = _questions[_questionNumber];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Quizzler',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // =========================================
              // CÂU HỎI
              // =========================================

              Expanded(
                flex: 5,
                child: Center(
                  child: Text(
                    currentQuestion.text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // =========================================
              // NÚT TRUE
              // =========================================

              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      _checkAnswer(true);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'TRUE',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // =========================================
              // NÚT FALSE
              // =========================================

              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      _checkAnswer(false);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'FALSE',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // =========================================
              // SCORE KEEPER
              // =========================================

              SizedBox(
                height: 40,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _scoreKeeper,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Question ${_questionNumber + 1}/${_questions.length}',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}