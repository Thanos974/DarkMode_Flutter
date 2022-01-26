import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      dark: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.yellow,
      ),
      initial: AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Dark Mode',
        theme: theme,
        darkTheme: darkTheme,
        home: const MyHomePage(
          title: 'Flutter Dark Mode',
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool darkmode = false;
  dynamic savedThemeMode;
  late String iconAdress;

  @override
  void initState() {
    super.initState();
    getCurrentTheme();
  }

  Future getCurrentTheme() async {
    savedThemeMode = await AdaptiveTheme.getThemeMode();
    if (savedThemeMode.toString() == 'AdaptiveThemeMode.dark') {
      print('thème sombre');
      setState(() {
        darkmode = true;
        iconAdress = 'images/dark.png';
      });
    } else {
      print('thème clair');
      setState(() {
        darkmode = false;
        iconAdress = 'images/light.png';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
              child: iconAdress != null ? Image.asset(iconAdress) : Container(),
            ),
            const SizedBox(height: 70),
            const Text(
              'Changez de thème',
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Container(
              width: 250,
              child: const Text(
                "Vous pouvez changer le thème de l'interface de votre application.",
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 100),
            SwitchListTile(
              title: const Text('Mode sombre'),
              activeColor: Colors.yellow,
              secondary: const Icon(Icons.nightlight_round),
              value: darkmode,
              onChanged: (bool value) {
                print(value);
                if (value == true) {
                  AdaptiveTheme.of(context).setDark();
                  iconAdress = 'images/dark.png';
                } else {
                  AdaptiveTheme.of(context).setLight();
                  iconAdress = 'images/light.png';
                }
                setState(() {
                  darkmode = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
