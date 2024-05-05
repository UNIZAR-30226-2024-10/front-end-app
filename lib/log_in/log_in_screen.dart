import 'dart:io';

import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

//import '../audio/audio_controller.dart';
//import '../audio/sounds.dart';
import '../settings/settings.dart';
//import '../style/my_button.dart';
//import '../style/palette.dart';
//import '../style/responsive_screen.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(LoginScreen());
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/board2.jpg"),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(49, 45, 45, 1),
            title: Text('Log In',
                style: TextStyle(color: Colors.white, fontFamily: 'Oswald')),
          ),
          body: Center(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: LoginFormWidget(),
            ),
          ),
        ),
      ],
    );
  }
}

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({super.key});
  @override
  LoginFormWidgetState createState() => LoginFormWidgetState();
}

class LoginFormWidgetState extends State<LoginFormWidget> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _username = '';
  String _password = '';
  int id = 0;

  @override
  Widget build(BuildContext context) {
    final settingsController = context.watch<SettingsController>();

    void _login(String jsonString) async {
      // Construye la URL y realiza la solicitud POST
      //http://192.168.1.97:3001/play/
      Uri uri = Uri.parse('http://192.168.1.97:3001/users/login');
      http.Response response = await http.post(
        uri,
        body:
            jsonString, // Utiliza el contenido del archivo JSON como el cuerpo de la solicitud
        headers: {
          HttpHeaders.contentTypeHeader:
              'application/json', // Especifica el tipo de contenido como JSON
        },
      );
      Map<String, dynamic> res =
          jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 404) {
        print(res['message']);
      } else if (response.statusCode == 401) {
        print(res['message']);
      } else if (response.statusCode == 500) {
        print(res['message']);
      } else if (response.statusCode == 200) {
        print(res['message']);
        id = res['userId'] as int;
        settingsController.toggleLoggedIn();
        GoRouter.of(context).go('/');
      } else {
        throw Exception('Error en la solicitud POST: ${response.statusCode}');
      }
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
            color: Color.fromRGBO(49, 45, 45, 1),
            width: 350,
            height: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: Text('Log In',
                        style:
                            TextStyle(color: Color.fromRGBO(255, 136, 0, 1)))),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: TextField(
                    expands: false,
                    cursorColor: Color.fromRGBO(255, 136, 0, 1),
                    controller: _usernameController,
                    onChanged: (value) {
                      setState(() {
                        _username = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Username',
                      floatingLabelStyle:
                          TextStyle(color: Color.fromRGBO(255, 136, 0, 1)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(255, 136, 0,
                                1)), // Color de resaltado al hacer clic
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: TextField(
                    cursorColor: Color.fromRGBO(255, 136, 0, 1),
                    controller: _passwordController,
                    onChanged: (value) {
                      setState(() {
                        _password = value;
                      });
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      floatingLabelStyle:
                          TextStyle(color: Color.fromRGBO(255, 136, 0, 1)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(255, 136, 0,
                                1)), // Color de resaltado al hacer clic
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25.0),
                  child: ElevatedButton(
                    onPressed: () {
                      String username = _username;
                      String password = _password;
                      Map<String, dynamic> login = {
                        'nombre': username,
                        'contraseña': password
                      };
                      String jsonString = jsonEncode(login);
                      _login(jsonString);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromRGBO(255, 136, 0, 1)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    child: Text('Login',
                        style: TextStyle(color: Color.fromRGBO(49, 45, 45, 1))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0.0),
                  child: GestureDetector(
                    onTap: () {
                      GoRouter.of(context).go('/register');
                    },
                    child: Text(
                      'Si no tienes cuenta puedes registrarte aquí',
                      style: TextStyle(
                          fontSize: 15.0,
                          color: Color.fromRGBO(255, 136, 0, 1),
                          decoration: TextDecoration.underline,
                          decorationColor: Color.fromRGBO(255, 136, 0, 1)),
                    ),
                  ),
                ),
              ],
            )),
      ],
    );
  }
}
