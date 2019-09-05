import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:vibration/vibration.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:auto_size_text/auto_size_text.dart';




void main(){
  runApp(
    MaterialApp(
      home: SafeArea(
        child: Scaffold(backgroundColor: Colors.white,
          body: MyCal(),
        ),
      ),
    )
  );
}

String userExp = '0';
String answer = "";
String tempExp = "";

void ButtonVibrate(){
  if(Vibration.hasAmplitudeControl() != null){
    Vibration.vibrate(duration: 30,amplitude: 50);
  }else
    Vibration.vibrate(duration: 30);
}

class MyCal extends StatefulWidget {
  @override
  _MyCalState createState() => _MyCalState();
}

class _MyCalState extends State<MyCal> {

  String exxp;


  void backfunc(){

    String currentExp = userExp;

    var len = currentExp.length-1;
    currentExp = currentExp.substring(0, len);

    var templen = tempExp.length-1;

    setState(() {

      userExp = currentExp;
      tempExp = tempExp.substring(0,templen);

    });

    Answer(tempExp);
  }

  void setZero(){
    setState((){
      userExp = userExp + '0';
    });
  }
  void AllClear(){
    setState((){
      userExp = '0';
    });
  }

  void setOprtPlusButtn(String opr){

    String tempOpr = opr;

    if(tempOpr == '×')
      tempOpr = '*';

    if(tempOpr == '÷')
      tempOpr = '/';

    if(tempOpr == '−')
      tempOpr = '-';


    tempExp =  tempExp + tempOpr;

    setState((){

      userExp  = userExp + opr;

    });
    Fluttertoast.showToast(msg: tempExp);
    
    Answer(tempExp);
  }

  void Answer(String finalExp){

    var currExp = finalExp;

    Parser pp = new Parser();
    Expression exp = pp.parse(currExp);

    double ans = exp.evaluate(EvaluationType.REAL, new ContextModel());

    setState((){

      answer = ans.toString();
    });
  }
  @override
  Widget build(BuildContext context) {

    Widget myButton(String num){
      return Expanded(
          child: Container(
              child: OutlineButton(onPressed:(){
                ButtonVibrate();
                setOprtPlusButtn(num);
                Answer(userExp);
                },
                padding: EdgeInsets.all(10.5),
                highlightedBorderColor: Colors.grey[800],
                splashColor: Colors.grey[300],highlightColor: Colors.white,
                child: Text(num,
                  style: TextStyle(fontSize: 30.0,
                      fontFamily: 'MPLUS',
                      color: Colors.grey),),)
          ),
      );
    }
    Widget Operator(String opr){
      return Container(
        child: OutlineButton(onPressed:(){
          setOprtPlusButtn(opr);
        },
          highlightedBorderColor: Colors.green[900],highlightColor: Colors.white,splashColor: Colors.grey[300],
          padding: EdgeInsets.all(10.5),
          child: Text(opr, style: TextStyle(
              color:  Colors.green[800],
              fontWeight: FontWeight.bold,
              fontSize: 30.0,fontFamily: 'MPLUS',),
          ),
        ),
      );
    }
    Widget backButton(){
      return Container(
        child: Expanded(
          child: OutlineButton(
            padding: EdgeInsets.all(10.5),
            highlightedBorderColor: Colors.grey[800],splashColor: Colors.grey[300],highlightColor: Colors.white,

            onPressed: () {
              backfunc();
            },
            child: Text('←',style:
            TextStyle(fontSize: 30.0,fontFamily: 'MPLUS',color: Colors.grey),
            ),
          ),
        ),
      );
    }


    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10.0),width: double.infinity,
            child:  AutoSizeText(
              userExp,textAlign: TextAlign.right,maxLines: 1,maxFontSize: 40,minFontSize: 20,
              style: TextStyle(fontSize: 40.0,color: Colors.grey[400],fontFamily: 'MPLUS',
              ),
            ),
          ),

          Container(
            padding: EdgeInsets.all(10.0),width: double.infinity,
            child:  AutoSizeText(
              answer,textAlign: TextAlign.right,maxLines: 1,maxFontSize: 40,minFontSize: 20,
              style: TextStyle(fontSize: 40.0,color: Colors.grey[400],fontFamily: 'MPLUS',
              ),
            ),
          ),
          Expanded(child: Divider(),),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Row(
                children: <Widget>[
                  backButton(),
                  myButton('%'),
                  Operator('÷'),

                ],),
              Row(
                children: <Widget>[
                  myButton(7.toString()),
                  myButton(8.toString()),
                  myButton(9.toString()),
                  Operator('×'),

                ],),
              Row(
                children: <Widget>[
                  myButton(4.toString()),
                  myButton(5.toString()),
                  myButton(6.toString()),
                  Operator('-')

                ],),
              Row(
                children: <Widget>[
                myButton(1.toString()),
                myButton(2.toString()),
                myButton(3.toString()),
                Operator('+'),

              ],),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: OutlineButton(onPressed: (){
                      setZero();
                    },
                      padding: EdgeInsets.all(7.0),
                      highlightColor: Colors.white,splashColor: Colors.grey[300],highlightedBorderColor: Colors.grey[800],

                      child: Text('0',
                        style: TextStyle(fontSize: 30.0,fontFamily: 'MPLUS',color: Colors.grey)
                        ,textDirection: TextDirection.rtl,),
                    ),
                  ),
                  Expanded(
                    flex:2,
                    child: OutlineButton(onPressed: (){
                      Answer(tempExp);

                    },padding: EdgeInsets.all(7.0),
                      highlightColor: Colors.white,splashColor: Colors.white,highlightedBorderColor: Colors.green[900],
                      textColor: Colors.green[800],
                      child: Text('=',
                        style: TextStyle(fontSize: 30.0,color: Colors.grey,fontFamily: 'MPLUS')),
                    ),
                  ),
                  OutlineButton(onPressed: (){},padding: EdgeInsets.all(7.0),
                    highlightColor: Colors.white,splashColor: Colors.grey[300],highlightedBorderColor: Colors.green[900],
                    child: Text('.',
                        style: TextStyle(fontSize: 30.0,color: Colors.green[800],fontWeight:FontWeight.bold,fontFamily: 'MPLUS')),
                  ),
                ],
              ),


            ],
          ),
        ],
      ),
    );
  }
}
