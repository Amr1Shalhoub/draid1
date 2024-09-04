import 'package:flutter/material.dart';

class MyDesktopBody extends StatelessWidget {
  const MyDesktopBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[300],
      appBar: AppBar(
        title:const Center(child: Text('D E S K T O P')),

      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            // First Column
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Container(
                        color: Colors.deepPurple[400],
                      ),
                    ),
                  ),
                  Expanded(
                      child:ListView.separated(
                        itemBuilder: (context,index) {
                          return Container(
                            height: 120,
                            color: Colors.deepPurple[100],
                          );
                        },
                        separatorBuilder:(context,index){
                          return const SizedBox(height: 10,);
                        },
                        itemCount: 8,
                      )
                  ),
                ],
              ),
            ),
            Container(
              width: 200,
              color: Colors.deepPurple[200],
            )
          ],
        ),
      ),
    );
  }
}