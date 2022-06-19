import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wos/post.dart';
import 'widget/colors.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "WORDS OF STRANGER",
    home: MainPage(),
  ));
}




class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}



List  data = [] ;
late int index = 0 ;
var url1 = 'https://dagmawibabi.com/wot/getNotes/time/-1';

Color maincolor = Colors.green;

List<String> sorts = ["Chronological" , "Like" , "Dislike" ];
List<String> botsorts = ["ALL" , "BOTS" , "STRANGERS"];
String sort_selected = "ALL";
List bots = [];
List people = [];

String selected = 'Chronological';

void test(){


  int y = 0;
  while(y < data.length){
    if(data[y]["isBot"] == true){
      bots.add(y);
    }
    if(data[y]["isBot"] == false){
      people.add(y);
    }
    y++;
  }

}


Future getData() async {
  var url = Uri.parse(url1);
  var _daat = await http.get(url);
  var jsondata = json.decode(_daat.body);
  data = jsondata;
  return 1;
}



class _MainPageState extends State<MainPage> {








  @override
  void initState() {
    super.initState();
    getData().then((value) => test());

  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
        builder: (context, snapshot) {
        if(snapshot.hasData){
          return Scaffold(
                backgroundColor: Color.fromRGBO(12, 26, 47, 1),
                appBar: AppBar(
                  leading: GestureDetector(
                    onTap: (){
                      setState(() {
                        index = 0 ;
                      });
                    },
                    child: Icon(
                      Icons.refresh,
                      size: 30,

                    ),
                  ),
                  elevation: 0,



                  title:const  Text(
                    "Words of Strangers",
                    style: TextStyle(

                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  centerTitle: true,
                  backgroundColor: Color.fromRGBO(12, 26, 47, 1),

                  actions:[

                    //post


                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: InkWell(
                         onTap: () {
                           setState(() {
                             Navigator.push(context, MaterialPageRoute(builder: (context) => PostPage()));
                           });
                         },
                          child: Icon(
                              Icons.edit
                          )
                      ),
                    )
                  ],
                ),



                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [


                        //note counter


                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(

                            children: [
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    data.length.toString() + " notes so far",
                                    style: TextStyle(
                                      color:  maincolor,
                                      fontSize: 15
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 15,),

                              // DropdownButton(

                              //     onChanged: _selected,
                              // )
                            ],
                          ),
                        ),

                         //body

                         Padding(
                           padding: const EdgeInsets.only(top: 20.0),
                           child: Center(
                             child: Container(

                               decoration: BoxDecoration(
                                   color: Color.fromRGBO(12, 26, 47, 1),
                                   boxShadow:  [BoxShadow(
                                     color: data[index]["color"].toString().toColor(),
                                     offset: Offset(0,1),
                                     blurRadius: 20,
                                   )],
                                   borderRadius: BorderRadius.circular(30),
                                   border: Border.all(
                                       width: 4,
                                       color: data[index]["color"].toString().toColor(),
                                       style: BorderStyle.solid
                                   )
                               ),
                               child: Padding(
                                 padding: const EdgeInsets.symmetric(vertical: 10.0 , horizontal: 10),
                                 child: Column(
                                   children: [

                                     //title

                                     Container(
                                       height: 60,
                                       child:
                                       ListView(
                                         scrollDirection: Axis.horizontal,
                                         children: [
                                           Padding(
                                             padding: const EdgeInsets.only(top: 10.0 , left: 10),
                                             child: Text(
                                               sort_selected == "BOTS" ? data[bots[index]]["title"] :
                                               sort_selected == "STRANGERS" ? data[people[index]]["title"]:
                                               data[index]["title"],
                                               style:  TextStyle(
                                                 fontWeight: FontWeight.bold,
                                                 fontSize: 20,
                                                 color: data[index]["color"].toString().toColor(),
                                               ),
                                             ),
                                           ),

                                         ],
                                       ),
                                     ),

                                     //content

                                     Container(
                                       color: Colors.black45.withBlue(50),
                                       height: 310,
                                       child: ListView(
                                         scrollDirection: Axis.vertical,
                                         children: [
                                           Padding(
                                             padding: const EdgeInsets.only(top: 20.0),
                                             child: Center(
                                               child: Text(
                                                 sort_selected == "BOTS" ? data[bots[index]]["content"] :
                                                 sort_selected == "STRANGERS" ? data[people[index]]["content"]:
                                                 data[index]['content'],

                                                 style: TextStyle(
                                                   fontSize: 22,

                                                   color: data[index]["color"].toString().toColor(),
                                                 ),
                                               ),
                                             ),
                                           )
                                         ],
                                       ),
                                     ),




                                     Container(
                                       height: 20,

                                       child: Text(
                                         data[index]['time'] + "-" + data[index]['date'],
                                         style: TextStyle(
                                             color: maincolor
                                         ),
                                       ),
                                     )
                                   ],
                                 ),
                               ),
                             ),
                           ),
                         ),


                        //like button

                        Padding(
                          padding: const EdgeInsets.only(top: 25.0 , left: 50 , right: 50 , bottom: 15),
                          child: Row(
                            children: [
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap : () {
                                      setState(() {
                                        http.get(Uri.parse('https://dagmawibabi.com/wot/likeNote/${data[index]['title']}/${data[index]['content']}'));
                                      });
                                    },
                                    child: const Text(
                                      "💚",
                                      style: TextStyle(
                                        fontSize: 25
                                      ),
                                    )
                                  ),
                                  Text(
                                    " : \t\t" + data[index]["likes"].toString(),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18
                                    ),
                                  ),
                                  // Icon(Icons.lik)
                                ],
                              ),



                             const  Spacer(),

                              //dislike button


                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        http.get(Uri.parse('https://dagmawibabi.com/wot/dislikeNote/${data[index]['title']}/${data[index]['content']}'));
                                      });
                                    },
                                    child: const Text(
                                      "👎",
                                      style: TextStyle(
                                        fontSize: 25
                                      ),
                                    )
                                  ),
                                  Text(
                                    " : \t\t" + data[index]["dislikes"].toString(),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18
                                    ),
                                  ),
                                  // Icon(Icons.lik)
                                ],
                              ),

                            ],
                          ),
                        ),


                        // buttons


                        Padding(
                          padding: const EdgeInsets.only(top: 20.0 , right: 20 , left: 20 ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [

                              (index > 0 )?  GestureDetector(
                                onTap: (){
                                  setState(() {
                                    index--;

                                  });
                                },
                                child: Container(
                                  height: 50,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(12, 26, 47, 1),
                                      borderRadius: BorderRadius.circular(30),
                                    boxShadow: [
                                      BoxShadow(
                                        color: maincolor,
                                        offset: const Offset(0,0),
                                        blurRadius: 15
                                      )
                                    ]
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.navigate_before_rounded,
                                      color: Colors.white,
                                      size: 30,
                                    )
                                  ),
                                ),
                              ) : Container(width: 100,height:50 ,),



                              //counter
                              SizedBox(
                                child: Center(
                                  child: Text(
                                    (index+1).toString(),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              ),



                              sort_selected == "ALL" ? (index+1) != data.length ? GestureDetector(
                                onTap: (){
                                  setState(() {
                                    index++;

                                  });
                                },
                                child: Container(
                                  height: 50,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      color: const Color.fromRGBO(12, 26, 47, 1),
                                      borderRadius: BorderRadius.circular(30),
                                      boxShadow: [
                                  BoxShadow(
                                  color: maincolor,
                                      offset: const Offset(0,0),
                                      blurRadius: 15
                                  )]
                                ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.navigate_next_rounded,
                                      color: Colors.white,
                                      size: 30,
                                    )
                                  ),
                                )
                              ) : Container(width: 100,height:50 ,) :
                              sort_selected == "BOTS" ? (index+1) != bots.length ?  GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      index++;

                                    });
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        color: const Color.fromRGBO(12, 26, 47, 1),
                                        borderRadius: BorderRadius.circular(30),
                                        boxShadow: [
                                          BoxShadow(
                                              color: maincolor,
                                              offset: const Offset(0,0),
                                              blurRadius: 15
                                          )]
                                    ),
                                    child: const Center(
                                        child: Icon(
                                          Icons.navigate_next_rounded,
                                          color: Colors.white,
                                          size: 30,
                                        )
                                    ),
                                  )
                              ) : Container(width: 100,height:50 ,) :
                                  sort_selected == "STRANGERS" ?  (index+1) != people.length ? GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          index++;

                                        });
                                      },
                                      child: Container(
                                        height: 50,
                                        width: 100,
                                        decoration: BoxDecoration(
                                            color: const Color.fromRGBO(12, 26, 47, 1),
                                            borderRadius: BorderRadius.circular(30),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: maincolor,
                                                  offset: const Offset(0,0),
                                                  blurRadius: 15
                                              )]
                                        ),
                                        child: const Center(
                                            child: Icon(
                                              Icons.navigate_next_rounded,
                                              color: Colors.white,
                                              size: 30,
                                            )
                                        ),
                                      )
                                  ) : Container(width: 100,height:50 ,) : Container(width: 100,height:50 ,)
                            ],
                          ),
                        ),


                        //sort widgets

                        Container(
                          height: 70,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [


                                // sort

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                   height: 40,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: maincolor
                                        ),
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Theme(
                                        data: Theme.of(context).copyWith(canvasColor: Colors.black38 ),
                                        child: DropdownButton<String>(
                                          //menuMaxHeight: 50,
                                          underline: Container(),
                                          value: selected,
                                          items: sorts.map(
                                                  (e) => DropdownMenuItem<String>(
                                                  value: e,
                                                  child: Text(
                                                    e,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: maincolor
                                                    ),
                                                  )
                                              )).toList(),
                                          onChanged: (_value){
                                            setState(() {
                                              selected = _value!;
                                              if(selected == "Chronological"){
                                                url1 = ('https://dagmawibabi.com/wot/getNotes/time/-1');
                                                index = 0;
                                              }
                                              else if (selected == "Like"){
                                                url1 = 'https://dagmawibabi.com/wot/getNotes/likes/-1';
                                                index = 0;
                                              }
                                              else if(selected == "Dislike"){
                                                url1 = 'https://dagmawibabi.com/wot/getNotes/dislikes/-1';
                                                index = 0;
                                              }
                                            });
                                          },

                                        ),
                                      ),
                                    ),
                                  ),
                                ),



                                // bot sort

                                Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: maincolor
                                      ),
                                      borderRadius: BorderRadius.circular(20)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Theme(
                                      data: Theme.of(context).copyWith(canvasColor: Colors.black38 ),
                                      child: DropdownButton<String>(

                                        underline: Container(),
                                        value: sort_selected,
                                        items: botsorts.map(
                                                (e) => DropdownMenuItem<String>(
                                                value: e,
                                                child: Text(
                                                  e,
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: maincolor
                                                  ),
                                                )
                                            )).toList(),
                                        onChanged: (_value){
                                          setState(() {
                                            sort_selected = _value!;
                                            index=0;

                                          });
                                        },

                                      ),
                                    ),
                                  ),
                                )

                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
          );
    };
         return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
               backgroundColor: Colors.black12,
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        });

  }
}

