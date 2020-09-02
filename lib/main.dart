import 'package:flutter/material.dart';
import 'package:calculator/digits.dart';
import 'package:math_expressions/math_expressions.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var input='';
  var output='';

  final List<String> button=['AC','DEL','%','/', '9','8','7','x', '6','5','4','-','3','2','1','+','0','.','ANS','=',];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 0,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(height: 40),
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerLeft,
                    child: Text(input,style: TextStyle(fontSize: 23),),),
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(output,style: TextStyle(fontSize: 23),),),
                ],
              ),
            ),),
          Expanded(
            flex:2,
            child: Container(
              child: GridView.builder(
                  itemCount: button.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                  itemBuilder: (BuildContext context,int index){
                    if(index==0){
                      return digits(
                        onclick: (){
                          setState(() {
                            input='';
                            output ='';
                          });
                        },
                        buttontext: button[index],
                        color:Colors.green[600],
                        digitcolor: Colors.white,
                      );
                    }//delete button
                    else if( index==1 ){
                      return digits(
                        onclick: (){
                          setState(() {
                            input=input.substring(0,(input.length-1));
                          });
                        },
                        buttontext: button[index],
                        color:Colors.red[600],
                        digitcolor: Colors.white,
                      );
                    }//equal too sign
                    else if( index==button.length-1 ){
                      return digits(
                        onclick: (){
                          setState(() {
                            onpress();
                          });
                        },
                        buttontext: button[index],
                        color:Colors.grey[800],
                        digitcolor: Colors.white,
                      );
                    }
                    else
                    {
                      return digits(
                        onclick: (){
                          setState(() {
                            input+=button[index];
                          });
                        },
                        buttontext: button[index],
                        color:operator(button[index]) ? Colors.grey[800] :Colors.grey[500],
                        digitcolor: operator(button[index]) ? Colors.white :Colors.red[350],
                      );

                    }
                  }),
            ),
          ),
        ],
      ),

    );
  }

  bool operator(String x){
    if(x=='%' || x=='/' || x=='+' || x=='-'|| x=='='|| x=='x'){
      return true;
    }
    return false;
  }

  void onpress(){
    String finalinput=input;
    finalinput = finalinput.replaceAll('x','*');
    Parser p=Parser();
    Expression exp=p.parse(finalinput);
    ContextModel cn=ContextModel();
    double eval=exp.evaluate(EvaluationType.REAL, cn);
    output=eval.toString();


  }

}

