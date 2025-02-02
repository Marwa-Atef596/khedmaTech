import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khedma_tech/views/Rate%20&%20Review/Rate%20&%20Review.dart';
import 'package:khedma_tech/views/details_handman.dart';

import '../../core/constent.dart';
import '../chat/chat_screen.dart';

class HandMan extends StatelessWidget {
  String? data;
  HandMan(String? this.data);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()async {
        print("----------------------");
        DocumentSnapshot doc = await FirebaseFirestore.instance
            .collection("handman")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();
        if (doc.exists) {
          Get.to(details_handman(this.data,"handman"));
        } else {
          Get.to(details_handman(this.data,"users"));
        }

      },
      child: Container(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 2, right: 2),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 0.8,
                    ),
                  ]),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("users")
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if(snapshot.connectionState==ConnectionState.waiting)
                                {
                                  return Text("");
                                }
                              if(snapshot.hasError)
                                {
                                  return Text("error");
                                }

                              if(snapshot.hasData==false || snapshot.data!.exists==false)
                              {


                                 return Text("");
                                }
                              return IconButton(
                                onPressed: () async {
                                  String type="";
                                  DocumentSnapshot doc = await FirebaseFirestore.instance
                                      .collection("handman")
                                      .doc(FirebaseAuth.instance.currentUser!.uid)
                                      .get();
                                  if (doc.exists) {
                                    type="handman";
                                  } else {
                                    type="users";

                                  }
                                  DocumentSnapshot dc = await FirebaseFirestore.instance.collection(type=="users"?"users":"handman").doc(FirebaseAuth.instance.currentUser!.uid).get();
                                  List fav = dc["favorites"];
                                  if (fav.contains(this.data)) {
                                    fav.remove(this.data);
                                  } else {
                                    fav.add(this.data);
                                  }
                                  await FirebaseFirestore.instance.collection(type=="users"?"users":"handman").doc(FirebaseAuth.instance.currentUser!.uid).update({
                                    "favorites": fav
                                  });
                                  if (fav.contains(this.data)) {
                                    Get.snackbar("Notification", "تمت الاضافة ");
                                  } else {
                                    Get.snackbar("Notification", "تمت الازالة");
                                  }
                                },
                                icon: const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                ),
                              );

                            },),
                        IconButton(
                            onPressed: () async {
                              String type="";
                              DocumentSnapshot doc = await FirebaseFirestore.instance
                                  .collection("handman")
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .get();
                              if (doc.exists) {
                                type="handman";
                              } else {
                                type="users";
                                //
                              }

                              QuerySnapshot qs = await FirebaseFirestore
                                  .instance
                                  .collection("discussions")
                                  .where("receiver", isEqualTo: this.data)
                                  .where("owner",isEqualTo: FirebaseAuth.instance.currentUser!.uid )
                                  .get();
                              if (qs.docs.isNotEmpty) {
                                Get.to(ChatScreen(id: qs.docs.first.id,type: type ,));
                              } else {
                                DocumentReference doc = await FirebaseFirestore
                                    .instance
                                    .collection("discussions")
                                    .add({
                                  "owner":
                                  FirebaseAuth.instance.currentUser!.uid,
                                  "receiver": this.data,
                                  "messages": []
                                });
                                print("not exist");
                                Get.to(ChatScreen(id: doc.id,type: type,));
                              }
                            },
                            icon: const Icon(
                              Icons.mark_chat_unread_rounded,
                              color: Colors.green,
                            ))

                      ],
                    ),
                    StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                      stream: FirebaseFirestore.instance
                          .collection("handman")
                          .doc(data)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (!snapshot.hasData ||
                            !snapshot.data!.exists) {
                          return Text('Document does not exist');
                        } else {
                          return Column(
                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                '${snapshot.data!.data()!["work"]}',
                                style: txtstyle111,
                              ),
                              Text("${snapshot.data!.data()!["name"]}"),
                              Text(
                                  "ج م ${snapshot.data!.data()!["price"]} للمعاينة "),
                              customtxtrate(this.data!)
                            ],
                          );
                        }
                      },
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: background,
                          borderRadius: BorderRadius.circular(8)),
                      width: 120,
                      height: 120,
                      child: Image.asset(
                        'assets/images/11.png',
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class customtxtrate extends StatelessWidget {
  String data = "";
  customtxtrate(
    this.data, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection("handman")
                .doc(data)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return Text("Erorr");
              }
              if (!snapshot.hasData || snapshot.data!.exists == false) {
                return Text("No user");
              }
              List ranks = snapshot.data!["ranks"];

              return Text("${ranks.length}");
            },
          ),
          const SizedBox(
            width: 5,
          ),
          const Text('|'),
          const SizedBox(
            width: 5,
          ),
          Row(
            children: [
              StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("handman")
                    .doc(data)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  if (snapshot.hasError) {
                    return Text("Erorr");
                  }
                  if (!snapshot.hasData || snapshot.data!.exists == false) {
                    return Text("No user");
                  }
                  List ranks = snapshot.data!["ranks"];
                  if (ranks.length == 0)
                    return Text('0');
                  else {
                    num moy = 0;
                    ranks.forEach((element) {
                      moy = moy + element["value"];
                    });
                    moy = moy / ranks.length;
                    return Text("${moy}");
                  }
                },
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.star,
                    color: krate,
                  )),
            ],
          )
        ],
      ),
    );
  }
}
