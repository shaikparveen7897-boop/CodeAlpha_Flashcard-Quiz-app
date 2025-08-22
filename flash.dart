import 'package:flutter/material.dart';void main() {
  runApp(FlashcardApp());
}
class FlashcardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flashcard Quiz App',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: FlashcardHomePage(),
    );
  }
}
class Flashcard {
  String question;
  String answer;
Flashcard({required this.question, required this.answer});
}
class FlashcardHomePage extends StatefulWidget {
  @override
  _FlashcardHomePageState createState() => _FlashcardHomePageState();
}
class _FlashcardHomePageState extends State<FlashcardHomePage> {
  List<Flashcard> flashcards = [
    Flashcard(question: 'What is the capital of France?', answer: 'Paris'),
    Flashcard(question: 'What is 2 + 2?', answer: '4'),
  ];
  int currentIndex = 0;
  bool showAnswer = false;
  final questionController = TextEditingController();
  final answerController = TextEditingController();
  void nextCard() {
    setState(() {
      showAnswer = false;
      currentIndex = (currentIndex + 1) % flashcards.length;
    });
  }
  void prevCard() {
    setState(() {
      showAnswer = false;
      currentIndex = (currentIndex - 1 + flashcards.length) % flashcards.length;
    });
  }
  void addCard() {
    final question = questionController.text.trim();
    final answer = answerController.text.trim();
    if (question.isNotEmpty && answer.isNotEmpty) {
      setState(() {
        flashcards.add(Flashcard(question: question, answer: answer));
        questionController.clear();
        answerController.clear();
      });
    }
  }
  void editCard() {
    final question = questionController.text.trim();
    final answer = answerController.text.trim();
    if (question.isNotEmpty && answer.isNotEmpty) {
      setState(() {
        flashcards[currentIndex] = Flashcard(question: question, answer: answer);
        questionController.clear();
        answerController.clear();
      });
    }
  }
  void deleteCard() {
    if (flashcards.length > 1) {
      setState(() {
        flashcards.removeAt(currentIndex);
        currentIndex = 0;
        showAnswer = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    final current = flashcards[currentIndex];
    return Scaffold(
      appBar: AppBar(title: Text('Flashcard Quiz')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              elevation: 4,
              child: Container(
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                child: Column(
                  children: [
                    Text(
                      current.question,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    if (showAnswer)
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text(
                          current.answer,
                          style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                        ),
                      ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          showAnswer = !showAnswer;
                        });
                      },
                      child: Text(showAnswer ? 'Hide Answer' : 'Show Answer'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(onPressed: prevCard, child: Text('Previous')),
                ElevatedButton(onPressed: nextCard, child: Text('Next')),
              ],
            ),
            const SizedBox(height: 24),
            TextField(
              controller: questionController,
              decoration: InputDecoration(labelText: 'Question', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: answerController,
              decoration: InputDecoration(labelText: 'Answer', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              children: [
                ElevatedButton(onPressed: addCard, child: Text('Add')),
                ElevatedButton(
                  onPressed: () {
                    questionController.text = current.question;
                    answerController.text = current.answer;
                  },
                  child: Text('Edit'),
                ),
                ElevatedButton(
                  onPressed: editCard,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                  child: Text('Save Edit'),
                ),
                ElevatedButton(
                  onPressed: deleteCard,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: Text('Delete'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}