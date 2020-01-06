import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:moviesapp/src/model/movies_model.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> movies;
  CardSwiper({@required this.movies});
  @override
  Widget build(BuildContext context) {
    final _screensize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          movies[index].uniqueID = '${movies[index].id}-card';
          return Hero(
            tag: movies[index].uniqueID,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, 'detail',
                        arguments: movies[index]);
                  },
                  child: FadeInImage(
                    image: NetworkImage(movies[index].getPostImage()),
                    placeholder: AssetImage('assets/images/no-image.jpg'),
                    fit: BoxFit.cover,
                  ),
                )),
          );
        },
        itemCount: movies.length,
        itemWidth: _screensize.width * 0.7,
        itemHeight: _screensize.height * 0.5,
        layout: SwiperLayout.STACK,
      ),
    );
  }
}
