import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:moviesapp/src/model/movies_model.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> itemCount;
  CardSwiper({@required this.itemCount});
  @override
  Widget build(BuildContext context) {
    final _screensize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: FadeInImage(
                image: NetworkImage(itemCount[index].getPostImage()),
                placeholder: AssetImage('assets/images/no-image.jpg'),
                fit: BoxFit.cover,
              ));
        },
        itemCount: itemCount.length,
        itemWidth: _screensize.width * 0.7,
        itemHeight: _screensize.height * 0.5,
        layout: SwiperLayout.STACK,
      ),
    );
  }
}
