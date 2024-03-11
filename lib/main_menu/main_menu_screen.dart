// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../audio/audio_controller.dart';
import '../audio/sounds.dart';
import '../settings/settings.dart';
//import '../style/my_button.dart';
//import '../style/palette.dart';
//import '../style/responsive_screen.dart';

class MainMenuScreen extends StatelessWidget {
  //Esto significa que Flutter generará automáticamente una clave única para cada instancia de MainMenuScreen.
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //final palette = context.watch<Palette>();
    final settingsController = context.watch<SettingsController>();
    final audioController = context.watch<AudioController>();

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("../assets/images/board.jpg"),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(49, 45, 45, 1),
            leading: Builder(
                builder: (context) => IconButton(
                      icon: const Icon(Icons.menu),
                      color: Color.fromRGBO(255, 255, 255, 1),
                      tooltip: 'Menu',
                      onPressed: () => Scaffold.of(context).openDrawer(),
                    )),
            title: GestureDetector(
              onTap: () {},
              child: Text(
                'ChessHub',
                style: TextStyle(
                    fontFamily: 'Oswald',
                    color: Color.fromRGBO(255, 255, 255, 1)),
              ),
            ),
            actions: <Widget>[
              ValueListenableBuilder<bool>(
                valueListenable: settingsController.loggedIn,
                builder: (context, loggedIn, child) {
                  return IconButton(
                    tooltip: loggedIn ? 'Account' : 'Log In',
                    onPressed: () => loggedIn
                        ? settingsController
                            .toggleLoggedIn() //CUANDO HAYA, TE LLEVARA A LA PAGINA DE USUARIO
                        : GoRouter.of(context).push(
                            '/login'), //settingsController.toggleLoggedIn(),
                    icon: Icon(
                        loggedIn ? Icons.account_circle_sharp : Icons.login),
                    color: Color.fromRGBO(255, 255, 255, 1),
                  );
                },
              ),
            ],
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
                    audioController.playSfx(SfxType.buttonTap);
                    GoRouter.of(context).go('/chess');
                  },
                ),
                ListTile(
                  title: Text('Play',
                      style: TextStyle(color: Color.fromRGBO(255, 136, 0, 1))),
                  onTap: () {
                    audioController.playSfx(SfxType.buttonTap);
                    GoRouter.of(context).go('/play');
                  },
                ),
                ListTile(
                  title: Text('Ranking',
                      style:
                          TextStyle(color: Color.fromRGBO(255, 255, 255, 1))),
                  onTap: () {
                    audioController.playSfx(SfxType.buttonTap);
                    GoRouter.of(context).go('/ranking');
                  },
                ),
                ListTile(
                  title: Text('Settings',
                      style:
                          TextStyle(color: Color.fromRGBO(255, 255, 255, 1))),
                  onTap: () {
                    audioController.playSfx(SfxType.buttonTap);
                    GoRouter.of(context).push('/settings');
                  },
                ),
              ],
            ),
          ),
          body: Center(
              child: Container(
                  color: Color.fromRGBO(49, 45, 45, 1),
                  width: 300,
                  height: 375,
                  child: Center(
                      child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Modos de juego: \n\n',
                      style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontSize: 33),
                      children: const <TextSpan>[
                        TextSpan(
                            text: 'Bullet: 1 minuto de juego \n\n',
                            style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 1),
                                fontSize: 20)),
                        TextSpan(
                            text: 'Blitz: 3 minutos de juego \n\n',
                            style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 1),
                                fontSize: 20)),
                        TextSpan(
                            text: 'Rapid: 10 minutos de juego \n\n',
                            style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 1),
                                fontSize: 20)),
                      ],
                    ),
                  )))),
        )
      ],
    );
  }

  //static const _gap = SizedBox(height: 66);
}
