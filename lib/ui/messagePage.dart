import 'package:flutter/material.dart';
import '../models/user_id_pseudo.dart';
import 'conversationDiv.dart';
import 'package:arosaje/ui/services/MessageService.dart'; // Assurez-vous que le chemin vers MessageService.dart est correct

class MessagePage extends StatefulWidget {
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  TextEditingController _searchController = TextEditingController();
  MessageService messageService = MessageService();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _onSearchChanged() async {
    String searchText = _searchController.text;
    List<UserIdPseudo> ListUser = await messageService.getConversation(searchText);
    print(ListUser);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Rechercher un utilisateur',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              ConversationDiv(),
              SizedBox(height: 4),
              ConversationDiv(),
              SizedBox(height: 4),
              ConversationDiv(),
              SizedBox(height: 4),
            ],
          ),
        ),
      ],
    );
  }
}
