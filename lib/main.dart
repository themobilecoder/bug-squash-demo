//main.dart

import 'package:bug_squash_demo/bug_squash_game.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    GameWidget(
      game: BugSquashGame(),
    ),
  );
}
