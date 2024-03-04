import 'package:flutter/material.dart';

class ProductAddedDialog extends StatelessWidget {
  const ProductAddedDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: Future.delayed(const Duration(seconds: 2)), // Simulate delay
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return SimpleDialog(
            title: const Text('Success!'),
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Your product has been successfully added to the catalog.',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'),
                  ),
                ],
              ),
            ],
          );
        }
      },
    );
  }
}