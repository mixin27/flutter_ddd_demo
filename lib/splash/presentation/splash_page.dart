import 'package:auto_route/auto_route.dart';
import 'package:demo/core/presentation/router/app_router.gr.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  _navigate() async {
    await Future.delayed(const Duration(seconds: 3));

    AutoRouter.of(context).pushAndPopUntil(
      const PostListingRoute(),
      predicate: (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: const Center(
        child: Text(
          'SPLASH',
          style: TextStyle(
            fontSize: 48,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
