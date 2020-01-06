import 'package:flutter/material.dart';
import 'package:moviesapp/src/providers/movies_provider.dart';
import 'package:moviesapp/src/widgets/card_swiper_widget.dart';
import 'package:moviesapp/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {
  final moviesProvider = new MoviesProvider();

  @override
  Widget build(BuildContext context) {
    moviesProvider.getPopular();
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Movies',
            style: TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {},
            )
          ],
          backgroundColor: Colors.grey[900],
          elevation: 10.0,
        ),
        body: Container(
          color: Colors.grey[900],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[_swiperCard(), _footer(context)],
          ),
        ));
  }

  Widget _swiperCard() {
    return FutureBuilder(
        future: moviesProvider.getNowPlaying(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            return CardSwiper(movies: snapshot.data);
          } else {
            return Container(
                height: 400.0,
                child: Center(
                    child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                )));
          }
        });
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              'Populares',
              style: TextStyle(color: Colors.white),
              // style: Theme.of(context).textTheme.subhead,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          StreamBuilder(
            stream: moviesProvider.popularStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.hasData) {
                return MoviesHorizontalContainer(
                  movies: snapshot.data,
                  nextPages: moviesProvider.getPopular,
                );
              } else {
                return Center(
                    child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                ));
              }
            },
          ),
        ],
      ),
    );
  }
}
