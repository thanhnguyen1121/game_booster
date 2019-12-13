import 'package:flutter/material.dart';
import 'package:guide_gaming/constances/Constances.dart';

class Intents {
  static startActivity(context, page, transitionType, duration) {
    Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (c, a1, a2) => page,
          transitionsBuilder: (
            context,
            animation,
            secondaryAnimation,
            child,
          ) =>
              transitionsBuilder(transitionType, context, animation,
                  secondaryAnimation, child),
          transitionDuration: duration,
        ));
  }

  static startActivityNoBack(context, page, transitionType, duration) {
    Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (c, a1, a2) => page,
          transitionsBuilder: (
            context,
            animation,
            secondaryAnimation,
            child,
          ) =>
              transitionsBuilder(transitionType, context, animation,
                  secondaryAnimation, child),
          transitionDuration: duration,
        ));
  }

  static startActivityForResult(
      context, page, transitionType, duration, callBack) async {
    Map results = await Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (c, a1, a2) => page,
      transitionsBuilder: (
        context,
        animation,
        secondaryAnimation,
        child,
      ) =>
          transitionsBuilder(
              transitionType, context, animation, secondaryAnimation, child),
      transitionDuration: duration,
    ));
    if (results != null) {
      callBack(results);
    }
  }

  static goBack(data) {
    Navigator.of(data['context']).pop(data['data']);
  }

  static transitionsBuilder(
    key,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    switch (key) {
      case Constances.SCALE_TRANSITION:
        return ScaleTransition(
          scale: Tween<double>(
            begin: 0.0,
            end: 1.0,
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.fastOutSlowIn,
            ),
          ),
          child: child,
        );
      case Constances.FADE_TRANSITION:
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      case Constances.SLIDE_TRANSITION:
        return SlideTransition(
          position: new Tween<Offset>(
            begin: const Offset(0.0, 1.0),
            end: Offset.zero,
          ).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeInSine)),
          child: child,
        );
      case Constances.SIZE_TRANSITION:
        return Align(
          child: SizeTransition(
            sizeFactor: animation,
            child: child,
          ),
        );
      case Constances.ROTATION_TRANSITION:
        return RotationTransition(
          turns: Tween<double>(
            begin: 0.0,
            end: 1.0,
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.linear,
            ),
          ),
          child: child,
        );

      case Constances.SCALE_ROTATION_TRANSITION:
        return ScaleTransition(
          scale: Tween<double>(
            begin: 0.0,
            end: 1.0,
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.fastOutSlowIn,
            ),
          ),
          child: RotationTransition(
            turns: Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.linear,
              ),
            ),
            child: child,
          ),
        );
      case Constances.SCALE_FADE_TRANSITION:
        return ScaleTransition(
          scale: Tween<double>(
            begin: 0.0,
            end: 1.0,
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.fastOutSlowIn,
            ),
          ),
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );

      case Constances.SLIDE_FADE_TRANSITION:
        return SlideTransition(
            position: new Tween<Offset>(
              begin: const Offset(0.0, 1.0),
              end: Offset.zero,
            ).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeInSine)),
            child: FadeTransition(
              opacity: animation,
              child: child,
            ));
    }
  }
}
