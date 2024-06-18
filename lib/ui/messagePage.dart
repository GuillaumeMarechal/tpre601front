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
  List<UserIdPseudo> _listUser = [];

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
    List<UserIdPseudo> listUser = await messageService.getConversation(searchText);
    listUser.sort((a,b)=>a.pseudo.compareTo(b.pseudo));
    setState(() {
      _listUser = listUser;
    });
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
          child: ListView.builder(
            itemCount: _listUser.length,
            itemBuilder: (context, index) {
              return ConversationDiv(
                id: _listUser[index].id,
                pseudo: _listUser[index].pseudo,
              );
            },
          ),
        ),
      ],
    );
  }
}
