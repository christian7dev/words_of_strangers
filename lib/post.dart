import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wos/main.dart';
import 'package:fluttertoast/fluttertoast.dart';


class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {


  var title = TextEditingController();
  var content = TextEditingController();
  var postcolor = (Colors.green).value.toRadixString(16).toString().toUpperCase().replaceRange(0, 2, "");

  List colors = [
    Color.fromRGBO(255,255,255,1) , Color.fromRGBO(43,174,102,1) ,Color.fromRGBO(237, 255, 0, 1), Color.fromRGBO(0,164,204,1), Color.fromRGBO(255,161,119,1),
    Color.fromRGBO(162,162,161,1) , Color.fromRGBO(249,161,46,1) , Color.fromRGBO(254,71,115,1) , Color.fromRGBO(147,61,201,1), Color.fromRGBO(97,181,159,1),
    Color.fromRGBO(246, 60, 202, 1) , Color.fromRGBO(0,237,0,1) , Color.fromRGBO(236,42,28,1), Color.fromRGBO(255,124,0,1)
  ];

  Color color101 = Colors.green;

  Future postData() async {
    var url  = Uri.parse('https://dagmawibabi.com/wot/sendNote/${title.text}/${content.text}/${postcolor}');
    var _data = await http.get(url);
    return _data ;
  }
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: const Color.fromRGBO(12, 26, 47, 1),
      appBar: AppBar(
        backgroundColor:const Color.fromRGBO(12, 26, 47, 1),
        centerTitle: true,
        title:const  Text(
            "Words of Strangers",
          style: TextStyle(
            color: Colors.white,
            fontSize: 23,
            fontWeight: FontWeight.bold
          ),
        ),
        
      ),
        body: SingleChildScrollView(
          child: Column(
            children: [


              //title block


              Padding(
                padding: const EdgeInsets.only(top: 60.0 ,right: 20 , left: 20) ,
                child: Container(
                  width: 400,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(12, 26, 47, 1),
                      boxShadow: [
                        BoxShadow(
                            color: color101,
                            offset: Offset(0,0),
                            blurRadius: 10
                        )
                      ],
                    border: Border.all(
                      color: color101,
                      width: 4
                    ),
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20.0 , left: 10),
                    child: TextFormField(
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20
                      ),
                      maxLines: 1,
                      maxLength: 100,
                      decoration: const InputDecoration(
                        counterStyle: TextStyle(
                          color: Colors.white54,
                          fontSize: 15
                        ),
                        hoverColor: Colors.white,
                        border: InputBorder.none,
                        hintText: "TITLE OF YOUR NOTE",
                        hintStyle: TextStyle(
                          color: Colors.white38,
                          fontWeight: FontWeight.bold
                        )
                      ),
                      controller: title,

                    ),
                  ),
                ),
              ),


              //content block


              Padding(
                padding: const EdgeInsets.only(top: 30.0 , left: 10 , right: 10),
                child: Container(
                  width: 400,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(12, 26, 47, 1),
                    border: Border.all(
                      color: color101,
                      width: 4
                    ),
                    boxShadow:  [
                      BoxShadow(
                        color: color101,
                        offset: Offset(0,0),
                        blurRadius: 10
                      )
                    ],
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0 , right: 10),
                    child: TextFormField(
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20
                      ),
                      maxLines: 10,
                      maxLength: 400,
                      decoration:const  InputDecoration(
                          counterStyle: TextStyle(
                              color: Colors.white54,
                              fontSize: 15
                          ),
                        border: InputBorder.none,
                        hintText: "What do you want to say?",
                        hintStyle: TextStyle(
                          color: Colors.white38,
                          fontWeight: FontWeight.bold
                        )
                      ),
                      controller: content,

                    ),
                  ),
                ),
              ),



              //post button


              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: GestureDetector(
                  onTap: (){
                    setState(() {

                      (title.text.isNotEmpty && content.text.isNotEmpty) ?
                      postData().then((value) {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => MainPage())));
                      }) : Fluttertoast.showToast(
                          msg: "incomplete",
                        fontSize: 20,
                        textColor: color101,
                      );
                    });
                  },
                  child: Container(
                    height:70,
                    width: 150,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(12, 26, 47, 1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: color101,
                        width: 4
                      ),
                      boxShadow:  [
                        BoxShadow(
                          color: color101,
                          offset: Offset(0,0),
                          blurRadius: 10
                        )
                      ]
                    ),
                    child: Center(
                      child: Text(
                        "POST",
                        style: TextStyle(
                          color: color101,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ),
              ),


              Padding(
                padding: const EdgeInsets.only(top:10.0),
                child: Container(
                  height: 150,
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7),
                      itemCount: 14,
                      itemBuilder: (context , int index){
                        return Padding(
                          padding: const EdgeInsets.only(left: 10 , top: 10),
                          child: GestureDetector(
                            onTap: (){
                              setState(() {
                                color101 = colors[index];
                               postcolor = (colors[index].value.toRadixString(16).toString().toUpperCase().replaceRange(0, 2, ""));
                              });
                            },
                            child: CircleAvatar(
                              radius: 10,
                              backgroundColor: colors[index]
                            ),
                          ),
                        );
                      }
                  ),
                ),
              ),


            ],
          ),
        )

    );
  }
}
