import 'package:flutter/material.dart';
import 'package:moviesapp/src/model/movies_model.dart';

class MoviesHorizontalContainer extends StatelessWidget {
  final List<Movie> movies;
  MoviesHorizontalContainer({@required this.movies});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      height: _screenSize.height * 0.20,
      child: PageView(
        controller: PageController(initialPage: 1, viewportFraction: 0.3),
        children: _cards(),
      ),
    );
  }

  List<Widget> _cards() {
    return movies.map((movie) {
      return Container(
        // margin: EdgeInsets.only(right: 5.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                color: Colors.white,
                child: FadeInImage(
                  image: NetworkImage(movie.getPostImage()),
                  placeholder: AssetImage('assets/images/no-image.jpg'),
                  fit: BoxFit.cover,
                  height: 140.0,
                ),
              ),
            )
          ],
        ),
      );
    }).toList();
  }
}
