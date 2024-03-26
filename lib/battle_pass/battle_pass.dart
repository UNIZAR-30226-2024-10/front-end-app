import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
//import 'package:provider/provider.dart';

//import '../audio/audio_controller.dart';
//import '../audio/sounds.dart';

class BattlePass extends StatefulWidget {
  @override
  _BattlePassState createState() => _BattlePassState();
}

class _BattlePassState extends State<BattlePass> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Stack(children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/board.jpg"),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Scaffold(
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Battle Pass',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[_buildTable()],
                ),
                SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
      ]),
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
        Text('Reward 1'),
        Text('Reward 2'),
        Text('Reward 3'),
      ],
    );
  }
}
// rwq
