import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
//import 'package:provider/provider.dart';

//import '../audio/audio_controller.dart';
//import '../audio/sounds.dart';

class MatchHistory extends StatefulWidget {
  @override
  _MatchHistoryState createState() => _MatchHistoryState();
}

class _MatchHistoryState extends State<MatchHistory> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
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
          title: Text('Historial',
              style: TextStyle(color: Colors.white, fontFamily: 'Oswald')),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[_buildTable()],
              ),
              SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    ]);
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
        Text('Match 1'),
        Text('Match 2'),
        Text('Match 3'),
      ],
    );
  }
}
// rwq
