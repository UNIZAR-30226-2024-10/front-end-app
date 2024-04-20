import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../style/my_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
            initialIndex: 0,
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
    child: switch (rewardNumber) {
      1 => Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Text(
            'Cardinal ',
            style: TextStyle(fontSize: 32.0),
          ),
          SvgPicture.asset(
            '../assets/images/images_pase/pieces/cardinal/bK.svg',
            width: 75,
            height: 75,
            fit: BoxFit.fill,
          ),
          SvgPicture.asset(
            '../assets/images/images_pase/pieces/cardinal/wQ.svg', // Asegúrate de tener imágenes llamadas recompensa_1.jpg, recompensa_2.jpg, etc., en la carpeta assets/images/
            width: 75,
            height: 75,
            fit: BoxFit.fill,
          )
        ]),
      2 => Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Text(
            'Chessnut ',
            style: TextStyle(fontSize: 32.0),
          ),
          SvgPicture.asset(
            '../assets/images/images_pase/pieces/chessnut/bK.svg',
            width: 75,
            height: 75,
            fit: BoxFit.fill,
          ),
          SvgPicture.asset(
            '../assets/images/images_pase/pieces/chessnut/wQ.svg', // Asegúrate de tener imágenes llamadas recompensa_1.jpg, recompensa_2.jpg, etc., en la carpeta assets/images/
            width: 75,
            height: 75,
            fit: BoxFit.fill,
          )
        ]),
      3 => Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Text(
            'Fantasy  ',
            style: TextStyle(fontSize: 32.0),
          ),
          SvgPicture.asset(
            '../assets/images/images_pase/pieces/fantasy/bK.svg',
            width: 75,
            height: 75,
            fit: BoxFit.fill,
          ),
          SvgPicture.asset(
            '../assets/images/images_pase/pieces/fantasy/wQ.svg', // Asegúrate de tener imágenes llamadas recompensa_1.jpg, recompensa_2.jpg, etc., en la carpeta assets/images/
            width: 75,
            height: 75,
            fit: BoxFit.fill,
          )
        ]),
      4 => Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Text(
            'Companion',
            style: TextStyle(fontSize: 32.0),
          ),
          SvgPicture.asset(
            '../assets/images/images_pase/pieces/companion/bK.svg',
            width: 75,
            height: 75,
            fit: BoxFit.fill,
          ),
          SvgPicture.asset(
            '../assets/images/images_pase/pieces/companion/wQ.svg', // Asegúrate de tener imágenes llamadas recompensa_1.jpg, recompensa_2.jpg, etc., en la carpeta assets/images/
            width: 75,
            height: 75,
            fit: BoxFit.fill,
          )
        ]),
      5 => Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Text(
            'Mpchess  ',
            style: TextStyle(fontSize: 32.0),
          ),
          SvgPicture.asset(
            '../assets/images/images_pase/pieces/mpchess/bK.svg',
            width: 75,
            height: 75,
            fit: BoxFit.fill,
          ),
          SvgPicture.asset(
            '../assets/images/images_pase/pieces/mpchess/wQ.svg', // Asegúrate de tener imágenes llamadas recompensa_1.jpg, recompensa_2.jpg, etc., en la carpeta assets/images/
            width: 75,
            height: 75,
            fit: BoxFit.fill,
          )
        ]),
      6 => Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Text(
            'Kosal    ',
            style: TextStyle(fontSize: 32.0),
          ),
          SvgPicture.asset(
            '../assets/images/images_pase/pieces/kosal/bK.svg',
            width: 75,
            height: 75,
            fit: BoxFit.fill,
          ),
          SvgPicture.asset(
            '../assets/images/images_pase/pieces/kosal/wQ.svg', // Asegúrate de tener imágenes llamadas recompensa_1.jpg, recompensa_2.jpg, etc., en la carpeta assets/images/
            width: 75,
            height: 75,
            fit: BoxFit.fill,
          )
        ]),
      7 => Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Text(
            'Governor ',
            style: TextStyle(fontSize: 32.0),
          ),
          SvgPicture.asset(
            '../assets/images/images_pase/pieces/governor/bK.svg',
            width: 75,
            height: 75,
            fit: BoxFit.fill,
          ),
          SvgPicture.asset(
            '../assets/images/images_pase/pieces/governor/wQ.svg', // Asegúrate de tener imágenes llamadas recompensa_1.jpg, recompensa_2.jpg, etc., en la carpeta assets/images/
            width: 75,
            height: 75,
            fit: BoxFit.fill,
          )
        ]),
      8 => Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Text(
            'Pixel    ',
            style: TextStyle(fontSize: 32.0),
          ),
          SvgPicture.asset(
            '../assets/images/images_pase/pieces/pixel/bK.svg',
            width: 75,
            height: 75,
            fit: BoxFit.fill,
          ),
          SvgPicture.asset(
            '../assets/images/images_pase/pieces/pixel/wQ.svg', // Asegúrate de tener imágenes llamadas recompensa_1.jpg, recompensa_2.jpg, etc., en la carpeta assets/images/
            width: 75,
            height: 75,
            fit: BoxFit.fill,
          )
        ]),
      9 => Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Text(
            'Leipzig  ',
            style: TextStyle(fontSize: 32.0),
          ),
          SvgPicture.asset(
            '../assets/images/images_pase/pieces/leipzig/bK.svg',
            width: 75,
            height: 75,
            fit: BoxFit.fill,
          ),
          SvgPicture.asset(
            '../assets/images/images_pase/pieces/leipzig/wQ.svg', // Asegúrate de tener imágenes llamadas recompensa_1.jpg, recompensa_2.jpg, etc., en la carpeta assets/images/
            width: 75,
            height: 75,
            fit: BoxFit.fill,
          )
        ]),
      10 => Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Text(
            'Chess7   ',
            style: TextStyle(fontSize: 32.0),
          ),
          SvgPicture.asset(
            '../assets/images/images_pase/pieces/chess7/bK.svg',
            width: 75,
            height: 75,
            fit: BoxFit.fill,
          ),
          SvgPicture.asset(
            '../assets/images/images_pase/pieces/chess7/wQ.svg', // Asegúrate de tener imágenes llamadas recompensa_1.jpg, recompensa_2.jpg, etc., en la carpeta assets/images/
            width: 75,
            height: 75,
            fit: BoxFit.fill,
          )
        ]),
      11 => Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Text(
            'Maestro  ',
            style: TextStyle(fontSize: 32.0),
          ),
          SvgPicture.asset(
            '../assets/images/images_pase/pieces/maestro/bK.svg',
            width: 75,
            height: 75,
            fit: BoxFit.fill,
          ),
          SvgPicture.asset(
            '../assets/images/images_pase/pieces/maestro/wQ.svg', // Asegúrate de tener imágenes llamadas recompensa_1.jpg, recompensa_2.jpg, etc., en la carpeta assets/images/
            width: 75,
            height: 75,
            fit: BoxFit.fill,
          )
        ]),
      12 => Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Text(
            'Fresca   ',
            style: TextStyle(fontSize: 32.0),
          ),
          SvgPicture.asset(
            '../assets/images/images_pase/pieces/fresca/bK.svg',
            width: 75,
            height: 75,
            fit: BoxFit.fill,
          ),
          SvgPicture.asset(
            '../assets/images/images_pase/pieces/fresca/wQ.svg', // Asegúrate de tener imágenes llamadas recompensa_1.jpg, recompensa_2.jpg, etc., en la carpeta assets/images/
            width: 75,
            height: 75,
            fit: BoxFit.fill,
          )
        ]),
      13 => Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Text(
            'Cburnett ',
            style: TextStyle(fontSize: 32.0),
          ),
          SvgPicture.asset(
            '../assets/images/images_pase/pieces/cburnett/bK.svg',
            width: 75,
            height: 75,
            fit: BoxFit.fill,
          ),
          SvgPicture.asset(
            '../assets/images/images_pase/pieces/cburnett/wQ.svg', // Asegúrate de tener imágenes llamadas recompensa_1.jpg, recompensa_2.jpg, etc., en la carpeta assets/images/
            width: 75,
            height: 75,
            fit: BoxFit.fill,
          )
        ]),
      14 => Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Text(
            'Celtic   ',
            style: TextStyle(fontSize: 32.0),
          ),
          SvgPicture.asset(
            '../assets/images/images_pase/pieces/celtic/bK.svg',
            width: 75,
            height: 75,
            fit: BoxFit.fill,
          ),
          SvgPicture.asset(
            '../assets/images/images_pase/pieces/celtic/wQ.svg', // Asegúrate de tener imágenes llamadas recompensa_1.jpg, recompensa_2.jpg, etc., en la carpeta assets/images/
            width: 75,
            height: 75,
            fit: BoxFit.fill,
          )
        ]),
      15 => Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Text(
            'Anarcandy',
            style: TextStyle(fontSize: 32.0),
          ),
          SvgPicture.asset(
            '../assets/images/images_pase/pieces/anarcandy/bK.svg',
            width: 75,
            height: 75,
            fit: BoxFit.fill,
          ),
          SvgPicture.asset(
            '../assets/images/images_pase/pieces/anarcandy/wQ.svg', // Asegúrate de tener imágenes llamadas recompensa_1.jpg, recompensa_2.jpg, etc., en la carpeta assets/images/
            width: 75,
            height: 75,
            fit: BoxFit.fill,
          )
        ]),
      _ =>
        Container(), // Return an empty container if rewardNumber is not within the specified range
    },
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
    child: switch (rewardNumber) {
      1 => Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Text(
            '😈️',
            style: TextStyle(fontSize: 32.0),
          ),
        ]),
      2 => Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          SvgPicture.asset(
            '../assets/images/images_pase/pieces/chessnut/bK.svg',
            width: 75,
            height: 75,
            fit: BoxFit.fill,
          ),
        ]),
      3 => Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          SvgPicture.asset(
            '../assets/images/images_pase/pieces/fantasy/bK.svg',
            width: 75,
            height: 75,
            fit: BoxFit.fill,
          ),
        ]),
      4 => Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          SvgPicture.asset(
            '../assets/images/images_pase/pieces/companion/bK.svg',
            width: 75,
            height: 75,
            fit: BoxFit.fill,
          ),
        ]),
      5 => Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          SvgPicture.asset(
            '../assets/images/images_pase/pieces/mpchess/bK.svg',
            width: 75,
            height: 75,
            fit: BoxFit.fill,
          ),
        ]),
      6 => Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          SvgPicture.asset(
            '../assets/images/images_pase/pieces/kosal/bK.svg',
            width: 75,
            height: 75,
            fit: BoxFit.fill,
          ),
        ]),
      7 => Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          SvgPicture.asset(
            '../assets/images/images_pase/pieces/governor/bK.svg',
            width: 75,
            height: 75,
            fit: BoxFit.fill,
          ),
        ]),
      8 => Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          SvgPicture.asset(
            '../assets/images/images_pase/pieces/pixel/bK.svg',
            width: 75,
            height: 75,
            fit: BoxFit.fill,
          ),
        ]),
      9 => Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          SvgPicture.asset(
            '../assets/images/images_pase/pieces/leipzig/bK.svg',
            width: 75,
            height: 75,
            fit: BoxFit.fill,
          ),
        ]),
      10 => Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          SvgPicture.asset(
            '../assets/images/images_pase/pieces/chess7/bK.svg',
            width: 75,
            height: 75,
            fit: BoxFit.fill,
          ),
        ]),
      11 => Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          SvgPicture.asset(
            '../assets/images/images_pase/pieces/maestro/bK.svg',
            width: 75,
            height: 75,
            fit: BoxFit.fill,
          ),
        ]),
      12 => Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          SvgPicture.asset(
            '../assets/images/images_pase/pieces/fresca/bK.svg',
            width: 75,
            height: 75,
            fit: BoxFit.fill,
          ),
        ]),
      13 => Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          SvgPicture.asset(
            '../assets/images/images_pase/pieces/cburnett/bK.svg',
            width: 75,
            height: 75,
            fit: BoxFit.fill,
          ),
        ]),
      14 => Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          SvgPicture.asset(
            '../assets/images/images_pase/pieces/celtic/bK.svg',
            width: 75,
            height: 75,
            fit: BoxFit.fill,
          ),
        ]),
      15 => Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          SvgPicture.asset(
            '../assets/images/images_pase/pieces/anarcandy/bK.svg',
            width: 75,
            height: 75,
            fit: BoxFit.fill,
          ),
        ]),
      _ =>
        Container(), // Return an empty container if rewardNumber is not within the specified range
    },
  );
}
