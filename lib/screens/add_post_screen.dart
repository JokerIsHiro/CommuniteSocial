import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:communitesocial/providers/user_providers.dart';
import 'package:communitesocial/utils/colors.dart';
import 'package:communitesocial/utils/utils.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _file;
  bool isLoading = false;
  final TextEditingController _descriptionController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
      return Scaffold(
        appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: (){},
          ),
          title: const Text("Publicar"),
          centerTitle: false,
          actions: [
            TextButton(
              onPressed: (){}, 
              child: const Text("Publicar", 
                style: TextStyle(color: Colors.blueAccent, 
                fontWeight: FontWeight.bold, 
                fontSize: 16,
                )
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                  "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Default_pfp.svg/1200px-Default_pfp.svg.png"
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.3,
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: "Escribe una descripción",
                      border: InputBorder.none,
                    ),
                    maxLines: 8,
                  ),
                ),
                SizedBox(
                  height: 45,
                  width: 45,
                  child: AspectRatio(
                    aspectRatio: 487 / 451,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage("https://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Default_pfp.svg/1200px-Default_pfp.svg.png"),
                          fit: BoxFit.fill,
                          alignment: FractionalOffset.topCenter
                        )
                      ),
                    ),
                  ),
                ),
                const Divider(),
              ],
            )
          ],
        ),
      );
  }
}
