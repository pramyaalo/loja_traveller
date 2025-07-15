import 'package:flutter/material.dart';

import 'LoginScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<Offset> _slideSuitAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _fadeUpAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.5),
      end: Offset(0, -1),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _slideSuitAnimation = Tween<Offset>(
      begin: Offset(0, -5),
      end: Offset(0, -0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _fadeAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(_controller);

    _fadeUpAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller);

    _controller.forward();

    Future.delayed(Duration(seconds: 3), () {
      // Navigate to your desired screen after the splash screen
      // Example: Navigator.pushReplacementNamed(context, '/home');
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Color(0xFF00ADEE),
          ),
          Center(
            child: SlideTransition(
                position: _slideSuitAnimation,
                child: FadeTransition(
                    opacity: _fadeUpAnimation,
                    child: Image.asset(
                      'assets/images/splash.png',
                      height: 200,
                      width: 200,
                    ))), // Replace with your splash screen content
          ),
          Positioned.fill(
            child: SlideTransition(
              position: _slideAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Center(
                  child: Image.asset('assets/images/anim_flight.png',
                      width: 100, height: 100), // Replace with your image
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
