import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class NavegacionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _NotificationModel(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
          title: Text(
            "Notifications Page",
          ),
        ),
        floatingActionButton: BotonFlotante(),
        bottomNavigationBar: BottomNavigation(),
      ),
    );
  }
}

class BottomNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final int number = Provider.of<_NotificationModel>(context).number;

    return BottomNavigationBar(
      currentIndex: 0,
      selectedItemColor: Colors.pink,
      items: [
        BottomNavigationBarItem(
          title: Text("Bones"),
          icon: FaIcon(FontAwesomeIcons.bone),
        ),
        BottomNavigationBarItem(
          title: Text("Notifications"),
          icon: Stack(
            children: <Widget>[
              FaIcon(FontAwesomeIcons.bell),
              Positioned(
                top: 0,
                right: 0,
                child: BounceInDown(
                  from: 10,
                  animate: (number > 0) ? true : false,
                  child: Bounce(
                    from: 10,
                    controller: (controller) =>
                        Provider.of<_NotificationModel>(context)
                            .bounceController = controller,
                    child: Container(
                      child: Text(
                        "$number",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 7,
                        ),
                      ),
                      alignment: Alignment.center,
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        BottomNavigationBarItem(
          title: Text("My Dog"),
          icon: FaIcon(FontAwesomeIcons.dog),
        ),
      ],
    );
  }
}

class BotonFlotante extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: FaIcon(FontAwesomeIcons.play),
      backgroundColor: Colors.pink,
      onPressed: () {
        final notificationModel =
            Provider.of<_NotificationModel>(context, listen: false);
        int number = notificationModel.number;
        number++;
        notificationModel.number = number;

        if (number >= 2) {
          final controller = notificationModel.bounceController;
          controller.forward(from: 0);
        }
      },
    );
  }
}

class _NotificationModel extends ChangeNotifier {
  int _number = 0;
  AnimationController _bounceController;

  int get number => this._number;

  set number(int value) {
    this._number = value;
    notifyListeners();
  }

  AnimationController get bounceController => this._bounceController;

  set bounceController(AnimationController controller) {
    this._bounceController = controller;
    notifyListeners();
  }
}
