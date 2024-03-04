import 'package:flutter/material.dart';
import 'Manage_Screen.dart';

class SelectableList extends StatefulWidget {
  final List<Product> myList;

  const SelectableList({Key? key, required this.myList}) : super(key: key);

  @override
  State<SelectableList> createState() => _SelectableListState();
}

class _SelectableListState extends State<SelectableList> {

  @override
  Widget build(BuildContext context) {
    print('Thik Thak Chal Raha hai - ${widget.myList}');
    return Column(
      children: [

        ListView.builder(
          shrinkWrap: true, // Avoid list taking excessive space
          itemCount: widget.myList.length,
          itemBuilder: (context, index) {
            final item = widget.myList[index];
            return Padding(
              padding: const EdgeInsets.only(left: 8,right: 8,top: 11),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(style: BorderStyle.solid, color: Colors.grey),
                  borderRadius: BorderRadius.circular(12)
                  ),
                child: ListTile(
                  title: Container(
                    height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                            Container(
                              height: 100.0,
                              width: 100.0,
                              decoration: BoxDecoration(
                                border: Border.all(style: BorderStyle.none,width: 1,color: Colors.blue),
                                borderRadius: BorderRadius.circular(20),
                                shape: BoxShape.rectangle,
                                image: DecorationImage(
                                  image: NetworkImage(item.imageUrl),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),

                          Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Title: ${item.title.substring(0, 17)}'),
                                Text('         ${item.title.substring(17, 26)}...'),
                                Text('id: ${item.id.substring(0, item.id.length - 12)} ...'),
                                Text('Category: ${item.category}'),
                                // Text('Price: ₹${item.price}'),
                              ],
                            ),
                          ),
                        ],
                      )
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => {

                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
