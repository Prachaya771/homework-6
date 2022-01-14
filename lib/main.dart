import 'package:flutter/material.dart';
import 'package:homework_6/game.dart';

void main() {
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final _con = TextEditingController();
  var game = Game();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GUESS THE NUMBER'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.purple.shade50,
            boxShadow: [
              BoxShadow(
                color: Colors.purple.withOpacity(0.5),
                blurRadius: 5.0,
                offset: const Offset(1.0, 1.0),
                spreadRadius: 5.0,
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Column(
            //mainAxisSize: MainAxisSize.min,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Row(
              //   children: [
              //     Container(
              //       width: 50.0,
              //       height: 50.0,
              //       color: Colors.blue,
              //     ),
              //     // Expanded(
              //     //   child: Container(
              //     //     width: 50.0,
              //     //     height: 50.0,
              //     //     //color: Colors.orange,
              //     //   ),
              //     // ),
              //     // Expanded(
              //     //   child: Container(
              //     //     width: 50.0,
              //     //     height: 50.0,
              //     //     color: Colors.pink,
              //     //     child: Padding(
              //     //       padding: const EdgeInsets.all(8.0),
              //     //       child: Text('FLUTTER',textAlign: TextAlign.end,),
              //     //     ),
              //     //     alignment: Alignment.centerRight,
              //     //   ),
              //     // ),
              //     //SizedBox(width: 10.0,),
              //   ],
              // ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/guess_logo.png', width: 100.0),
                    const SizedBox(width: 8.0),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      //mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'GUESS',
                          style: TextStyle(
                            fontSize: 36.0,
                            color: Colors.purple.shade200,
                          ),
                        ),
                        const Text(
                          'THE NUMBER',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.purple,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              // Expanded(child: Container()),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.7),
                    border: OutlineInputBorder(),
                    hintText: 'ทายเลขตั้งแต่ 1 ถึง 100',
                  ),
                  textAlign: TextAlign.center,
                  controller: _con,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.purple),
                  ),
                  onPressed: () {
                    var input = _con.text;
                    var num = int.tryParse(input);

                    if (num == null) {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('RESULT'),
                              content: Text(
                                  'กรอกข้อมูลไม่ถูกต้อง ให้กรอกเฉพาะตัวเลขเท่านั้น'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('OK')),
                              ],
                            );
                          });
                    } else {
                      var check = game.doGuess(num);

                      if (check == 1) {
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('RESULT'),
                                content: Text('$num มากเกินไป กรุณาลองใหม่'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('OK')),
                                ],
                              );
                            });
                      } else if (check == -1) {
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('RESULT'),
                                content: Text('$num น้อยเกินไป กรุณาลองใหม่'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('OK')),
                                ],
                              );
                            });
                      } else if (check == 0) {
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('RESULT'),
                                content:
                                    Text('$num ถูกต้องครับ คุณทายทั้งหมด ${game.guessCount}'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('OK')),
                                ],
                              );
                            });
                      }
                    }
                  },
                  child: const Text('GUESS',
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
