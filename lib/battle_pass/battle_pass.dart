import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../style/header.dart';

class BattlePass extends StatefulWidget {
  @override
  _BattlePassState createState() => _BattlePassState();
}

class Tier {
  final int level;
  final String reward;
  final String rewardType;
  final String requiredPoints;

  Tier({
    required this.level,
    required this.reward,
    required this.rewardType,
    required this.requiredPoints,
  });
}

final List<Tier> tiers = [
  Tier(level: 1, reward: '😁️', rewardType: 'emoticono', requiredPoints: '10'),
  Tier(level: 2, reward: 'alpha', rewardType: 'pieza', requiredPoints: '20'),
  Tier(level: 3, reward: '😂️', rewardType: 'emoticono', requiredPoints: '30'),
  Tier(level: 4, reward: 'cardinal', rewardType: 'pieza', requiredPoints: '40'),
  Tier(level: 5, reward: '👍️', rewardType: 'emoticono', requiredPoints: '50'),
  Tier(level: 6, reward: 'celtic', rewardType: 'pieza', requiredPoints: '60'),
  Tier(level: 7, reward: '😎️', rewardType: 'emoticono', requiredPoints: '70'),
  Tier(level: 8, reward: 'chess7', rewardType: 'pieza', requiredPoints: '80'),
  Tier(level: 9, reward: '😭️', rewardType: 'emoticono', requiredPoints: '90'),
  Tier(
      level: 10,
      reward: 'chessnut',
      rewardType: 'pieza',
      requiredPoints: '100'),
  Tier(
      level: 11, reward: '😅️', rewardType: 'emoticono', requiredPoints: '110'),
  Tier(
      level: 12,
      reward: 'companion',
      rewardType: 'pieza',
      requiredPoints: '120'),
  Tier(
      level: 13, reward: '👊️', rewardType: 'emoticono', requiredPoints: '130'),
  Tier(
      level: 14, reward: 'fantasy', rewardType: 'pieza', requiredPoints: '140'),
  Tier(
      level: 15, reward: '🤩️', rewardType: 'emoticono', requiredPoints: '150'),
  Tier(level: 16, reward: 'fresca', rewardType: 'pieza', requiredPoints: '160'),
  Tier(
      level: 17, reward: '🤯️', rewardType: 'emoticono', requiredPoints: '170'),
  Tier(
      level: 18,
      reward: 'governor',
      rewardType: 'pieza',
      requiredPoints: '180'),
  Tier(
      level: 19, reward: '😜️', rewardType: 'emoticono', requiredPoints: '190'),
  Tier(level: 20, reward: 'kosal', rewardType: 'pieza', requiredPoints: '200'),
  Tier(
      level: 21, reward: '🫠️', rewardType: 'emoticono', requiredPoints: '210'),
  Tier(
      level: 22, reward: 'leipzig', rewardType: 'pieza', requiredPoints: '220'),
  Tier(
      level: 23, reward: '😎️', rewardType: 'emoticono', requiredPoints: '230'),
  Tier(
      level: 24, reward: 'mpchess', rewardType: 'pieza', requiredPoints: '240'),
  Tier(
      level: 25, reward: '😡️', rewardType: 'emoticono', requiredPoints: '250'),
  Tier(level: 26, reward: 'pixel', rewardType: 'pieza', requiredPoints: '260'),
  Tier(
      level: 27, reward: '😈️', rewardType: 'emoticono', requiredPoints: '270'),
  Tier(
      level: 28, reward: 'maestro', rewardType: 'pieza', requiredPoints: '280'),
  Tier(
      level: 29, reward: '👻️', rewardType: 'emoticono', requiredPoints: '290'),
  Tier(
      level: 30,
      reward: 'anarcandy',
      rewardType: 'pieza',
      requiredPoints: '300'),
];

class _BattlePassState extends State<BattlePass> {
  @override
  Widget build(BuildContext context) {
    // Ordenar los tiers por nivel
    tiers.sort((a, b) => a.level.compareTo(b.level));
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
                Navigator.pop(context);
              },
              child: Text(
                'ChessHub',
                style: TextStyle(
                  fontFamily: 'Oswald',
                  color: Color.fromRGBO(255, 255, 255, 1),
                ),
              ),
            ),
          ),
          body: Container(
            color: Colors.transparent,
            child: ListView.builder(
              itemCount: tiers.length,
              itemBuilder: (context, index) {
                final tier = tiers[index];

                return Card(
                  elevation: 3,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  color: Color.fromRGBO(
                      49, 45, 45, 1), // Cambia el color de fondo de la tarjeta
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Recompensa ${tier.level}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Text('Puntos requeridos: ${tier.requiredPoints}',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.orange)),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Tipo de recompensa: ${tier.rewardType}',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.orange),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment
                              .center, // Centra las imágenes y los emoticonos
                          children: [
                            if (tier.rewardType == 'pieza') ...[
                              SvgPicture.asset(
                                'assets/images/images_pase/pieces/${tier.reward}/bK.svg',
                                width: 42,
                                height: 42,
                              ),
                              SizedBox(width: 8),
                              SvgPicture.asset(
                                'assets/images/images_pase/pieces/${tier.reward}/wQ.svg',
                                width: 42,
                                height: 42,
                              ),
                            ],
                            if (tier.rewardType == 'emoticono')
                              Text(
                                tier.reward,
                                style: TextStyle(
                                    fontSize: 42, color: Colors.white),
                              ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.center, // Centra el botón
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // Lógica para reclamar la recompensa
                              },
                              child: Text('Reclamar'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ]),
    );
  }
}
