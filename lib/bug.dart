// bug.dart

import 'dart:async';
import 'dart:math';

import 'package:bug_squash_demo/bug_squash_game.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame_audio/flame_audio.dart';

class Bug extends SpriteComponent
    with TapCallbacks, HasGameReference<BugSquashGame> {
  late SpriteComponent _squashedBugComponent;

  Function()? onTap;

  late MoveEffect _moveEffect;
  var _isAlive = true;

  @override
  FutureOr<void> onLoad() async {
    sprite = await Sprite.load('bug.png');
    final squashedBugSprite = await Sprite.load('squashed_bug.png');
    _squashedBugComponent = SpriteComponent(sprite: squashedBugSprite);
    _squashedBugComponent.opacity = 0;
    add(_squashedBugComponent);

    //Set the bug angle to face right
    angle = pi / 2;
    //Set the bug position where it is not visible from the left
    position = Vector2(-size.x, position.y);

    //Move the bug from left to right
    final destination = Vector2(game.size.x + (2 * size.x), 0);
    final effectController = EffectController(
      duration: 0.6,
    );
    _moveEffect = MoveEffect.by(destination, effectController);
    // Remove this bug after movement is finished
    _moveEffect.onComplete = () {
      parent?.remove(this);
    };
    add(_moveEffect);

    super.onLoad();
  }

  @override
  void onTapDown(TapDownEvent event) {
    //Stop the movement of the bug when tapped.
    if (!_moveEffect.isPaused) {
      _moveEffect.pause();
    }
    FlameAudio.play("squash.mp3");
    _squashedBugComponent.opacity = 1;

    // Call the onTap method set by the parent component
    if (_isAlive) {
      _isAlive = false;
      onTap?.call();
    }
  }
}
