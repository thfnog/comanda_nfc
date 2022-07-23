import 'package:flutter/material.dart';

import 'register_client_form.dart';

class FloatButtonMenu extends StatefulWidget {
  const FloatButtonMenu({Key? key}) : super(key: key);

  @override
  _FloatButtonMenuState createState() => _FloatButtonMenuState();
}

class _FloatButtonMenuState extends State<FloatButtonMenu>
    with SingleTickerProviderStateMixin {
  // Animation controller
  late AnimationController _animationController;

  // This is used to animate the icon of the main FAB
  late Animation<double> _buttonAnimatedIcon;

  // This is used for the child FABs
  late Animation<double> _translateButton;

  // This variable determnies whether the child FABs are visible or not
  bool _isExpanded = false;

  @override
  initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600))
      ..addListener(() {
        setState(() {});
      });

    _buttonAnimatedIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);

    _translateButton = Tween<double>(
      begin: 100,
      end: -20,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    super.initState();
  }

  // dispose the animation controller
  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // This function is used to expand/collapse the children floating buttons
  // It will be called when the primary FAB (with menu icon) is pressed
  _toggle() {
    if (_isExpanded) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }

    _isExpanded = !_isExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      widthFactor: 6.8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Transform(
            transform: Matrix4.translationValues(
              0,
              _translateButton.value * 4,
              0,
            ),
            child: FloatingActionButton(
              backgroundColor: Colors.blue[300],
              onPressed: () {
                _showAction(context, 0);
              },
              child: const Icon(
                Icons.person_add,
              ),
            ),
          ),
          Transform(
            transform: Matrix4.translationValues(
              0,
              _translateButton.value * 3,
              0,
            ),
            child: FloatingActionButton(
              backgroundColor: Colors.red[300],
              onPressed: () {
                _showAction(context, 1);
              },
              child: const Icon(
                Icons.payment_outlined,
              ),
            ),
          ),
          Transform(
            transform: Matrix4.translationValues(
              0,
              _translateButton.value * 2,
              0,
            ),
            child: FloatingActionButton(
              backgroundColor: Colors.green[300],
              onPressed: () {
                _showAction(context, 2);
              },
              child: const Icon(Icons.add_shopping_cart),
            ),
          ),
          // This is the primary FAB
          FloatingActionButton(
            backgroundColor: Colors.orange,
            splashColor: Colors.white,
            onPressed: _toggle,
            child: AnimatedIcon(
              icon: AnimatedIcons.menu_close,
              progress: _buttonAnimatedIcon,
            ),
          ),
        ],
      ),
    );
  }

  final List<Widget> _widgetOptions = <Widget>[
    RegisterClientForm(),
    Text("Fechar comanda"),
    Text("Adicionar produto"),
  ];

  void _showAction(BuildContext context, int index) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: _widgetOptions[index],
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('FECHAR'),
            ),
          ],
        );
      },
    );
  }
}
