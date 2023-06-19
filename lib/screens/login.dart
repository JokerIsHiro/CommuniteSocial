import 'package:communitesocial/responsive/mobile_layout.dart';
import 'package:communitesocial/responsive/responsive_layout.dart';
import 'package:communitesocial/responsive/web_layout.dart';
import 'package:communitesocial/screens/signup.dart';
import 'package:communitesocial/utils/colors.dart';
import 'package:communitesocial/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/services.dart';

import '../resources/auth_method.dart';
import '../widgets/button.dart';
import '../widgets/text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool passwordVisible = false;
  bool isHovering = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void irRegistro() {
    Navigator.of(context as BuildContext).pushReplacement(
      MaterialPageRoute(builder: (context) => SignUpScreen()),
    );
  }

  void loginUsuario() async {
    setState(() {
      _isLoading = true;
    });
    String response = await AutenticarMetodos().loginUsuario(
        email: _emailController.text, password: _passwordController.text);
    if (response == 'success') {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const ResponsiveLayout(
              mobileScreenLayout: MobileLayout(),
              webScreenLayout: WebLayout(),
            ),
          ),
          (route) => false);

      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      showSnackBar(context, response);
    }
  }

  @override
    void initState(){
      super.initState();
      passwordVisible=true;
    } 
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/0-1.jpg"), fit: BoxFit.cover),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Flexible(
                  child: Container(),
                  flex: 1,
                ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.asset(
                'assets/logod.png',
                height: 256,
              ),
            ]),
            const SizedBox(height: 12),
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
              suffixIcon: IconButton(
                icon: Icon(
                    passwordVisible ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(
                    () {
                      passwordVisible = !passwordVisible;
                    },
                  );
                },
              ),
              textInputType: TextInputType.visiblePassword,
              textEditingController: _passwordController,
              isPass: passwordVisible,
            ),
            const SizedBox(
              height: 24,
            ),
            LoadingBtn(
              height: 50,
              borderRadius: 8,
              animate: true,
              color: blueColor,
              width: MediaQuery.of(context).size.width * 0.45,
              loader: Container(
                padding: const EdgeInsets.all(10),
                width: 40,
                height: 40,
                child: const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
              child: const Text("Iniciar Sesión"),
              onTap: (startLoading, stopLoading, btnState) async {
                if (btnState == ButtonState.idle) {
                  startLoading();
                  await Future.delayed(const Duration(seconds: 2));
                  loginUsuario();
                  stopLoading();
                }
              },
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
                  padding: const EdgeInsets.symmetric(vertical: 8),
                ),
                Container(
                  child: InkWell(
                    onTap: irRegistro,
                    onHover: (hovering) {
                      setState(() {
                        isHovering = hovering;
                      });
                    },
                    child: Text(
                      "Regístrate.",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isHovering ? Colors.blue : Colors.white),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
