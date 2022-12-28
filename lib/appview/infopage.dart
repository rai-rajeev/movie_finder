
import 'package:find_movies/model/now_playing.dart';
import 'package:find_movies/model/searchmovies.dart';
import 'package:find_movies/model/top_rated_movies.dart';
import 'package:find_movies/model/trendingMovies.dart';
import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
   InfoScreen({this.trend,
     required this.index,
     this.nowplay,
     this.toprated,
     this.genres,
     this.searchmov,
     Key? key}) : super(key: key);
  TrendingMovies? trend;
  int index;
  NowPlayingMovies? nowplay;
  TopRatedMovies? toprated;
   Map<int,String>? genres;
   SearchMovies? searchmov;
  String uri(){
    var image;
    if(trend!=null){
       image="https://image.tmdb.org/t/p/w600_and_h900_bestv2${trend!.results![index].posterPath!}";
    }
    else if(nowplay!=null){
      image="https://image.tmdb.org/t/p/w600_and_h900_bestv2${nowplay!.results![index].posterPath}";
    }
    else if(toprated!=null){
      image="https://image.tmdb.org/t/p/w600_and_h900_bestv2${toprated!.results![index].posterPath!}";

    }
    else if(searchmov!=null){
      image=(searchmov!.results[index].posterPath!='')?"https://image.tmdb.org/t/p/w600_and_h900_bestv2${searchmov!.results[index].posterPath!}":"https://vcunited.club/wp-content/uploads/2020/01/No-image-available-2.jpg";

    }
    return image;
  }
   String YesNo(){
     var ok;
     if(trend!=null){
       ok=trend!.results![index].adult!? "Yes":"No";
     }
     else if(nowplay!=null){
       ok=nowplay!.results![index].adult!?"Yes":"No";
     }
     else if(toprated!=null){
       ok=toprated!.results![index].adult!?"Yes":"No";

     }
     else if(searchmov!=null){
       ok=searchmov!.results[index].adult!?"Yes":"No";

     }
     return ok;
   }
   String description(){
     var des;
     if(trend!=null){
       des=trend!.results![index].overview!;
     }
     else if(nowplay!=null){
       des=nowplay!.results![index].overview!;
     }
     else if(toprated!=null){
       des=toprated!.results![index].overview!;

     }
     else if(searchmov!=null){
       des=searchmov!.results[index].overview!;

     }
     return des;
   }
   String title(){
     var des;
     if(trend!=null){
       des=trend!.results![index].title!;
     }
     else if(nowplay!=null){
       des=nowplay!.results![index].title;
     }
     else if(toprated!=null){
       des=toprated!.results![index].title!;

     }
     else if(searchmov!=null){
       des=searchmov!.results[index].title!;

     }
     return des;
   }
   double popularity(){
     var pop;
     if(trend!=null){
       pop=trend!.results![index].popularity!;
     }
     else if(nowplay!=null){
       pop=nowplay!.results![index].popularity!;
     }
     else if(toprated!=null){
       pop=toprated!.results![index].popularity!;

     }
     else if(searchmov!=null){
       pop=searchmov!.results[index].popularity!;

     }
     return pop;
   }
   double rating(){
     var pop;
     if(trend!=null){
       pop=trend!.results![index].voteAverage!;
     }
     else if(nowplay!=null){
       pop=nowplay!.results![index].voteAverage!;
     }
     else if(toprated!=null){
       pop=toprated!.results![index].voteAverage!;

     }
     else if(searchmov!=null){
       pop=searchmov!.results[index].voteAverage!;

     }
     return pop;
   }
   int rateby(){
     var pop;
     if(trend!=null){
       pop=trend!.results![index].voteCount!;
     }
     else if(nowplay!=null){
       pop=nowplay!.results![index].voteCount!;
     }
     else if(toprated!=null){
       pop=toprated!.results![index].voteCount!;

     }
     else if(searchmov!=null){
       pop=searchmov!.results[index].voteCount!;

     }
     return pop;
   }
   String reldate(){
     var pop;
     if(trend!=null){
       pop=trend!.results![index].releaseDate!.toIso8601String();
     }
     else if(nowplay!=null){
       pop=nowplay!.results![index].releaseDate!.toIso8601String();
     }
     else if(toprated!=null){
       pop=toprated!.results![index].releaseDate!.toIso8601String();

     }
     else if(searchmov!=null){
       pop=searchmov!.results[index].releaseDate!.toString();

     }
     return pop.substring(0,10);
   }
   String lang(){
     var pop;
     if(trend!=null){
       pop=trend!.results![index].originalLanguage!.name.toString();
     }
     else if(nowplay!=null){
       pop=nowplay!.results![index].originalLanguage!.name.toString();
     }
     else if(toprated!=null){
       pop=toprated!.results![index].originalLanguage!.name.toString();

     }
     else if(searchmov!=null){
       pop=searchmov!.results[index].originalLanguage!.name.toString();

     }
     return pop;
   }
   List<String> gen(){
    List<String> nok=[];

    if(trend!=null){
      for(var i in trend!.results![index].genreIds!) {
        if({genres![i]}!=null)
     { nok.add(genres![i]!);}
      }
    }
    else if(nowplay!=null){
      for(var i in nowplay!.results![index].genreIds!)
       {  if({genres![i]}!=null)
       { nok.add(genres![i]!);}
       }
    }
    else if(toprated!=null){
      for(var i in toprated!.results![index].genreIds!) {
        if({genres![i]}!=null)
        { nok.add(genres![i]!);}
      }
    }
    else if(searchmov!=null){
      for(var i in searchmov!.results[index].genreIds!) {
        if({genres![i]}!=null)
        { nok.add(genres![i]!);}
      }
    }
    if(nok.isEmpty){
      nok.add('Non Know');
    }
    return nok;
   }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text(title(),
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.grey[50]
          ),
          maxLines: 2,
        ),
        centerTitle: true,
      ),
      body:Center(
        child: ListView(

          children: [

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image(image: NetworkImage(uri()),
              height:300,
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 10),
              child: Text('Release On: ${reldate()}',
                style: TextStyle(
                    fontSize: 20,

                    color: Colors.grey[50]
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Genre: ${gen()}',
                style: TextStyle(
                    fontSize: 20,

                    color: Colors.grey[50]
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text('Rating: ${rating()}',
                style: TextStyle(
                    fontSize: 20,

                    color: Colors.grey[50]
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text('Rated By: ${rateby()} peolple',
                style: TextStyle(
                    fontSize: 20,

                    color: Colors.grey[50]
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text('Popularity : ${popularity()}',
                style: TextStyle(
                    fontSize: 20,

                    color: Colors.grey[50]
                ),
                textAlign: TextAlign.center,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text('Adult Film: ${YesNo()}',
                style: TextStyle(
                    fontSize: 20,

                    color: Colors.grey[50]
                ),
                textAlign: TextAlign.center,
              ),
            ),


            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text('Original language: ${lang()}',
                style: TextStyle(
                    fontSize: 20,

                    color: Colors.grey[50]
                ),
                textAlign: TextAlign.center,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text('DESCRIPTION: ${description()}',
                style: TextStyle(
                    fontSize: 20,

                    color: Colors.grey[50]
                ),
                textAlign: TextAlign.center,
              ),
            ),



          ],
        ),

    ),
    );
  }
}
