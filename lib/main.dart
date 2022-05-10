import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _systemPreferenceSwitch = true;
  bool _darkModeSwitch = false;
  bool _lightModeSwitch = false;
  ThemeMode _themeMode = ThemeMode.system;

  @override
  void initState() {
    super.initState();
    _getBoolFromSharePreference();
  }

  _getBoolFromSharePreference() async {
    final prefs = await SharedPreferences.getInstance();
    final bool? system = prefs.getBool('system_switch');
    final bool? dark = prefs.getBool('dark_switch');
    final bool? light = prefs.getBool('light_switch');

    if (system == true) {
      setState(() {
        _themeMode = ThemeMode.system;
        _systemPreferenceSwitch = true;
        _darkModeSwitch = false;
        _lightModeSwitch = false;
      });
    } else if (dark == true) {
      setState(() {
        _themeMode = ThemeMode.dark;
        _systemPreferenceSwitch = false;
        _darkModeSwitch = true;
        _lightModeSwitch = false;
      });
    } else if (light == true) {
      setState(() {
        _themeMode = ThemeMode.light;
        _systemPreferenceSwitch = false;
        _darkModeSwitch = false;
        _lightModeSwitch = true;
      });
    } else {
      setState(() {
        _themeMode = ThemeMode.system;
        _systemPreferenceSwitch = true;
        _darkModeSwitch = false;
        _lightModeSwitch = false;
      });
    }
  }

  _setSystemSwitch() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('system_switch', true);
    await prefs.setBool('dark_switch', false);
    await prefs.setBool('light_switch', false);
  }

  _setDarkSwitch() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('system_switch', false);
    await prefs.setBool('dark_switch', true);
    await prefs.setBool('light_switch', false);
  }

  _setLightSwitch() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('system_switch', false);
    await prefs.setBool('dark_switch', false);
    await prefs.setBool('light_switch', true);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: _themeMode,
      debugShowCheckedModeBanner: false,
      title: 'Dark Light Theme',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Dart Mode'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'System Preference',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  Switch(
                    value: _systemPreferenceSwitch,
                    onChanged: (newStateValue) {
                      _systemPreferenceSwitch
                          ? print('Blocked')
                          : setState(() {
                        _systemPreferenceSwitch = true;
                        _darkModeSwitch = false;
                        _lightModeSwitch = false;
                        _themeMode = ThemeMode.system;
                        _setSystemSwitch();
                      });
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Dark Mode',
                      style: TextStyle(
                        fontSize: 16.0,
                        color:
                        (_themeMode == ThemeMode.dark) ? Colors.red : null,
                      ),
                    ),
                  ),
                  Switch(
                    value: _darkModeSwitch,
                    onChanged: (newStateValue) {
                      _darkModeSwitch
                          ? print('Blocked')
                          : setState(() {
                        _systemPreferenceSwitch = false;
                        _darkModeSwitch = true;
                        _lightModeSwitch = false;
                        _themeMode = ThemeMode.dark;
                        _setDarkSwitch();
                      });
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Light Mode',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: (_themeMode == ThemeMode.light)
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                  ),
                  Switch(
                    value: _lightModeSwitch,
                    onChanged: (newStateValue) {
                      _lightModeSwitch
                          ? print('Blocked')
                          : setState(() {
                        _systemPreferenceSwitch = false;
                        _darkModeSwitch = false;
                        _lightModeSwitch = true;
                        _themeMode = ThemeMode.light;
                        _setLightSwitch();
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
