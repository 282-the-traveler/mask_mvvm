import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ui/view/main_page.dart';
import 'viewmodel/store_viewmodel.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider.value(
      value: StoreViewModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter mask mvvm',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainPage(),
    );
  }
}
