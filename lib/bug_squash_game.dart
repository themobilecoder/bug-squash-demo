//bug_squash_game.dart

import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:bug_squash_demo/bug.dart';
import 'package:flame/game.dart';
import 'package:flame/text.dart';
import 'package:flutter/material.dart';

class BugSquashGame extends FlameGame {
  late Timer _interval;
  late TextComponent _scoreComponent;
  int _score = 0;

  BugSquashGame() {
    _interval = Timer(1.0, onTick: _createBug, repeat: true);
  }

  @override
  FutureOr<void> onLoad() {
    _scoreComponent = TextComponent(
      text: "$_score",
      textRenderer: TextPaint(
        style: const TextStyle(color: Colors.black, fontSize: 24.0),
      ),
    );
    _scoreComponent.anchor = Anchor.center;
    _scoreComponent.position = Vector2(size.x / 2, 100);
    add(_scoreComponent);
  }

  @override
  void update(double dt) {
    _interval.update(dt);
    super.update(dt);
  }

  @override
  Color backgroundColor() {
    return const Color(0xFFEBFBEE);
  }

  // Function to be called in onTick() every 1 second
  void _createBug() {
    final bugComponent = Bug();
    final gameHeight = size.y;
    final randomYPosition = Random().nextDouble() * gameHeight;
    bugComponent.anchor = Anchor.center;
    bugComponent.position = Vector2(0, randomYPosition);
    bugComponent.angle = pi / 2;
    bugComponent.onTap = () {
      _scoreComponent.text = "${++_score}"; // Increment the score
      Future.delayed(const Duration(milliseconds: 500)).then(
        (value) {
          if (!bugComponent.isRemoved) {
            remove(bugComponent);
          }
        },
      );
    };
    add(bugComponent);
  }
}
