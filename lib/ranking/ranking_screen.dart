import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../audio/audio_controller.dart';
import '../audio/sounds.dart';

class RankingScreen extends StatefulWidget {
  @override
  _RankingScreenState createState() => _RankingScreenState();
}

class _RankingScreenState extends State<RankingScreen> {
  @override
  Widget build(BuildContext context) {
    final audioController = context.watch<AudioController>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Ranking'),
        leading: Builder(
            builder: (context) => IconButton(
                  icon: const Icon(Icons.menu),
                  color: Color.fromRGBO(0, 0, 0, 1),
                  tooltip: 'Menu',
                  onPressed: () => Scaffold.of(context).openDrawer(),
                )),
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
                  style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1))),
              onTap: () {
                audioController.playSfx(SfxType.buttonTap);
                GoRouter.of(context).go('/ranking');
              },
            ),
            ListTile(
              title: Text('Settings',
                  style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1))),
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Ranking Coming Soon',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildTable(),
                _buildTable(),
              ],
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Back'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTable() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Text(
            'Table',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10.0),
          _buildTableRow(),
          _buildTableRow(),
          _buildTableRow(),
        ],
      ),
    );
  }

  Widget _buildTableRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text('Column 1'),
        Text('Column 2'),
        Text('Column 3'),
      ],
    );
  }
}
// rwq
