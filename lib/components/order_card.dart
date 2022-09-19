import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restro_admin/constants.dart';

class OrderCard extends StatelessWidget {
  final String status;
  final int index;

  OrderCard({required this.status, required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 3,
        color: Colors.white, //Color(0xaaf0dff6),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
//mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.table_bar,
                    color: Colors.purple, //Color(0xFF300636),
                    size: 60,
                  ),
                  Text(
                    'Table No ${index + 1}',
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 1,
                  child: Divider(
                    height: 50,
                    thickness: 45,
                    color: kPrimDarkColor,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'ORDER NO: ${100 + index}',
                      style: TextStyle(fontSize: 15),
                    ),
                    const SizedBox(
                      height: 20,
                      child: Divider(
                        thickness: 1,
                        color: kPrimDarkColor,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Status: ',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: (status == 'NEW')
                                      ? Colors.red
                                      : Colors.greenAccent,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                status,
                                style: TextStyle(
                                    color: kPrimDarkColor,
                                    //letterSpacing: 2,
                                    fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'Timer:12:00',
                          style: TextStyle(fontSize: 15),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
