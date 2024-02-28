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
              image: AssetImage("../assets/images/home_background.jpeg"),
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
            title: const Text(
              'ChessHub',
              style: TextStyle(
                  fontFamily: 'Oswald',
                  color: Color.fromRGBO(255, 255, 255, 1)),
            ),
            actions: <Widget>[
              IconButton(
                //icon: Icon(audioOn ? Icons.volume_up : Icons.volume_off) MIRAR SI HACE FALTA HACER UN STATEFULWIDGET PARA ESTO
                icon: const Icon(Icons.account_circle_sharp),
                color: Color.fromRGBO(255, 255, 255, 1),
                tooltip: 'Log In',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Prueba Log In')));
                },
              )
            ],
          ),
          drawer: Drawer(
            backgroundColor: Color.fromRGBO(49, 45, 45, 1),
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
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
                      style:
                          TextStyle(color: Color.fromRGBO(255, 255, 255, 1))),
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
            heightFactor: 1.5,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: ValueListenableBuilder<bool>(
                    valueListenable: settingsController.audioOn,
                    builder: (context, audioOn, child) {
                      return IconButton(
                        onPressed: () => settingsController.toggleAudioOn(),
                        icon:
                            Icon(audioOn ? Icons.volume_up : Icons.volume_off),
                        color: Color.fromRGBO(255, 136, 0, 1),
                      );
                    },
                  ),
                ),
                const Text(
                  'Music by Mr Smith',
                  style: TextStyle(color: Color.fromRGBO(255, 136, 0, 1)),
                ),
                _gap,
              ],
            ),
          ),
        ),
      ],
    );
  }

  static const _gap = SizedBox(height: 66);
}
