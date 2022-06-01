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


  Future postData() async {
    var url  = Uri.parse('https://dagmawibabi.com/wot/sendNote/${title.text}/${content.text}');
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
            "WORDS OF STRANGER",
          style: TextStyle(
            color: Colors.white
          ),
        ),
        
      ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 60.0 ,right: 20 , left: 30) ,
                child: Container(
                  width: 350,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(12, 26, 47, 1),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.green,
                            offset: Offset(0,0),
                            blurRadius: 10
                        )
                      ],
                    border: Border.all(
                      color: Colors.green,
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

              Padding(
                padding: const EdgeInsets.only(top: 50.0 , left: 20 , right: 10),
                child: Container(
                  width: 350,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(12, 26, 47, 1),
                    border: Border.all(
                      color: Colors.green,
                      width: 4
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.green,
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


              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      (title.text.isNotEmpty && content.text.isNotEmpty) ?
                      postData().then((value) {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => MainPage())));
                      }) : Fluttertoast.showToast(
                          msg: "incomplete",
                        fontSize: 20,
                        textColor: Colors.green
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
                        color: Colors.green,
                        width: 4
                      ),
                      boxShadow:const  [
                        BoxShadow(
                          color: Colors.green,
                          offset: Offset(0,0),
                          blurRadius: 10
                        )
                      ]
                    ),
                    child: const Center(
                      child: Text(
                        "POST",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )

    );
  }
}
