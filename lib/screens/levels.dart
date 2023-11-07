import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Levels extends StatelessWidget {
  const Levels({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextButton(
          onPressed: () {
            context.pop();
          },
          child: const Text("Back"),
        ),
      ),
      body: Column(
        children: [
          const Center(
            child: Text("Level  Screen"),
          ),
          ElevatedButton(
            onPressed: () {
              GoRouter.of(context).go('/settings');
            },
            child: const Row(
              children: [
                Icon(Icons.settings),
                Text('Settings'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
