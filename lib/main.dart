import 'package:flutter/material.dart';
import 'package:moviesapp/src/pages/home_page.dart';

void main() => runApp(MoviesApp());

class MoviesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movies',
      initialRoute: '/',
      routes: {'/': (BuildContext context) => HomePage()},
    );
  }
}
