import 'package:budget_tracker/screens/Home.dart';
import 'package:budget_tracker/services/BudgetViewModel.dart';
import 'package:budget_tracker/services/theme_services.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {

  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  return runApp(MyApp(sharedPreferences: sharedPreferences));
}

class MyApp extends StatelessWidget {
  final SharedPreferences sharedPreferences;
  const MyApp({required this.sharedPreferences, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<ThemeServices>(create: (_)=> ThemeServices(sharedPreferences)),
          ChangeNotifierProvider<BudgetViewModel>(create: (_)=> BudgetViewModel()),
        ],
            child: Builder(builder: (context) {
              final themeService = Provider.of<ThemeServices>(context);
              return MaterialApp(
                theme: ThemeData(
                  colorScheme: ColorScheme.fromSeed(
                      brightness: themeService.darkTheme? Brightness.dark: Brightness.light, seedColor: Colors.indigo),
                ),
                  home: const HomeFrame(),
              );
    }),
    );
  }
}