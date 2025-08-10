import 'package:coincap_testapp/features/asset_list/presentation/widgets/asset_list_page.dart';
import 'package:flutter/material.dart';

import 'injection.dart';

void main() async {
  await configureDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(fontFamily: 'SF Pro Text'),
      home: const AssetListPage(),
    );
  }
}
