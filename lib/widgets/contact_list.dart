import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/info.dart';

class ContactsList extends StatelessWidget {
  const ContactsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      child:ListView.builder(
        shrinkWrap: true,
        itemCount: info.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    title: Text(info[index]['name'].toString(),
                        style: const TextStyle(fontSize: 20)),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(
                        info[index]['message'].toString(),
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                    leading: CircleAvatar(
                      backgroundImage:
                      NetworkImage(info[index]['profilePic'].toString()),
                      radius: 30,
                    ),
                    trailing: Text(info[index]['time'].toString(),
                        style: const TextStyle(fontSize: 13, color: Colors.grey)),
                  ),
                ),
              ),
              const Divider(color: dividerColor, indent: 85,)
            ],
          );
        },
      ),
    );
  }
}
