import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color.fromRGBO(49, 45, 45, 1),
      title: GestureDetector(
        onTap: () {
          GoRouter.of(context).push('/');
        },
        child: Text(
          'ChessHub',
          style: TextStyle(
            fontFamily: 'Oswald',
            color: Color.fromRGBO(255, 255, 255, 1),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

