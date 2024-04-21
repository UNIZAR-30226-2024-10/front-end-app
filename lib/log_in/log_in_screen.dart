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

void main() {
  runApp(LoginScreen());
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Stack(
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
                title: GestureDetector(
                  onTap: () {
                    GoRouter.of(context).push('/');
                  },
                  child: Text(
                    'ChessHub',
                    style: TextStyle(
                        fontFamily: 'Oswald',
                        color: Color.fromRGBO(255, 255, 255, 1)),
                  ),
                ),
              ),
              body: Center(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: LoginFormWidget(),
                ),
              ),
            ),
          ],
        ));
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

  @override
  Widget build(BuildContext context) {
    final settingsController = context.watch<SettingsController>();
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
                      settingsController
                          .toggleLoggedIn(); //AQUI HABRIA QUE PASARLE AL BACKEND LOS DATOS Y CONSULTAR EL USUARIO Y CONTRASEÑA
                      GoRouter.of(context).go('/');
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
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
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
