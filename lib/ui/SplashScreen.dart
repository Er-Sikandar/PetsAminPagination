import 'package:flutter/material.dart';

import '../providers/AuthProvider.dart';
import 'package:provider/provider.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<SplashScreen> {

  @override
  void initState() {
    AuthProvider authProvider = Provider.of(context, listen: false);
    authProvider.autologin(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Image.asset('assets/ic_icon.png',
          width: 180,height: 180,),
      ),
    );
  }
}
