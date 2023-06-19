import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../widgets/contact_list.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: appBarColor,
            elevation: 0,
            title: const Text(
              'Communite Chat',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.search,color: Colors.white,),),
              IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert, color: Colors.white,),),
            ],
            bottom: const TabBar(
                indicatorColor: tabColor,
                indicatorWeight: 3,
                labelColor: tabColor,
                unselectedLabelColor: Colors.white,
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                tabs: [
                  Tab(text: 'CHATS',),
                  Tab(text: 'ESTADOS',),
                  Tab(text: 'LLAMADAS',),
                ]),
          ),
          body: const ContactsList()

        /*const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Importar aquí los chats',
                style: TextStyle(
                  fontSize: 24, // Tamaño de fuente
                  fontWeight: FontWeight.bold, // Peso de fuente
                  fontStyle: FontStyle.normal, // Estilo de fuente
                  color: Colors.white, // Color del texto
                  decoration: TextDecoration.none, // Decoración del texto
                  //decorationColor: Colors.green, // Color de la decoración
                  //decorationStyle: TextDecorationStyle.dotted, // Estilo de la decoración
                ),),
              SizedBox(height: 20), // Espacio vertical entre el Text y la imagen
              Image(image: AssetImage('assets/images/video.gif')),
            ],
          ),
        )*/
      ),
    );
  }
}
