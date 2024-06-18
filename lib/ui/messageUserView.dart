import 'package:flutter/material.dart';
import 'message.dart';

class MessageUserView extends StatefulWidget {
  @override
  _MessageUserViewState createState() => _MessageUserViewState();
}

class _MessageUserViewState extends State<MessageUserView> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = [
    {"text": "Salut ! Comment ça va ?", "isReceived": true},
    {"text": "Bonjour ! Ça va bien merci, et toi ?", "isReceived": false},
    {"text": "Je vais bien aussi, merci ! Qu'as-tu prévu pour aujourd'hui ?", "isReceived": true},
    {"text": "Rien de spécial, juste du travail. Et toi ?", "isReceived": false},
    {"text": "Pareil, beaucoup de travail à faire.", "isReceived": true},
    {"text": "Courage ! On va y arriver.", "isReceived": false},
    {"text": "Oui, c'est sûr ! Comment s'est passée ta journée hier ?", "isReceived": true},
    {"text": "Plutôt bien, merci. J'ai fini quelques tâches importantes.", "isReceived": false},
    {"text": "Super ! Tu as des projets pour ce week-end ?", "isReceived": true},
    {"text": "Je pense sortir avec des amis. Et toi ?", "isReceived": false},
    {"text": "Je vais peut-être aller au cinéma.", "isReceived": true},
    {"text": "Ça fait longtemps que tu n'y es pas allé !", "isReceived": false},
    {"text": "Oui, ça fait un moment. J'espère voir un bon film.", "isReceived": true},
    {"text": "Je te le souhaite ! Quel genre de film tu préfères ?", "isReceived": false},
    {"text": "J'aime bien les films d'action et aussi les comédies.", "isReceived": true},
    {"text": "Cool ! Moi aussi.", "isReceived": false},
    {"text": "On devrait se retrouver pour en regarder un ensemble un jour !", "isReceived": true},
    {"text": "Ça serait génial !", "isReceived": false},
    {"text": "Je dois y aller maintenant. On se reparle plus tard ?", "isReceived": true},
    {"text": "Oui, bien sûr. À plus tard !", "isReceived": false},
  ];


  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _messages.add({"text": _controller.text, "isReceived": false});
        _controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('[User Name]'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Image.asset(
              'lib/assets/arosaje.png',
              width: 40,
              height: 40,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return Message(
                  message: message["text"],
                  isReceived: message["isReceived"],
                );
              },
            ),
          ),
          Container(
            color: Colors.grey[200],
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.photo_camera),
                    onPressed: () {
                      // Logique pour prendre une photo
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.image),
                    onPressed: () {
                      // Logique pour sélectionner une image
                    },
                  ),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Message...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _sendMessage,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Theme.of(context).primaryColor,
                    ),
                    child: Text('Envoyer'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
