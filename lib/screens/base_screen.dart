import 'package:explod/screens/queue_screen.dart';
import 'package:explod/screens/settings_screen.dart';
import 'package:explod/screens/player_screen.dart';
import 'package:explod/screens/splash_screen.dart';
import 'package:explod/theme/app_colors.dart';
import 'package:explod/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BaseScreen extends StatefulWidget {
  final List<SongInfo> songInfo;

  const BaseScreen({Key? key, required this.songInfo}) : super(key: key);

  static final String routeName = '/base-screen';

  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int pageIndex = 1;
  int songIndex = 0;
  bool isPlaying = false;
  @override
  Widget build(BuildContext context) {
    List pages = [
      PlayerScreen(
        songInfo: widget.songInfo,
        songIndex: songIndex,
        isPlaying: isPlaying,
      ),
      // PlayerScreen(),
      QueueScreen(
        songInfo: widget.songInfo,
        goToVisualizer: (value1, value2) {
          setState(() {
            pageIndex = value1;
            songIndex = value2;
            isPlaying = true;
          });
        },
      ),
      SettingsScreen(),
    ];
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, bottom: 10, top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        // widget.userName,
                        pageIndex == 0
                            ? 'Visualizer'
                            : pageIndex == 1
                                ? 'Queue'
                                : 'Settings',
                        style: AppTextStyle.h1BoldBlackGilroy,
                      ),
                    ],
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, SplashScreen.routeName);
                  },
                  icon: Icon(
                    Icons.refresh_rounded,
                    color: AppColors.black,
                  ),
                  label: Text(
                    'Refresh',
                    style: AppTextStyle.h6BoldBlackQuickSand,
                  ),
                ),
              ],
            ),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
                child: pages[pageIndex],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 10.0, left: 20.0, right: 20.0),
        child: GNav(
          duration: Duration(milliseconds: 10),
          tabs: [
            GButton(
              gap: 8,
              iconActiveColor: AppColors.primary,
              iconColor: Colors.black,
              textColor: AppColors.primary,
              backgroundColor: AppColors.primary.withOpacity(.2),
              iconSize: 24,
              padding: EdgeInsets.all(10),
              icon: Icons.graphic_eq_rounded,
              text: 'Visualizer',
            ),
            GButton(
              gap: 8,
              iconActiveColor: AppColors.primary,
              iconColor: Colors.black,
              textColor: AppColors.primary,
              backgroundColor: AppColors.primary.withOpacity(.2),
              iconSize: 24,
              padding: EdgeInsets.all(10),
              icon: Icons.queue_music,
              text: 'Queue',
            ),
            GButton(
              gap: 8,
              iconActiveColor: AppColors.primary,
              iconColor: Colors.black,
              textColor: AppColors.primary,
              backgroundColor: AppColors.primary.withOpacity(.2),
              iconSize: 24,
              padding: EdgeInsets.all(10),
              icon: Icons.settings_rounded,
              text: 'Search',
            ),
          ],
          selectedIndex: pageIndex,
          onTabChange: (index) {
            setState(() {
              pageIndex = index;
            });
          },
        ),
      ),
    );
  }
}
