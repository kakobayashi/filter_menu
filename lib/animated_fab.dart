
import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimatedFab extends StatefulWidget {
  final VoidCallback onClick;
  
  const AnimatedFab({Key key, this.onClick}): super(key: key);
  
  @override
  State<StatefulWidget> createState() => _AnimatedFabState();
}

class _AnimatedFabState extends State<AnimatedFab> with SingleTickerProviderStateMixin {
  final double expandedSize = 180.0;
  final double hiddenSize = 20.0;

  AnimationController _animationController;
  Animation<Color> _colorAnimation;
  
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _colorAnimation = ColorTween(
      begin: Colors.pink,
      end: Colors.pink[800],
    ).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: expandedSize,
      height: expandedSize,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget child) {
          return Stack(
            alignment: Alignment.center,
            children: <Widget>[
              _buildExpandedBackground(),
              _buildOption(Icons.check_circle, 0.0),
              _buildOption(Icons.flash_on, -math.pi / 3),
              _buildOption(Icons.access_time, -2 * math.pi / 3),
              _buildOption(Icons.error_outline, math.pi),
              _buildFabCore(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildExpandedBackground() {
    double size = hiddenSize + (expandedSize - hiddenSize) * _animationController.value;

    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.pink,
      ),
    );
  }

  open() {
    if (_animationController.isDismissed) {
      _animationController.forward();
    }
  }

  close() {
    if (_animationController.isCompleted) {
      _animationController.reverse();
    }
  }

  _onFabTap() {
    if (_animationController.isDismissed) {
      open();
    } else {
      close();
    }
  }

  _buildFabCore() {
    double scaleFactor = 2 * (_animationController.value - 0.5).abs();

    return FloatingActionButton(
      onPressed: _onFabTap,
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..scale(1.0, scaleFactor),
        child: Icon(
          _animationController.value > 0.5 ? Icons.close : Icons.filter_list,
          color: Colors.white,
          size: 26.0,
        ),
      ),
      backgroundColor: _colorAnimation.value,
    );
  }

  Widget _buildOption(IconData icon, double angle) {
    double iconSize = 0.0;
    if (_animationController.value > 0.8) {
      iconSize = 26.0 * (_animationController.value - 0.8) * 5;
    }

    return Transform.rotate(
        angle: angle,
      child: Align(
        alignment: Alignment.topCenter,
        child: IconButton(
          onPressed: _onIconClick,
          icon: Transform.rotate(angle: -angle,
          child: Icon(icon, color: Colors.white,),
          ),
          iconSize: iconSize,
          alignment: Alignment.center,
          padding: EdgeInsets.all(0.0),
        ),
      ),
    );
  }
  _onIconClick() {
    widget.onClick();
    close();
  }
}