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
      home: Scaffold(
        appBar: AppBar(
          leading: Builder(
              builder: (context) => IconButton(
                    icon: const Icon(Icons.menu),
                    color: Color.fromRGBO(0, 0, 0, 1),
                    tooltip: 'Menu',
                    onPressed: () => Scaffold.of(context).openDrawer(),
                  )),
          title: Text('Login Form'),
        ),
        drawer: Drawer(
          backgroundColor: Color.fromRGBO(49, 45, 45, 1),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  shape: BoxShape.circle, //MIRAR QUE FORMA LE DOY
                  image: DecorationImage(
                    image: AssetImage("../assets/images/Logo.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: null,
              ),
              ListTile(
                title: Text(
                  'Ajedrez Demo',
                  style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
                ),
                onTap: () {
                  GoRouter.of(context).go('/chess');
                },
              ),
              ListTile(
                title: Text('Play',
                    style: TextStyle(color: Color.fromRGBO(255, 136, 0, 1))),
                onTap: () {
                  GoRouter.of(context).go('/play');
                },
              ),
              ListTile(
                title: Text('Ranking',
                    style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1))),
                onTap: () {
                  GoRouter.of(context).go('/ranking');
                },
              ),
              ListTile(
                title: Text('Settings',
                    style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1))),
                onTap: () {
                  GoRouter.of(context).push('/settings');
                },
              ),
            ],
          ),
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: LoginFormWidget(),
          ),
        ),
      ),
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

  @override
  Widget build(BuildContext context) {
    final settingsController = context.watch<SettingsController>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          controller: _usernameController,
          decoration: InputDecoration(
            labelText: 'Username',
          ),
        ),
        SizedBox(height: 20.0),
        TextField(
          controller: _passwordController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
          ),
        ),
        SizedBox(height: 20.0),
        ElevatedButton(
          onPressed: () {
            settingsController
                .toggleLoggedIn(); //AQUI HABRIA QUE PASARLE AL BACKEND LOS DATOS Y CONSULTAR EL USUARIO Y CONTRASEÑA
            GoRouter.of(context).go('/');
          },
          child: Text('Login'),
        ),
      ],
    );
  }
}
