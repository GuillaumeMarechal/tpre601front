import 'package:arosaje/models/user_data.dart';

class Conversation {
  int idConversation;
  UserData user;
  UserData otherUser;

  Conversation({
    required this.idConversation,
    required this.user,
    required this.otherUser,
  });

  Conversation.fromJson(Map<String, dynamic> json)
      : idConversation = json['idConversation'],
        user = UserData.fromJson(json['user']),
        otherUser = UserData.fromJson(json['otherUser']);

  Map<String, dynamic> toJson() => {
    'idConversation': idConversation,
    'user': user.toJson(),
    'otherUser': otherUser.toJson(),
  };
}