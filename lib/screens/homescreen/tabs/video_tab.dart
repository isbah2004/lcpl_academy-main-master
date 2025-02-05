import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lcpl_academy/theme/theme.dart';
import 'package:lcpl_academy/utils/utils.dart';

class VideoTab extends StatefulWidget {
  const VideoTab({super.key});

  @override
  State<VideoTab> createState() => _VideoTabState();
}

class _VideoTabState extends State<VideoTab> {
  final fireStore = FirebaseFirestore.instance.collection('video').snapshots();

  CollectionReference urlRef = FirebaseFirestore.instance.collection('video');

  @override
  Widget build(BuildContext context) {
  
    return Column(
      children: [
        StreamBuilder<QuerySnapshot>(
          stream: fireStore,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 2.6),
                child: Center(
                    child: Text(
                  'No data available',
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(fontWeight: FontWeight.normal),
                )),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 2.6),
                child: const Center(child: CircularProgressIndicator()),
              );
            } else if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
              return Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 2.6),
                child: Center(
                  child: Text(
                    'No data available',
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge!
                        .copyWith(fontWeight: FontWeight.normal),
                  ),
                ),
              );
            }

            return Expanded(
              child: ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Utils.urlLauncher(data['url']);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppTheme.greyColor),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              data['title'],
                              style: const TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          },
        ),
      ],
    );
  }
}
