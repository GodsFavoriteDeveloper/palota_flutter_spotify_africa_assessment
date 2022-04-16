import 'package:flutter/material.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/providers/spotify_provider.dart';
import 'package:flutter_spotify_africa_assessment/routes.dart';
import 'package:flutter_spotify_africa_assessment/utils/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => SpotifyProvider()),
      ],
      child: MaterialApp(
        title: 'Palota Spotify Africa Assessment',
        theme: appTheme(),
        initialRoute: AppRoutes.startUp,
        onGenerateRoute: AppRoutes.onGenerateRoute,
      ),
    );
  }
}
