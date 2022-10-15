import 'package:contacts/details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactScreen extends StatelessWidget {
  Details info;

  ContactScreen(this.info);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(
                info.url,
              ),
            ),
            Text(
              '  ${info.firstname}\n${info.lastname}',
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              info.number.toString(),
              style: const TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
