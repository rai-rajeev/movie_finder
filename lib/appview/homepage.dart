import 'package:find_movies/appview/infopage.dart';
import 'package:find_movies/authentication/loginpage.dart';
import 'package:find_movies/model/genre.dart';

import 'package:find_movies/model/top_rated_movies.dart';
import 'package:find_movies/appview/searchScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:find_movies/model/now_playing.dart';

import 'package:find_movies/services/remoteservices.dart';

import '../model/trendingMovies.dart';

Map<int,String>?genereMap;
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String  route='/home';
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TrendingMovies? _trending;
  bool _IsTrenLoaded=false;
  TopRatedMovies? _toprated;
  bool _IsTopRatedLoaded=false;
  NowPlayingMovies? _nowPlaying;
  bool _IsNowPlayingLoaded=false;

  bool IsGenLoaded=false;

  @override
  void initState(){
    super.initState();
    getTrend();
    getTopRated();
    getNowplaying();
    getgenre();

  }
  getTrend()async{
    try {
      _trending = await RemoteServices().getTrending();
      if (_trending != null) {
        debugPrint('succesful_trending');
        setState(() {
          _IsTrenLoaded = true;
        });
      }
    }catch(e){
      SnackBar Mysnackbar=SnackBar(content: Text('$e'));
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(Mysnackbar);
    }
  }
  getTopRated()async{
    try {
      _toprated = await RemoteServices().getToprated();
      if (_toprated != null) {
        debugPrint('succesful _toprated');
        setState(() {
          _IsTopRatedLoaded = true;

        });
      }
    }catch(e){
      SnackBar Mysnackbar=SnackBar(content: Text('$e'));
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(Mysnackbar);
    }

  }
  getNowplaying()async{
    try {
      _nowPlaying = await RemoteServices().getNowPlaying();
      if (_nowPlaying != null) {
        debugPrint('successful _nowplaying');
        setState(() {
          _IsNowPlayingLoaded = true;
        });
      }
    }catch(e){
      SnackBar Mysnackbar=SnackBar(content: Text('$e'));
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(Mysnackbar);
    }

  }
  getgenre()async{
    try {
     final  Generes? Genres = await RemoteServices().getGenre();
      if (Genres != null) {
        for(var i in Genres.genres!){
          Map<int,String> ok={
            i.id:i.name
          };
            if(genereMap==null){
              genereMap=ok;
            }
            else
         { genereMap!.addEntries(ok.entries);}


        }
        debugPrint('successful genres');
        setState(() {
          IsGenLoaded = true;

        });
      }
    }catch(e){
      SnackBar Mysnackbar=SnackBar(content: Text('$e'));
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(Mysnackbar);
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[900],
        body: Visibility(
          visible: ( _IsTopRatedLoaded && _IsTrenLoaded && _IsNowPlayingLoaded ),
          replacement: const Center(child: CircularProgressIndicator(),),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(


                    decoration: const BoxDecoration(
                        color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 9,),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(

                            decoration: BoxDecoration(
                                color: Colors.grey[50],
                                shape: BoxShape.circle
                            ),
                            child: IconButton(
                                onPressed:(){
                                  Navigator.push((context),
                                      MaterialPageRoute(builder: (context)=>SearchScreen()));
                                },
                                icon:const Icon(Icons.search,
                                  size: 28,
                                )),
                          ),
                        ),
                        const Text('Search Movies',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 26
                        ),),
                        const SizedBox(width: 50,),

                        PopupMenuButton(
                            itemBuilder: (context){
                              return [
                              PopupMenuItem(

                                onTap: ()async{
                                  await FirebaseAuth.instance.signOut();
                                  Navigator.pushReplacement((context),
                                      MaterialPageRoute(builder: (context)=>LoginScreen()));
                                },
                                child:const Row(
                                  children: [
                                    Icon(Icons.logout),
                                    SizedBox(width: 6,),
                                    Text('Logout')
                                  ],
                                ),
                              ),
                              ];
                            })

                      ],
                    ),
                  ),
                ),
                Text('Trending Movies',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[100],
                  ),
                    ),
                const SizedBox(height: 10,),
                SizedBox(
                  height:280,
                  width: 400,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount:_trending?.results?.length , itemBuilder: (context,index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image(
                                image: NetworkImage("https://image.tmdb.org/t/p/w600_and_h900_bestv2${_trending!.results![index].posterPath!}"),
                                height: 150,
                                         ),
                            ),
                              SizedBox(
                                width:130,
                                child: TextButton(

                                  onPressed: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context)=>InfoScreen(index: index,trend: _trending,genres: genereMap,)));

                                  },

                                  child: Text(_trending!.results![index].title!,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[100],
                                    overflow: TextOverflow.ellipsis

                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 3,),
                                ),
                              ),


                            ],
                          ),
                        );
                      }
                    ),
                ),
                const SizedBox(height: 10,),
                Text('Top Rated Movies',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[100],
                  ),
                ),

                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    height: 280,
                    width: 400,
                    child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _toprated?.results?.length,
                    itemBuilder: (context,index) {
                    return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      children: [
                        Image(
                          image: NetworkImage("https://image.tmdb.org/t/p/w600_and_h900_bestv2${_toprated!.results![index].posterPath!}"),
                          height: 150,
                        ),
                        SizedBox(
                          width:130,
                          child: TextButton(
                            onPressed:(){

                            Navigator.push(context,
                            MaterialPageRoute(builder: (context)=>InfoScreen(index: index,toprated: _toprated,genres: genereMap,)));},

                            child: Text(_toprated!.results![index].title!,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[100],

                            ),
                            textAlign: TextAlign.center,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,),
                          ),
                        )
                      ],
                    ),
                    );
                    }
                    )
                    ),
                Text('Now Playing',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[100],
                  ),
                ),
                Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    height: 280,
                    width: 400,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:_nowPlaying?.results?.length,
                        itemBuilder: (context,index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image(
                                    image: NetworkImage("https://image.tmdb.org/t/p/w600_and_h900_bestv2${_nowPlaying!.results![index].posterPath}"),
                                    height: 150,
                                  ),
                                ),
                                SizedBox(
                                  width:130,
                                  child: TextButton(
                                          onPressed: () {
                                          Navigator.push(context,
                                          MaterialPageRoute(builder: (context)=>InfoScreen(index: index,nowplay: _nowPlaying,genres: genereMap,)));
                                          },
                                    child: Text(_nowPlaying!.results![index].title,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                      color: Colors.grey[100],
                                      overflow: TextOverflow.ellipsis,

                                    ),
                                    maxLines: 3,
                                    textAlign: TextAlign.center,),
                                  ),
                                )
                              ],
                            ),
                          );
                        }
                    )
                ),
                const SizedBox(height: 30,)
              ],
            ),
          ),
        ),
    );
  }
}
