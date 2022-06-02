import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wos/post.dart';

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

class _MainPageState extends State<MainPage> {


  List  data = [] ;
  late int index = 0 ;



  void sort(){

  }
  Future getData() async {
    var url = Uri.parse('https://dagmawibabi.com/wot/getNotes/time/-1');
    var _daat = await http.get(url);
    var jsondata = json.decode(_daat.body);
    data = jsondata;
    return 1;
  }
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) => getData());
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
                                      color: Colors.green,
                                      fontSize: 20
                                    ),
                                  ),
                                ),
                              ),
                              // DropdownButton(
                              //     items: [
                              //       DropdownMenuItem(
                              //           child: Text("Chronological")
                              //       ),
                              //       DropdownMenuItem(
                              //           child: Text("Like")
                              //       ),
                              //       DropdownMenuItem(
                              //           child: Text("Dislike")
                              //       ),
                              //     ],
                              //     onChanged: _selected,
                              // )
                            ],
                          ),
                        ),


                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Center(
                            child: Container(
                              // height: 410,
                              //width: 390,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(12, 26, 47, 1),
                                  boxShadow: const [BoxShadow(
                                    color: Colors.green,
                                    offset: Offset(0,1),
                                    blurRadius: 20,
                                  )],
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                      width: 4,
                                      color: Colors.green,
                                      style: BorderStyle.solid
                                  )
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0 , horizontal: 10),
                                child: Column(
                                  children: [

                                    //title
                                    
                                    SizedBox(
                                      height: 60,
                                      child:
                                      ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(top: 10.0 , left: 10),
                                            child: Text(
                                              data[index]["title"],
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  color: Colors.white
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
                                               data[index]['content'],
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 22
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
                                          color: Colors.green
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
                                  height: 70,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(12, 26, 47, 1),
                                      borderRadius: BorderRadius.circular(30),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.green.shade500,
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
                              ) : Container(width: 100,height:70 ,),



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



                              ((index+1) != data.length) ? GestureDetector(
                                onTap: (){
                                  setState(() {
                                    index++;
                                  });
                                },
                                child: Container(
                                  height: 70,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      color: const Color.fromRGBO(12, 26, 47, 1),
                                      borderRadius: BorderRadius.circular(30),
                                      boxShadow: [
                                  BoxShadow(
                                  color: Colors.green.shade500,
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
                              ) :  Container(width: 100,height:70 ,),
                            ],
                          ),
                        )

                      ],
                    ),
                  ),
                ),
          );
        }
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
