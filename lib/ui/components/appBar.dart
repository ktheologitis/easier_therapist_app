import 'package:flutter/material.dart';

import '../styles/colorsIcons.dart';
import 'floatingButton.dart';

class EasierAppBar extends StatelessWidget implements PreferredSizeWidget {
  EasierAppBar({required this.title, required this.showDialog});

  final String title;
  final Future<void> Function(BuildContext context) showDialog;

  @override
  Size get preferredSize => const Size.fromHeight(112.0);

  @override
  Widget build(BuildContext context) {
    final String? currentRouteName = ModalRoute.of(context)?.settings.name;
    print(currentRouteName);

    return AppBar(
      elevation: 8,
      title: Text(
        title,
        style: TextStyle(
            fontSize: Theme.of(context).textTheme.headline4?.fontSize),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingButton(
            color: MyColors.secondary,
            icon: Icon(Icons.add),
            title: "ADD NEW CLIENT",
            action: () => showDialog(context),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: IconButton(
            onPressed: () => print("My profile"),
            icon: Icon(
              Icons.account_circle,
              size: 26,
            ),
          ),
        )
      ],
      bottom: TabBar(
        indicatorWeight: 3.0,
        indicatorColor: Theme.of(context).primaryColor,
        unselectedLabelColor: Colors.grey[500],
        tabs: [
          Tab(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.person_search),
                SizedBox(width: 16.0),
                Text(
                  "MY CLIENTS",
                  style: TextStyle(
                    fontSize: 14,
                    letterSpacing: 1.25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.assignment),
                SizedBox(width: 16.0),
                Text(
                  "HOMEWORK POOL",
                  style: TextStyle(
                    fontSize: 14,
                    letterSpacing: 1.25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class EasierAppBarAlternative extends StatelessWidget
    implements PreferredSizeWidget {
  EasierAppBarAlternative({required this.title, required this.showDialog});

  final String title;
  final Future<void> Function(BuildContext context) showDialog;
  @override
  Size get preferredSize => Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    final String? routeName = ModalRoute.of(context)?.settings.name;
    print(routeName);
    final width = MediaQuery.of(context).size.width;

    return AppBar(
      title: Text(
        title,
        style: TextStyle(
            fontSize: Theme.of(context).textTheme.headline4?.fontSize),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingButton(
            color: MyColors.secondary,
            icon: Icon(Icons.add),
            title: "ADD NEW CLIENT",
            action: () => showDialog(context),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: IconButton(
            onPressed: () => print("My profile"),
            icon: Icon(
              Icons.account_circle,
              size: 26,
            ),
          ),
        )
      ],
    );
  }
}
