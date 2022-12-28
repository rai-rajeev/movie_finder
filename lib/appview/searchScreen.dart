
import 'package:find_movies/appview/homepage.dart';
import 'package:find_movies/appview/infopage.dart';
import 'package:find_movies/model/searchmovies.dart';
import 'package:find_movies/services/remoteservices.dart';

import 'package:flutter/material.dart';
class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  SearchMovies? _searchmovies;
  bool _Isloaded=false;
  final TextEditingController _controller6=TextEditingController();
  getsearch( String query)async{
    try {
      _searchmovies = await RemoteServices().getSearchMovie(query);
      if (_searchmovies != null) {

        debugPrint('successfully searched movies');
        setState(() {
          _Isloaded=true;
        });

      }
    }catch(e){
      SnackBar Mysnackbar=SnackBar(content: Text('$e'));
      ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(Mysnackbar);
      setState(() {
        _Isloaded=false;
      });
    }

  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScopeNode currentFocus=FocusScope.of(context);
        if(!currentFocus.hasPrimaryFocus){
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey[900],
        body: Center(
          child: ListView(
            children: [
              Container(
                width: 200,
                color: Colors.white60,
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: (){

                            Navigator.pop((context));

                        },
                        icon: Icon(Icons.arrow_back,
                        size: 36,),
                    color: Colors.grey[50],
                    ),
                    Container(
                      width: 270,
                      color: Colors.grey,
                      child: Builder(
                        builder: (context) {
                          return TextField(
                            controller: _controller6,

                            textInputAction: TextInputAction.go,
                            onSubmitted: (value){
                              if(value.isEmpty){
                                showDialog(context: context,
                                    builder: (context)=>AlertDialog(
                                      content: const Text('Please Enter something to search'),
                                      actions: [
                                        Builder(
                                          builder: (context) {
                                            return ElevatedButton(onPressed: (){
                                              Navigator.of(context,rootNavigator: true).pop();
                                            }
                                                , child: const Text('Ok'));
                                          }
                                        )
                                      ],
                                    ));

                              }
                              else {
                                getsearch(value.toString());
                              }
                            },
                            decoration: InputDecoration(
                              hintText: 'Search Here! ',
                              filled: true,
                              fillColor: Colors.grey[50],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),

                              )

                            ),
                          );
                        }
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.circle
                      ),
                      child: IconButton(
                          onPressed: (){

                            final String query=_controller6.text;

                            if(query.isEmpty){
                              Navigator.pop(context);
                            }
                            else{setState(() {
                              _controller6.clear();
                            });}

                          },
                          icon: Icon(Icons.clear,
                          color: Colors.grey[50],
                          size: 36,)),
                    )
                  ],
                )

              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                  child:Visibility(
                    visible: _Isloaded,
                    replacement: Center(
                      child: Container(),
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Padding(padding:
                          const EdgeInsets.symmetric(vertical: 10,horizontal: 15)
                          ,child:Text("Result found: ${_searchmovies?.results.length}",
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                            ),),
                          ),
                          SizedBox(
                            height: 800,
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: _searchmovies?.results.length,
                                itemBuilder: (context,index){
                                return Column(
                                  children: [

                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: SizedBox(

                                        child: Image(

                                            image: NetworkImage((_searchmovies!.results[index].posterPath!='')?"https://image.tmdb.org/t/p/w600_and_h900_bestv2${_searchmovies!.results[index].posterPath}":"https://vcunited.club/wp-content/uploads/2020/01/No-image-available-2.jpg")
                                            ,height: 300,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 200,
                                      child: TextButton(
                                        onPressed:()
                                        {Navigator.push(context,
                                            MaterialPageRoute(builder: (context)=>InfoScreen(index: index,searchmov: _searchmovies,genres: genereMap,)));},
                                          child: Text(_searchmovies!.results[index].title!,
                                          style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          textAlign: TextAlign.center,)),
                                    ),
                                    const SizedBox(height: 10,)

                                  ],
                                );
                                }),
                          ),
                        ],
                      ),
                    ),
                  ) ,
              ),

            ],
          ),
        ),
      ),
    );
  }
}



