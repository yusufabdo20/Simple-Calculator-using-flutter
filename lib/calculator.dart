import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
class Calculator extends StatefulWidget {
  // const Calculator({ Key? key }) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String input = "0";
  String output = "0";
  String expression = "";

  clickOnButton(String buttonContent) {
    setState(() {
      if (buttonContent == 'C') {
        input='0';
        output = '0'; 
      } else if (buttonContent == '⟽') {
        input=input.substring(0,input.length-1);
      } else if (buttonContent == '=') {
        expression= input  ;
        expression=expression.replaceAll("÷",'/') ;
        expression=expression.replaceAll("×",'*') ;
       
        try {
         Parser p = Parser();
  Expression exp = p.parse(expression);

  ContextModel cm = ContextModel();
  output ='${exp.evaluate(EvaluationType.REAL, cm)}' ;

  
        }catch(e){
          output='Error !!!' ;
        }

      } else {
        if (input=='0')
          input =buttonContent;
        
        else
        input = input+buttonContent;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Calculator'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20.0),
            alignment: Alignment.center,
            child: Text(input,
                style: TextStyle(
                  fontSize: 30,
                )),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            alignment: Alignment.center,
            child: Text(output,
                style: TextStyle(
                  fontSize: 40,
                )),
          ),
          Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  width: MediaQuery.of(context).size.width * .75,
                  child: Table(
                    children: [
                      TableRow(
                        children: <Widget>[
                          buildButton(
                              'C', 1.0, Color.fromARGB(255, 150, 61, 61)),
                          buildButton('⟽', 1, Color.fromARGB(255, 58, 119, 90)),
                          buildButton('÷', 1, Color.fromARGB(255, 150, 61, 61)),
                        ],
                      ),
                      TableRow(
                        children: <Widget>[
                          buildButton(
                              '7', 1.0, Color.fromARGB(255, 68, 87, 150)),
                          buildButton('8', 1, Color.fromARGB(255, 68, 87, 150)),
                          buildButton('9', 1, Color.fromARGB(255, 68, 87, 150)),
                        ],
                      ),
                      TableRow(
                        children: <Widget>[
                          buildButton(
                              '4', 1.0, Color.fromARGB(255, 68, 87, 150)),
                          buildButton('5', 1, Color.fromARGB(255, 68, 87, 150)),
                          buildButton('6', 1, Color.fromARGB(255, 68, 87, 150)),
                        ],
                      ),
                      TableRow(
                        children: <Widget>[
                          buildButton(
                              '1', 1.0, Color.fromARGB(255, 68, 87, 150)),
                          buildButton('2', 1, Color.fromARGB(255, 68, 87, 150)),
                          buildButton('3', 1, Color.fromARGB(255, 68, 87, 150)),
                        ],
                      ),
                      TableRow(
                        children: <Widget>[
                          buildButton(
                              '.', 1.0, Color.fromARGB(255, 68, 87, 150)),
                          buildButton('0', 1, Color.fromARGB(255, 68, 87, 150)),
                          buildButton(
                              '00', 1, Color.fromARGB(255, 68, 87, 150)),
                        ],
                      ),
                    ],
                  )),
              Container(
                width: MediaQuery.of(context).size.width * .25,
                child: Table(
                  children: [
                    TableRow(
                      children: <Widget>[
                        buildButton('×', 1.0, Color.fromARGB(255, 150, 61, 61)),
                      ],
                    ),
                    TableRow(
                      children: <Widget>[
                        buildButton('-', 1.0, Color.fromARGB(255, 150, 61, 61)),
                      ],
                    ),
                    TableRow(
                      children: <Widget>[
                        buildButton('+', 1.0, Color.fromARGB(255, 150, 61, 61)),
                      ],
                    ),
                    TableRow(
                      children: <Widget>[
                        buildButton('=', 2.0, Color.fromARGB(255, 23, 165, 58)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  deleteElement() {
    return Container(
        decoration: BoxDecoration(color: Colors.red),
        child: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back),
        ));
  }

  Widget buildButton(
      String buttonContent, double buttonHeight, Color buttonColor) {
    return Container(
      padding: EdgeInsets.all(3),
      child: TextButton(
        onPressed: () => clickOnButton(buttonContent),
        child: Text(
          '$buttonContent',
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
          ),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(buttonColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
              side: BorderSide(color: Colors.white, style: BorderStyle.solid),
            ),
          ),
        ),
      ),
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      // color:Colors.red,
    );
  }
}
