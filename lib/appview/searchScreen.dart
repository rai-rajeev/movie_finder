
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
          child: Column(
            children: [
              Container(
                height: 30,
                color: Colors.white60,
              ),
              Container(
                color: Colors.white60,
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: (){

                            Navigator.pop((context));

                        },
                        icon: const Icon(Icons.arrow_back,
                        size: 30,),
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
                      decoration: const BoxDecoration(
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
              Visibility(
                visible: _Isloaded,
                replacement: Center(
                  child: Container(),
                ),
                child: Expanded(
                  child: GridView.builder(
                    itemCount: _searchmovies?.results.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                        childAspectRatio: .5

                  ), itemBuilder: ((context,index)=>Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      Flexible(
                        child: Image(
                         fit:BoxFit.cover,
                          image: NetworkImage((_searchmovies!.results[index].posterPath!='')?
                          "https://image.tmdb.org/t/p/w600_and_h900_bestv2${_searchmovies!.results[index].posterPath}"
                              :"https://vcunited.club/wp-content/uploads/2020/01/No-image-available-2.jpg"),
                        ),
                      ),
                      SizedBox(
                        height: 100,
                        child: TextButton(
                            onPressed:()
                            {Navigator.push(context,
                                MaterialPageRoute(builder: (context)=>InfoScreen(index: index,searchmov: _searchmovies,genres: genereMap,)));},
                            child: Text(_searchmovies!.results[index].title!,
                              style:  const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w300,


                              ),
                              maxLines:1 ,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,)),
                      ),


                    ],
                  ))),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}



