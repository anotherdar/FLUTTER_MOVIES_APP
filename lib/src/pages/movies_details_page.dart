import 'package:flutter/material.dart';
import 'package:moviesapp/src/model/actors_model.dart';
import 'package:moviesapp/src/model/movies_model.dart';
import 'package:moviesapp/src/providers/movies_provider.dart';

class MovieDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: CustomScrollView(
        slivers: <Widget>[
          _appbar(movie),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(
                height: 10.0,
              ),
              _posterTitle(movie),
              _movieDetail(movie),
              _cast(movie)
            ]),
          )
        ],
      ),
    );
  }

  Widget _cast(Movie movie) {
    final provider = new MoviesProvider();
    return FutureBuilder(
      future: provider.getCast(movie.id.toString()),
      builder: (BuildContext context, AsyncSnapshot<List<Actor>> snapshot) {
        if (snapshot.hasData) {
          return _actorsPageView(snapshot.data);
        } else {
          return Center(
            child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.white)),
          );
        }
      },
    );
  }

  Widget _movieDetail(Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
        style: TextStyle(
            color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.w300),
      ),
    );
  }

  Widget _posterTitle(Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Row(
        children: <Widget>[
          Hero(
            tag: movie.uniqueID,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(2.0),
              child: Image(
                image: NetworkImage(movie.getPostImage()),
                height: 150.0,
              ),
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  movie.title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400),
                ),
                Text(movie.originalTitle,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.white30,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400)),
                Row(
                  children: <Widget>[
                    Icon(Icons.star_border, color: Colors.yellow[900]),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      movie.voteAverage.toString(),
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _appbar(Movie movie) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.grey[900],
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          movie.title,
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
        ),
        background: FadeInImage(
          image: NetworkImage(movie.getBackgrounImage()),
          placeholder: AssetImage('assets/images/loading.gif'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _actorsPageView(List<Actor> data) {
    return SizedBox(
      height: 175.0,
      child: PageView.builder(
        pageSnapping: false,
        controller: PageController(viewportFraction: 0.25, initialPage: 1),
        itemCount: data.length,
        itemBuilder: (context, i) => _singleCard(data[i]),
      ),
    );
  }

  Widget _singleCard(Actor actor) {
    return Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: FadeInImage(
              image: NetworkImage(actor.getProfilePhoto()),
              placeholder: AssetImage('assets/images/no-image.jpg'),
              fit: BoxFit.cover,
              height: 150.0,
            ),
          ),
          SizedBox(
            height: 3.0,
          ),
          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: Colors.white,
                fontSize: 12.0,
                fontWeight: FontWeight.w300),
          )
        ],
      ),
    );
  }
}
