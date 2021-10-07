# Explod Project

A project created in flutter using Audio Manager.

## Getting Started

The project contains the minimal implementation required to create a new library or project. The repository code is preloaded with some basic components like basic app architecture, app theme, constants and required dependencies to create a new project. By using boiler plate code as standard initializer, we can have same patterns in all the projects that will inherit it. This will also help in reducing setup & development time by allowing you to use same code pattern and avoid re-writing from scratch.

## How to Use 

**Step 1:**

Download or clone this repo by using the link below:

```
https://github.com/AdvaitKale01/Explod.git
```

**Step 2:**

Go to project root and execute the following command in console to get the required dependencies: 

```
flutter pub get 
```

**Step 3:**

Run with `unsound null safety` as currently the package ```flutter_audio_query``` does not support null safety. Create new run configuration and add this to additional run arguments:

```
 --no-sound-null-safety
```

## TODO:

- [x] Splash 
- [ ] Login 
- [x] Music Player 
- [ ] Visualizer 
- [ ] Background Audio Service 
- [x] Theme 
- [x] Provider  
- [ ] Dark Theme Support

### Up-Coming Features:

* User Behavior Recognition
* Online Streaming

### Libraries & Tools Used

* [Dio](https://github.com/flutterchina/dio)
* [Database](https://github.com/tekartik/sembast.dart)
* [MobX](https://github.com/mobxjs/mobx.dart) (to connect the reactive data of your application with the UI)
* [Provider](https://github.com/rrousselGit/provider) (State Management)
* [Encryption](https://github.com/xxtea/xxtea-dart)
* [Validation](https://github.com/dart-league/validators)
* [Logging](https://github.com/zubairehman/Flogs)
* [Notifications](https://github.com/AndreHaueisen/flushbar)
* [Json Serialization](https://github.com/dart-lang/json_serializable)
* [Dependency Injection](https://github.com/fluttercommunity/get_it)

### Folder Structure
Here is the core folder structure which flutter provides.

```
flutter-app/
|- android
|- build
|- ios
|- lib
|- test
```

Here is the folder structure I have been using in this project

```
fonts/
images/
lib/
|- providers/
|- screens/
|- theme/
|- utils/
|- widgets/
|- main.dart
```

[comment]: <> (Now, lets dive into the lib folder which has the main code for the application.)

[comment]: <> (```)

[comment]: <> (1- constants - All the application level constants are defined in this directory with-in their respective files. This directory contains the constants for `theme`, `dimentions`, `api endpoints`, `preferences` and `strings`.)

[comment]: <> (2- data - Contains the data layer of your project, includes directories for local, network and shared pref/cache.)

[comment]: <> (3- stores - Contains store&#40;s&#41; for state-management of your application, to connect the reactive data of your application with the UI. )

[comment]: <> (4- ui — Contains all the ui of your project, contains sub directory for each screen.)

[comment]: <> (5- util — Contains the utilities/common functions of your application.)

[comment]: <> (6- widgets — Contains the common widgets for your applications. For example, Button, TextField etc.)

[comment]: <> (7- routes.dart — This file contains all the routes for your application.)

[comment]: <> (8- main.dart - This is the starting point of the application. All the application level configurations are defined in this file i.e, theme, routes, title, orientation etc.)

[comment]: <> (```)

[comment]: <> (### Constants)

[comment]: <> (This directory contains all the application level constants. A separate file is created for each type as shown in example below:)

[comment]: <> (```)

[comment]: <> (constants/)

[comment]: <> (|- app_theme.dart)

[comment]: <> (|- dimens.dart)

[comment]: <> (|- endpoints.dart)

[comment]: <> (|- preferences.dart)

[comment]: <> (|- strings.dart)

[comment]: <> (```)

[comment]: <> (### Data)

[comment]: <> (All the business logic of your application will go into this directory, it represents the data layer of your application. It is sub-divided into three directories `local`, `network` and `sharedperf`, each containing the domain specific logic. Since each layer exists independently, that makes it easier to unit test. The communication between UI and data layer is handled by using central repository.)

[comment]: <> (```)

[comment]: <> (data/)

[comment]: <> (|- local/)

[comment]: <> (    |- constants/)

[comment]: <> (    |- datasources/)

[comment]: <> (    |- app_database.dart)
   
[comment]: <> (|- network/)

[comment]: <> (    |- constants/)

[comment]: <> (    |- exceptions/)

[comment]: <> (    |- rest_client.dart)
    
[comment]: <> (|- sharedpref)

[comment]: <> (    |- constants/)

[comment]: <> (    |- shared_preference_helper.dart)
    
[comment]: <> (|- repository.dart)

[comment]: <> (```)

[comment]: <> (### Stores)

[comment]: <> (The store is where all your application state lives in flutter. The Store is basically a widget that stands at the top of the widget tree and passes it's data down using special methods. In-case of multiple stores, a separate folder for each store is created as shown in the example below:)

[comment]: <> (```)

[comment]: <> (stores/)

[comment]: <> (|- login/)

[comment]: <> (    |- login_store.dart)

[comment]: <> (    |- form_validator.dart)

[comment]: <> (```)

[comment]: <> (### UI)

[comment]: <> (This directory contains all the ui of your application. Each screen is located in a separate folder making it easy to combine group of files related to that particular screen. All the screen specific widgets will be placed in `widgets` directory as shown in the example below:)

[comment]: <> (```)

[comment]: <> (ui/)

[comment]: <> (|- login)

[comment]: <> (   |- login_screen.dart)

[comment]: <> (   |- widgets)

[comment]: <> (      |- login_form.dart)

[comment]: <> (      |- login_button.dart)

[comment]: <> (```)

[comment]: <> (### Utils)

[comment]: <> (Contains the common file&#40;s&#41; and utilities used in a project. The folder structure is as follows: )

[comment]: <> (```)

[comment]: <> (utils/)

[comment]: <> (|- encryption)

[comment]: <> (   |- xxtea.dart)

[comment]: <> (|- date)

[comment]: <> (  |- date_time.dart)

[comment]: <> (```)

[comment]: <> (### Widgets)

[comment]: <> (Contains the common widgets that are shared across multiple screens. For example, Button, TextField etc.)

[comment]: <> (```)

[comment]: <> (widgets/)

[comment]: <> (|- app_icon_widget.dart)

[comment]: <> (|- empty_app_bar.dart)

[comment]: <> (|- progress_indicator.dart)

[comment]: <> (```)

[comment]: <> (### Routes)

[comment]: <> (This file contains all the routes for your application.)

[comment]: <> (```dart)

[comment]: <> (import 'package:flutter/material.dart';)

[comment]: <> (import 'ui/home/home.dart';)

[comment]: <> (import 'ui/login/login.dart';)

[comment]: <> (import 'ui/splash/splash.dart';)

[comment]: <> (class Routes {)

[comment]: <> (  Routes._&#40;&#41;;)

[comment]: <> (  //static variables)

[comment]: <> (  static const String splash = '/splash';)

[comment]: <> (  static const String login = '/login';)

[comment]: <> (  static const String home = '/home';)

[comment]: <> (  static final routes = <String, WidgetBuilder>{)

[comment]: <> (    splash: &#40;BuildContext context&#41; => SplashScreen&#40;&#41;,)

[comment]: <> (    login: &#40;BuildContext context&#41; => LoginScreen&#40;&#41;,)

[comment]: <> (    home: &#40;BuildContext context&#41; => HomeScreen&#40;&#41;,)

[comment]: <> (  };)

[comment]: <> (})

[comment]: <> (```)

[comment]: <> (### Main)

[comment]: <> (This is the starting point of the application. All the application level configurations are defined in this file i.e, theme, routes, title, orientation etc.)

[comment]: <> (```dart)

[comment]: <> (import 'package:boilerplate/routes.dart';)

[comment]: <> (import 'package:flutter/material.dart';)

[comment]: <> (import 'package:flutter/services.dart';)

[comment]: <> (import 'constants/app_theme.dart';)

[comment]: <> (import 'constants/strings.dart';)

[comment]: <> (import 'ui/splash/splash.dart';)

[comment]: <> (void main&#40;&#41; {)

[comment]: <> (  SystemChrome.setPreferredOrientations&#40;[)

[comment]: <> (    DeviceOrientation.portraitUp,)

[comment]: <> (    DeviceOrientation.portraitDown,)

[comment]: <> (    DeviceOrientation.landscapeRight,)

[comment]: <> (    DeviceOrientation.landscapeLeft,)

[comment]: <> (  ]&#41;.then&#40;&#40;_&#41; {)

[comment]: <> (    runApp&#40;MyApp&#40;&#41;&#41;;)

[comment]: <> (  }&#41;;)

[comment]: <> (})

[comment]: <> (class MyApp extends StatelessWidget {)

[comment]: <> (  // This widget is the root of your application.)

[comment]: <> (  @override)

[comment]: <> (  Widget build&#40;BuildContext context&#41; {)

[comment]: <> (    return MaterialApp&#40;)

[comment]: <> (      debugShowCheckedModeBanner: false,)

[comment]: <> (      title: Strings.appName,)

[comment]: <> (      theme: themeData,)

[comment]: <> (      routes: Routes.routes,)

[comment]: <> (      home: SplashScreen&#40;&#41;,)

[comment]: <> (    &#41;;)

[comment]: <> (  })

[comment]: <> (})

[comment]: <> (```)

[comment]: <> (## Wiki)

[comment]: <> (Checkout [wiki]&#40;https://github.com/zubairehman/flutter-boilerplate-project/wiki&#41; for more info)

## Conclusion

I will be happy to answer any questions that you may have on this approach, and if you want to lend a hand with the project then please feel free to submit an issue and/or pull request 🙂

Again to note, this is example can appear as over-architectured for what it is - but it is an example only. If you liked my work, don’t forget to ⭐ star the repo to show your support.
