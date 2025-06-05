import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:project_new/data/models/admin/expences_admin_model.dart';

import '../../widgets/admin/drawer_admin.dart';
import '../../widgets/admin/icon_circle_admin.dart';

void main() {
  runApp(ExpencesAdmin());
}

class ExpencesAdmin extends StatelessWidget {
  const ExpencesAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Expences"),
          backgroundColor: Colors.grey[300],
        ),
        drawer: DrawerAdmin(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconCircleAdmin(
                icon: Icon(Icons.add_circle_outline_outlined, size: 52),
                onpress: () {
                  context.push("/AddExpencesAdmin");
                },
              ),
              SizedBox(height: 50),
              Row(
                children: [
                  Text("Expences Name", style: TextStyle(fontSize: 20)),
                  SizedBox(width: 40),
                  Text("Price", style: TextStyle(fontSize: 20)),
                ],
              ),
              SizedBox(height: 10),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream:
                      FirebaseFirestore.instance
                          .collection('expences')
                          .orderBy('created', descending: true)
                          .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Center(child: Text("No expences found."));
                    }
                    List<ExpencesAdminModel> expences =
                        snapshot.data!.docs.map((doc) {
                          return ExpencesAdminModel.fromMap(
                            doc.data() as Map<String, dynamic>,
                            doc.id,
                          );
                        }).toList();
                    return ListView.separated(
                      itemCount: expences.length,
                      separatorBuilder:
                          (context, index) => SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final exp = ExpencesAdminModel.fromMap(
                          snapshot.data!.docs[index].data()
                              as Map<String, dynamic>,
                          snapshot.data!.docs[index].id,
                        );

                        DateFormat.yMMMd().format(exp.created);
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 180,
                                  child: Text(
                                    exp.name,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    softWrap: true,
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xffFFBB4E),
                                  ),

                                  child: Text(
                                    "${exp.price.toStringAsFixed(1)}\$",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        context.push(
                                          '/EditExpenseAdmin/${exp.id}',
                                        );
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        size: 25,
                                        color: const Color.fromARGB(
                                          255,
                                          8,
                                          43,
                                          104,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        FirebaseFirestore.instance
                                            .collection('expences')
                                            .doc(exp.id)
                                            .delete();
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        size: 25,
                                        color: const Color.fromARGB(
                                          255,
                                          8,
                                          43,
                                          104,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
