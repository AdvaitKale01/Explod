import 'package:explod/providers/app_provider.dart';
import 'package:explod/screens/base_screen.dart';
import 'package:explod/screens/splash_screen.dart';
import 'package:explod/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then(
    (_) => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AppProvider()),
          // ChangeNotifierProvider(create: (_) => Auth()),
        ],
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context2, appProvider, child1) => MaterialApp(
        key: appProvider.key,
        debugShowCheckedModeBanner: false,
        navigatorKey: appProvider.navigatorKey,
        title: 'Explod',
        theme: ThemeData(
          primaryColor: AppColors.primary,
          fontFamily: 'Quicksand',
        ),
        // darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.system,
        routes: {
          SplashScreen.routeName: (context) => SplashScreen(),
          BaseScreen.routeName: (context) => BaseScreen(
                songInfo: [],
              ),
        },
        initialRoute: SplashScreen.routeName,
      ),
    );
  }
}
