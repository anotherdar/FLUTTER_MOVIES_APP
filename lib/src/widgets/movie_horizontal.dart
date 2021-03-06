import 'package:flutter/material.dart';
import 'package:moviesapp/src/model/movies_model.dart';

class MoviesHorizontalContainer extends StatelessWidget {
  final List<Movie> movies;
  final Function nextPages;
  MoviesHorizontalContainer({@required this.movies, @required this.nextPages});
  final _pageController =
      new PageController(initialPage: 1, viewportFraction: 0.25);
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        nextPages();
      }
    });

    return Container(
      height: _screenSize.height * 0.2,
      child: PageView.builder(
          pageSnapping: false,
          controller: _pageController,
          itemCount: movies.length,
          itemBuilder: (context, i) => _card(context, movies[i])),
    );
  }

  Widget _card(BuildContext context, Movie movie) {
    movie.uniqueID = '${movie.id}-pageviewcard';

    final card = Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: <Widget>[
          Hero(
            tag: movie.uniqueID,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(3.0),
              child: Container(
                color: Colors.white,
                child: FadeInImage(
                  image: NetworkImage(movie.getPostImage()),
                  placeholder: AssetImage('assets/images/no-image.jpg'),
                  fit: BoxFit.cover,
                  height: 140.0,
                ),
              ),
            ),
          )
        ],
      ),
    );

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'detail', arguments: movie);
      },
      child: card,
    );
  }
}
