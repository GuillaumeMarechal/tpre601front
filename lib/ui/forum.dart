import 'package:flutter/material.dart';
import 'forumPost.dart';

class ForumPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Rechercher des forums',
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
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color(0xFFA2C48B),
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text('Commencer une discussion'),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(color: Colors.black, width: 0.5),
                    ),
                  ),
                  child: Text('Filtre'),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Expanded(
            child: Container(
              constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height - 200),
              child: ListView(
                children: [
                  ForumPost(),
                  SizedBox(height: 8),
                  ForumPost(),
                  SizedBox(height: 8),
                  ForumPost(),
                  SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
