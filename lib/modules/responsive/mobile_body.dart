import 'package:flutter/material.dart';

class MyMobileBody extends StatelessWidget {
  const MyMobileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[300],
      appBar: AppBar(
        title: const Center(child: Text('M O B I L E')),

      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
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
    );
  }
}
