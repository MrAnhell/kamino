import 'package:flutter/material.dart';
import 'package:kamino/models/content.dart';
import 'package:kamino/models/movie.dart';
import 'package:kamino/ui/uielements.dart';
import 'package:kamino/view/content/overview.dart';

class MovieLayout{

  static Widget generate(BuildContext context, MovieContentModel _data){
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
        child: Column(
          children: <Widget>[


            /* Similar Movies */
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                    title: TitleText(
                        'Similar Movies',
                        fontSize: 22.0,
                        textColor: Theme.of(context).primaryColor
                    )
                ),

                SizedBox(
                  height: 208.0,
                  child: _generateSimilarMovieCards(_data)
                )
              ],
            )
            /* ./Similar Movies */


          ]
      )
    );
  }

  static Widget _generateSimilarMovieCards(MovieContentModel _data){
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: _data.recommendations.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: index == 0
              ? const EdgeInsets.only(left: 18.0)
              : const EdgeInsets.only(left: 0.0),
          child: InkWell(
            onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ContentOverview(
                          contentId: _data.recommendations[index]["id"],
                          contentType: ContentOverviewContentType.MOVIE
                        ),
                    )
                );
            },
            splashColor: Colors.white,
            child: Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Card(
                      child: ClipRRect(
                        borderRadius: new BorderRadius.circular(5.0),
                        child: Container(
                          child: _data.recommendations[index]
                          ["poster_path"] !=
                              null
                              ? Image.network(
                            "http://image.tmdb.org/t/p/w500" +
                                _data
                                    .recommendations[index]
                                ["poster_path"],
                            fit: BoxFit.fill,
                            height: 185.0,
                          )
                              : Image.asset(
                            "assets/images/no_image_detail.jpg",
                            fit: BoxFit.fill,
                            width: 130.0,
                            height: 185.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
    });
  }

}