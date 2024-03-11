// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../audio/audio_controller.dart';
import '../audio/sounds.dart';
import '../settings/settings.dart';
//import '../style/my_button.dart';
//import '../style/palette.dart';
//import '../style/responsive_screen.dart';

class LoginScreen extends StatelessWidget {
  //Esto significa que Flutter generará automáticamente una clave única para cada instancia de MainMenuScreen.
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //final palette = context.watch<Palette>();
    final settingsController = context.watch<SettingsController>();
    final audioController = context.watch<AudioController>();

    return Stack(
      children: [
        Scaffold(
            backgroundColor: Color.fromRGBO(49, 45, 45, 1),
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
                        style:
                            TextStyle(color: Color.fromRGBO(255, 136, 0, 1))),
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
                child: Column(
              children: <Widget>[
                _gap,
                _gap,
                Container(
                    color: Color.fromRGBO(255, 136, 0, 1),
                    width: 300,
                    height: 375,
                    child: Form(
                      child: Column(
                        children: [
                          _gap,
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Nombre de usuario',
                            ),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Campos necesarios sin rellenar';
                              }
                              return null;
                            },
                          ),
                          _gap,
                          _gap,
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Contraseña',
                            ),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Campos necesarios sin rellenar';
                              }
                              return null;
                            },
                          ),
                          _gap,
                          _gap,
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll<Color>(
                                          Color.fromRGBO(49, 45, 45, 1))),
                              onPressed: () {
                                // Validate will return true if the form is valid, or false if
                                // the form is invalid.
                                if (GlobalKey<FormState>()
                                    .currentState!
                                    .validate()) {
                                  settingsController.toggleLoggedIn();
                                }
                              },
                              child: const Text('Iniciar Sesión'),
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ))),
      ],
    );
  }

  static const _gap = SizedBox(height: 33);
}
