import 'package:flutter/material.dart';
import 'package:restro_admin/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

late User loggedIntUser;

class SetMenuScreen extends StatefulWidget {
  const SetMenuScreen({Key? key}) : super(key: key);
  static const String id = "set_menu";
  @override
  _SetMenuScreenState createState() => _SetMenuScreenState();
}

String newCategoryTemp = '';
int categoryCount = category.length;
late final _userRoot;
int counter = 1;
String textValue = "";

class _SetMenuScreenState extends State<SetMenuScreen> {
  String tempCategoryName = '';
  final String uniqueKey = 'sms1234';
  bool isSwitched = false;

  @override
  void initState() {
    _userRoot = FirebaseFirestore.instance
      ..collection('OwnerData')
          .doc(uniqueKey)
          .collection("Menu")
          .doc("hotelMenu");
    super.initState();
  }

  void toggleSwitch(bool value) {
    print('value--> $value');
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
        textValue = 'This Item is Chef Spc';
      });
      print('This Item is Chef Spc');
    } else {
      setState(() {
        isSwitched = false;
        textValue = 'This Item is not Chef Spc';
      });
      print('This Item is not Chef Spc');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('My Menu'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: (categoryCount == 0)
                  ? Text('OOPS.. NO ITEMS ADDED YET!!')
                  : ListView.builder(
                      itemCount: categoryCount,
                      itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  side: BorderSide(color: Colors.purple)),
                              color: Colors.white,
                              elevation: 5,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: SingleChildScrollView(
                                  physics: BouncingScrollPhysics(),
                                  child: Column(
                                    children: [
                                      buildCard(context, index),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet<dynamic>(
                          //isScrollControlled: true,
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListView(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            'Category Name',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontSize: 30,
                                                color: Colors.purple,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 18),
                                          child: TextField(
                                            controller: categoryNameController,
                                            textCapitalization:
                                                TextCapitalization.words,
                                            decoration:
                                                kInputTextDecorationBorder,
                                            autofocus: true,
                                            onChanged: (value) {
                                              tempCategoryName = value;
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 25),
                                          child: OutlinedButton(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: const Text(
                                                'DONE',
                                                style: TextStyle(
                                                    fontSize: 25,
                                                    color: Colors.white),
                                              ),
                                            ),
                                            style: kOutlinedButtonStyle,
                                            onPressed: () {
                                              if (tempCategoryName.length > 0) {
                                                category.add(tempCategoryName);
                                                categoryData.addAll(
                                                    {tempCategoryName: {}});
                                                print(categoryData);
                                                setState(() {
                                                  tempCategoryName = '';
                                                  categoryCount =
                                                      category.length;
                                                });
                                                Navigator.pop(context);
                                              } else {
                                                Navigator.pop(context);
                                              }
                                            },
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    child: Material(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.purple,
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'ADD CATEGORY',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ))),
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    child: Material(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.purple,
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'DONE',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        )),
                    onTap: () async {
                      String category = categoryNameController.text;
                      print('category' + category);
                      //adding category to db
                      await _userRoot
                          .set(categoryData)
                          .then((value) => print("Category Added"));
                    },
                  ))
            ],
          )
        ],
      ),
    );
  }

  Widget buildCard(BuildContext context, int index) => ExpansionTile(
        title: Text(category[index]),
        controlAffinity: ListTileControlAffinity.leading,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
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
                onPressed: () {
                  print('Clicked on Add');
                  showDialog(
                      context: context,
                      builder: (context) {
                        return showAddSubCategoryPopup(index, context);
                      });
                }),
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
                  categoryData.remove(category[index]);
                  category.removeAt(index);
                  categoryCount = category.length;
                })
          ],
        ),
        children: [Text("List of Item shall come here")],
      );
  AlertDialog showAddSubCategoryPopup(int index, BuildContext context) {
    return AlertDialog(
      title: Text("Add Item into ${category[index]}"),
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return SingleChildScrollView(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Item Name"),
                ),
                TextField(
                  controller: itemNameController,
                  decoration: kInputTextDecorationBorder,
                ),
                const Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Item Price"),
                ),
                TextField(
                  controller: itemPriceController,
                  keyboardType: TextInputType.number,
                  decoration: kInputTextDecorationBorder,
                ),
                const Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Item Description"),
                ),
                TextField(
                  controller: itemDescriptionController,
                  decoration: kInputTextDecorationBorder,
                  maxLines: 4,
                ),
                const Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Select Picture"),
                ),
                Image.network(
                  defaultImageUrl,
                  width: 150,
                  height: 150,
                ),
                Text("Cheif Spc."),
                Switch(
                  value: isSwitched,
                  onChanged: (value) => setState(() {
                    isSwitched = value;
                    print("Switch now $isSwitched");
                  }),
                  activeColor: Colors.blue,
                  activeTrackColor: Colors.yellow,
                  inactiveThumbColor: Colors.redAccent,
                  inactiveTrackColor: Colors.orange,
                ),
                OutlinedButton(
                  style: kOutlinedButtonStyle,
                  child: const Text("ADD ITEM"),
                  onPressed: () async {
                    Map<String, dynamic> item = {
                      "itemName": itemNameController.text,
                      "itemPrice": itemPriceController.text,
                      "ItemDescription": itemDescriptionController.text,
                      "imageURL": imageSelected,
                      "inStock": true,
                      "bestSeller": false,
                      "chefSpecial": isSwitched
                    };
                    await _userRoot.set({category[index]: item}).then((value) {
                      counter++;
                      print("Item in ${category[index]} is Added");
                    });
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }

  AlertDialog showEditCategoryPopUp(int index, BuildContext context) {
    return AlertDialog(
      content: Row(
        children: [
          Expanded(child: TextField(
            onChanged: (newData) {
              newCategoryTemp = newData;
            },
          )),
          IconButton(
              icon: Icon(Icons.done_outline_rounded),
              onPressed: () {
                print(newCategoryTemp);
                var categoryValuesList = categoryData.entries.toList();
                dynamic tempValue = categoryValuesList[index].value;
                print('temp value ' + tempValue.toString());
                categoryData.remove(category[index]);

                category[index] = newCategoryTemp;
                categoryData[newCategoryTemp] = tempValue;
                print(categoryData);

                Navigator.pop(context);
              })
        ],
      ),
    );
  }
}
