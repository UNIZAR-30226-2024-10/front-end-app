import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../style/my_button.dart';

class Personalizacion extends StatelessWidget {
  bool _isSwitched = false;
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
          DefaultTabController(
            initialIndex: 1,
            length: 2,
            child: Scaffold(
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
                bottom: const TabBar(
                  labelColor: Color.fromRGBO(255, 136, 0, 1),
                  indicatorColor: Color.fromRGBO(255, 136, 0, 1),
                  overlayColor: MaterialStatePropertyAll(Colors.transparent),
                  tabs: <Widget>[
                    Tab(
                      icon: Icon(Icons.brush),
                    ),
                    Tab(
                      icon: Icon(Icons.emoji_emotions),
                    ),
                  ],
                ),
              ),
              body: TabBarView(
                children: <Widget>[
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    color: Color.fromRGBO(49, 45, 45, 1),
                    margin: const EdgeInsets.all(16.0),
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                          children: List.generate(
                            15,
                            (index) => _buildPieceRow(index + 1),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    color: Color.fromRGBO(49, 45, 45, 1),
                    margin: const EdgeInsets.all(16.0),
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                          children: List.generate(
                            15,
                            (index) => _buildEmoteRow(index + 1),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]));
  }
}

Widget _buildPieceRow(int rewardNumber) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 5.0),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      border: Border.all(),
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          'Set $rewardNumber',
          style: TextStyle(fontSize: 32.0),
        ),
        /*Image.asset(
          'assets/images/recompensa_$rewardNumber.jpg', // Asegúrate de tener imágenes llamadas recompensa_1.jpg, recompensa_2.jpg, etc., en la carpeta assets/images/
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),*/
      ],
    ),
  );
}

Widget _buildEmoteRow(int rewardNumber) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 5.0),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      border: Border.all(),
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          'Emote $rewardNumber',
          style: TextStyle(fontSize: 32.0),
        ),
        /*Image.asset(
          'assets/images/recompensa_$rewardNumber.jpg', // Asegúrate de tener imágenes llamadas recompensa_1.jpg, recompensa_2.jpg, etc., en la carpeta assets/images/
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),*/
      ],
    ),
  );
}
