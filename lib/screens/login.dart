import 'package:communitesocial/responsive/mobile_layout.dart';
import 'package:communitesocial/responsive/responsive_layout.dart';
import 'package:communitesocial/responsive/web_layout.dart';
import 'package:communitesocial/screens/home_screen.dart';
import 'package:communitesocial/screens/signup.dart';
import 'package:communitesocial/utils/colors.dart';
import 'package:communitesocial/utils/utils.dart';
import 'package:communitesocial/widgets/textinput.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../resources/auth_method.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose(){
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void irRegistro(){
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => SignUpScreen()
      ),
    );
  }

  void loginUsuario() async {
    setState(() {
      _isLoading = true;
    });
    String response = await AutenticarMetodos().loginUsuario(
      email: _emailController.text, 
      password: _passwordController.text
    );
    if(response=="success"){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
    }else{
      showSnackBar(response, context);
    }
    setState(() {
      _isLoading = false;
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
                onTap: loginUsuario,
                child:Container(
                  child: _isLoading ? 
                  const Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  )
                  : const Text("Iniciar Sesión"),
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
                    child: const Text("No tienes una cuenta? "),
                    padding: const EdgeInsets.symmetric(
                      vertical: 8
                    ),
                  ),
                  GestureDetector(
                  onTap: irRegistro,
                  child: Container(
                    child: const Text("Registrate.", 
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