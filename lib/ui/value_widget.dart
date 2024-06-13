import 'package:flutter/cupertino.dart';

class ValueWidget extends StatelessWidget {
  Widget child;
  dynamic value;
  ValueWidget({required this.child, required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    return child;
  }

  getValue(){
    return value;
  }
}
