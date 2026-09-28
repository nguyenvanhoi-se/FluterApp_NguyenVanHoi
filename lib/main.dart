import 'package:flutter/material.dart';

void main() {
  runApp(const DestiniApp());
}

// =====================================================
// MODEL: STORY
// =====================================================

class Story {
  final String storyTitle;
  final String choice1;
  final String choice2;
  final int choice1Destination;
  final int choice2Destination;

  const Story({
    required this.storyTitle,
    required this.choice1,
    required this.choice2,
    required this.choice1Destination,
    required this.choice2Destination,
  });
}

// =====================================================
// STORY BRAIN
// =====================================================

class StoryBrain {
  int _storyNumber = 0;

  final List<Story> _storyData = const [
    Story(
      storyTitle:
          'You wake up in a dark forest. You can hear strange sounds nearby.',
      choice1: 'Follow the sound.',
      choice2: 'Walk in the opposite direction.',
      choice1Destination: 1,
      choice2Destination: 2,
    ),
    Story(
      storyTitle:
          'You discover a small cabin with a light shining through the window.',
      choice1: 'Enter the cabin.',
      choice2: 'Keep walking.',
      choice1Destination: 3,
      choice2Destination: 4,
    ),
    Story(
      storyTitle:
          'You find a river blocking your path. There is a small bridge nearby.',
      choice1: 'Cross the bridge.',
      choice2: 'Follow the river.',
      choice1Destination: 4,
      choice2Destination: 5,
    ),
    Story(
      storyTitle:
          'Inside the cabin, you find a warm fireplace and a safe place to rest.',
      choice1: 'START AGAIN',
      choice2: '',
      choice1Destination: 0,
      choice2Destination: 0,
    ),
    Story(
      storyTitle:
          'You find the exit of the forest and see the sunlight ahead.',
      choice1: 'START AGAIN',
      choice2: '',
      choice1Destination: 0,
      choice2Destination: 0,
    ),
    Story(
      storyTitle:
          'You follow the river and discover a beautiful waterfall. Your adventure ends here.',
      choice1: 'START AGAIN',
      choice2: '',
      choice1Destination: 0,
      choice2Destination: 0,
    ),
  ];

  String getStoryTitle() {
    return _storyData[_storyNumber].storyTitle;
  }

  String getChoice1() {
    return _storyData[_storyNumber].choice1;
  }

  String getChoice2() {
    return _storyData[_storyNumber].choice2;
  }

  void nextStory(int choiceNumber) {
    if (choiceNumber == 1) {
      _storyNumber = _storyData[_storyNumber].choice1Destination;
    } else {
      _storyNumber = _storyData[_storyNumber].choice2Destination;
    }
  }

  bool buttonShouldBeVisible() {
    return _storyData[_storyNumber].choice2.isNotEmpty;
  }

  void restart() {
    _storyNumber = 0;
  }
}

// =====================================================
// APP
// =====================================================

class DestiniApp extends StatelessWidget {
  const DestiniApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Destini',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const StoryPage(),
    );
  }
}

// =====================================================
// STORY PAGE
// =====================================================

class StoryPage extends StatefulWidget {
  const StoryPage({super.key});

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  final StoryBrain _storyBrain = StoryBrain();

  void _chooseStory(int choiceNumber) {
    setState(() {
      _storyBrain.nextStory(choiceNumber);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/background.jpg',
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            color: Colors.black.withValues(alpha: 0.35),
            child: Column(
              children: [
                // =======================================
                // STORY
                // =======================================

                Expanded(
                  flex: 5,
                  child: Center(
                    child: Text(
                      _storyBrain.getStoryTitle(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        height: 1.4,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // =======================================
                // CHOICE 1
                // =======================================

                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        if (_storyBrain.getChoice1() == 'START AGAIN') {
                          setState(() {
                            _storyBrain.restart();
                          });
                        } else {
                          _chooseStory(1);
                        }
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        _storyBrain.getChoice1(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // =======================================
                // CHOICE 2
                // =======================================

                Visibility(
                  visible: _storyBrain.buttonShouldBeVisible(),
                  child: Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {
                          _chooseStory(2);
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          _storyBrain.getChoice2(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                const Text(
                  'DESTINI',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3,
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