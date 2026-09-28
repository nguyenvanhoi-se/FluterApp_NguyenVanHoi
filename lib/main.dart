import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const Magic8BallApp());
}

class Magic8BallApp extends StatelessWidget {
  const Magic8BallApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Magic 8 Ball',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const Magic8BallPage(),
    );
  }
}

class Magic8BallPage extends StatefulWidget {
  const Magic8BallPage({super.key});

  @override
  State<Magic8BallPage> createState() => _Magic8BallPageState();
}

class _Magic8BallPageState extends State<Magic8BallPage> {
  int answerNumber = 1;

  final List<String> answers = [
    'YES',
    'NO',
    'ASK AGAIN',
    'DEFINITELY',
    'NOT SURE',
  ];

  void getAnswer() {
    setState(() {
      answerNumber = Random().nextInt(answers.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,

      // ==============================
      // APP BAR
      // ==============================
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Magic 8 Ball',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // ==============================
      // BODY
      // ==============================
      body: Container(
        width: double.infinity,
        height: double.infinity,

        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/background.png',
            ),
            fit: BoxFit.cover,
          ),
        ),

        child: Container(
          // Làm background tối nhẹ
          color: Colors.black.withValues(alpha: 0.20),

          child: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 55),

                // =========================
                // ASK ME ANYTHING
                // =========================
                const Text(
                  'Ask me anything...',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 35),

                // =========================
                // MAGIC 8 BALL
                // =========================
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'assets/magic_8_ball.png',
                      width: 290,
                      height: 290,
                      fit: BoxFit.contain,
                    ),

                    // ======================
                    // ANSWER
                    // ======================
                    Transform.translate(
                      offset: const Offset(0, 8),
                      child: SizedBox(
                        width: 105,
                        height: 105,
                        child: Center(
                          child: Text(
                            answers[answerNumber],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  color: Colors.black,
                                  blurRadius: 5,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 35),

                // =========================
                // ASK BUTTON
                // =========================
                ElevatedButton(
                  onPressed: getAnswer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,

                    padding: const EdgeInsets.symmetric(
                      horizontal: 55,
                      vertical: 17,
                    ),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),

                    elevation: 8,
                  ),
                  child: const Text(
                    'ASK',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}