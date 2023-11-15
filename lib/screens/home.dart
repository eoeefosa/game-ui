import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              // throw Exception();
              GoRouter.of(context).go('/levels');
            },
            child: const Text('Play Exception'),
          ),
          ElevatedButton(
            onPressed: () {
              // throw StateError("Whoa!");
              GoRouter.of(context).go('/levels');
            },
            child: const Text('Play'),
          ),
        ],
      ),
    );
  }
}
