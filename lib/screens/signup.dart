import 'package:communitesocial/resources/auth_method.dart';
import 'package:communitesocial/screens/login.dart';
import 'package:communitesocial/utils/colors.dart';
import 'package:communitesocial/utils/utils.dart';
import 'package:communitesocial/widgets/textinput.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Uint8List? _image;

  @override
  void dispose(){
    super.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void irLogin(){
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => LoginScreen()
      ),
    );
  }

  void selectImage() async {
    Uint8List im = await PickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Container(),
                flex: 2,
              ),
              const SizedBox(height: 64),
              Stack(
                children: [
                  const CircleAvatar(
                    radius: 64,
                    backgroundImage: NetworkImage("https://i.imgflip.com/7mu107.jpg"),
                  ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: (){},
                      icon: const Icon(
                        Icons.add_a_photo,
                      ),
                    )
                  ),
                ],
              ),
              const SizedBox(height: 24),
              TextFieldInput(
                hintText: "Inserte su Usuario",
                textInputType: TextInputType.text,
                textEditingController: _usernameController,
              ),
              const SizedBox(height: 24),
              TextFieldInput(
                hintText: "Inserte su E-Mail",
                textInputType: TextInputType.emailAddress,
                textEditingController: _emailController,
              ),
              const SizedBox(
                height: 24, 
              ),
              TextFieldInput(
                hintText: "Inserte su Contraseña",
                textInputType: TextInputType.text,
                textEditingController: _passwordController,
                isPass: true,
              ),
              const SizedBox(
                height: 24, 
              ),
              InkWell(
                onTap: () async{
                  String response = await AutenticarMetodos().registroUsuario(
                    username: _usernameController.text, 
                    email: _emailController.text, 
                    passwd: _passwordController.text
                    );
                  },
                child:Container(
                  child: const Text("Registrar"),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4)
                      )
                    ),
                    color: blueColor
                  ),
                ),
              ),
              const SizedBox(
                height: 12, 
              ),
              Flexible(
                child: Container(),
                flex: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: const Text("Tienes cuenta ya? "),
                    padding: const EdgeInsets.symmetric(
                      vertical: 8
                    ),
                  ),
                  GestureDetector(
                  onTap: irLogin,
                  child: Container(
                    child: const Text("Iniciar Sesión.", 
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 8
                      ),
                    ),
                  ),
                ],
              )
            ]
          ),
        ),
      ),
    );
  }
}