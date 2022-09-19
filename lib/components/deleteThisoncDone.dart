import 'package:flutter/material.dart';

class DeleteMe extends StatelessWidget {
  const DeleteMe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.arrow_drop_down,
                color: Colors.purple,
              ),
              Text(
                category[index],
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.purpleAccent,
                ),
              ),
            ],
          ),
          Row(
            children: [
              //Edit Button
              FloatingActionButton(
                  mini: true,
                  backgroundColor: Colors.white,
                  elevation: 2,
                  child: Icon(
                    Icons.edit,
                    color: Colors.purple,
                  ),
                  onPressed: () {
                    print('Clicked on edit');
                    showDialog(
                        context: context,
                        builder: (context) {
                          return showEditCategoryPopUp(index, context);
                        });
                  }),
              //Add Button
              FloatingActionButton(
                  mini: true,
                  backgroundColor: Colors.white,
                  elevation: 2,
                  child: Icon(
                    Icons.add,
                    color: Colors.purple,
                  ),
                  onPressed: () {}),
              //Delete Button
              FloatingActionButton(
                  mini: true,
                  backgroundColor: Colors.white,
                  elevation: 2,
                  child: Icon(
                    Icons.delete_outlined,
                    color: Colors.purple,
                  ),
                  onPressed: () {
                    catogoryData.remove(category[index]);
                    category.removeAt(index);

                    setState(() {
                      categoryCount = category.length;
                    });
                  })
            ],
          )
        ],
      ),
    );
  }
}
