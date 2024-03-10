// TODO Implement this library.import 'package:FixItParts/main.dart';
import 'package:flutter/material.dart';

class SuccessScreen extends StatefulWidget {
  final title;
  final status;
  final duration;
  final category;
  final imageUrl;
  final price;
  const SuccessScreen({required this.title, this.status = '', required this.duration,
    required this.category, required this.imageUrl, required this.price});

  @override
  State<SuccessScreen> createState() => _SuccessScreen();
}

class _SuccessScreen extends State<SuccessScreen> {

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Service Added", style: TextStyle(fontSize: 18),),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white24,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20,),
              Icon(Icons.check_circle_outline_outlined, color: Colors.green, size: 70),
              Text("Service Successfully Added to your Catalogue",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.green
                ),
              ),
              SizedBox(height: 20,),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(style: BorderStyle.solid, color: Colors.green)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 100,
                        child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(widget.imageUrl),
                        ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.title, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),),
                            SizedBox(height: 3,),
                            Text('${widget.status}', style: TextStyle(fontSize: 12),),
                            SizedBox(height: 3,),
                            Text('Duration: ${widget.duration}', style: TextStyle(fontSize: 12),),
                            Text('Category: ${widget.category}', style: TextStyle(fontSize: 12),),
                            Text('Listed Price: ₹${widget.price}', style: TextStyle(fontSize: 12),)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}