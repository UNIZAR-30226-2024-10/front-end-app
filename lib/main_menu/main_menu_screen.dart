// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:ChessHub/battle_pass/battle_pass.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ChessHub/main_menu/introduction_screen.dart';
import '../audio/audio_controller.dart';
import 'package:ChessHub/log_in/log_in_screen.dart';
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

    return Consumer<LoginState>(
      builder: (context,value,child) =>Stack(
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
                      if (!loggedIn) {
                        return IconButton(
                          tooltip: 'Log In',
                          onPressed: () => GoRouter.of(context).push('/login'),
                          icon: Icon(Icons.login),
                          color: Color.fromRGBO(255, 255, 255, 1),
                        );
                      } else {
                        return PopupMenuButton(
                          icon: Icon(Icons.account_circle_sharp),
                          iconColor: Color.fromRGBO(255, 255, 255, 1),
                          tooltip: "User",
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: 'profile',
                              child: Text('Profile'),
                            ),
                            PopupMenuItem(
                              value: 'logout',
                              child: Text('Log out'),
                            ),
                          ],
                          onSelected: (value) {
                            if (value == 'profile') {
                              GoRouter.of(context).push('/profile');
                            } else if (value == 'logout') {
                              settingsController.toggleLoggedIn();
                            }
                          },
                        );
                      }
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
                          image: AssetImage("assets/images/Logo.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: null,
                    ),
                    ListTile(
                      title: Text('Jugar',
                          style:
                              TextStyle(color: Color.fromRGBO(255, 136, 0, 1))),
                      onTap: () {
                        audioController.playSfx(SfxType.buttonTap);
                        GoRouter.of(context).go('/chess');
                      },
                    ),
                    ListTile(
                      title: Text('Personalización',
                          style:
                              TextStyle(color: Color.fromRGBO(255, 255, 255, 1))),
                      onTap: () {
                        audioController.playSfx(SfxType.buttonTap);
                        GoRouter.of(context).push('/personalizacion');
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
                      title: Text('Arenas',
                          style:
                              TextStyle(color: Color.fromRGBO(255, 255, 255, 1))),
                      onTap: () {
                        audioController.playSfx(SfxType.buttonTap);
                        GoRouter.of(context).go('/arenas');
                      },
                    ),
                    ListTile(
                      title: Text('Pase de Batalla',
                          style:
                              TextStyle(color: Color.fromRGBO(255, 255, 255, 1))),
                      onTap: () {
                        audioController.playSfx(SfxType.buttonTap);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BattlePass(puntos: value.puntosPase, id:value.id)
                          ),
                        );
                      },
                    ),
                    ListTile(
                      title: Text('Historial',
                          style:
                              TextStyle(color: Color.fromRGBO(255, 255, 255, 1))),
                      onTap: () {
                        audioController.playSfx(SfxType.buttonTap);
                        GoRouter.of(context).push('/history');
                      },
                    ),
                    ListTile(
                      title: Text('Ajustes',
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
              //INFORMACION DEL JUEGO
              body: Center(
                  child: Padding(
                padding: EdgeInsets.only(
                  left: 30,
                  right: 30,
                  top: 30,
                  bottom: 30,
                ),
                child: IntroductionScreen(),
              )))
        ],
      ),
    );
  }

  //static const _gap = SizedBox(height: 66);
}
