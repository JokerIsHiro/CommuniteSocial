import 'package:communitesocial/resources/auth_method.dart';
import 'package:communitesocial/screens/login.dart';
import 'package:communitesocial/utils/colors.dart';
import 'package:communitesocial/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_text_fields/material_text_fields.dart';
import 'package:material_text_fields/theme/material_text_field_theme.dart';
import 'package:material_text_fields/utils/form_validation.dart';

import '../widgets/button.dart';
import '../widgets/text_field.dart';

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
  bool passwordVisible = false;
  bool isHovering = false;

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void registrarUsuario() async {
    String response = await AutenticarMetodos().registroUsuario(
        username: _usernameController.text,
        email: _emailController.text,
        passwd: _passwordController.text,
        file: _image!);
    if (response == "success") {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginScreen()));
    } else {
      showSnackBar(context, response);
    }
  }

  void irLogin() {
    Navigator.of(context as BuildContext).pushReplacement(
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/0-1.jpg"), fit: BoxFit.cover),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Flexible(
              child: Container(),
              flex: 2,
            ),
            const SizedBox(
              height: 54,
              child: Text(
                "Registrate",
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Stack(
              children: [
                _image != null
                    ? CircleAvatar(
                        radius: 64,
                        backgroundImage: MemoryImage(_image!),
                      )
                    : const CircleAvatar(
                        radius: 64,
                        backgroundImage: NetworkImage(
                            "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Default_pfp.svg/1200px-Default_pfp.svg.png"),
                      ),
                Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(
                        Icons.add_a_photo,
                      ),
                    )),
              ],
            ),
            const SizedBox(height: 24),
           TextFieldInput(
              hintText: "Inserte su Usuario",
              textInputType: TextInputType.emailAddress,
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
              child: const Text("Registrar"),
              onTap: (startLoading, stopLoading, btnState) async {
                if (btnState == ButtonState.idle) {
                  startLoading();
                  await Future.delayed(const Duration(seconds: 2));
                  registrarUsuario();
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
                  child: const Text("Tienes cuenta ya? "),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                ),
                Container(
                  child: InkWell(
                    onTap: irLogin,
                    onHover: (hovering) {
                      setState(() {
                        isHovering = hovering;
                      });
                    },
                    child: Text(
                      "Iniciar Sesión.",
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
