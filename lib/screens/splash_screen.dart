import 'package:explod/screens/base_screen.dart';
import 'package:explod/screens/queue_screen.dart';
import 'package:explod/theme/app_text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static final String routeName = '/splash-screen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _changeScreen() async {
    final FlutterAudioQuery audioQuery = FlutterAudioQuery();
    List<SongInfo> songInfo = await audioQuery.getSongs();
    Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
            builder: (context) => BaseScreen(
                  songInfo: songInfo,
                )));
  }

  @override
  void initState() {
    _changeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Explod',
          style: AppTextStyle.h1BoldBlackGilroy,
        ),
      ),
    );
  }
}
