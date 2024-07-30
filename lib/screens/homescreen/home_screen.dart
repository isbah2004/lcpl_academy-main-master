import 'package:flutter/material.dart';
import 'package:lcpl_academy/provider/home_index_provider.dart';
import 'package:lcpl_academy/theme/theme.dart';
import 'package:lcpl_academy/utils/constants.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
  
    final homeIndexProvider = Provider.of<HomeIndexProvider>(context);
    return Scaffold(
      backgroundColor: AppTheme.whiteColor,
      appBar: AppBar(
        title: const Text('Tab Navigation Example'),
      ),
      body: Center(
        child:
            Constants.widgetOptions.elementAt(homeIndexProvider.selectedIndex),
      ),
      bottomNavigationBar: Consumer<HomeIndexProvider>(
        builder:
            (BuildContext context, HomeIndexProvider value, Widget? child) {
          return BottomNavigationBar(
            elevation: 0,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.document_scanner),
                label: Constants.documents,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.audiotrack),
                label: Constants.audios,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.format_quote_outlined),
                label: Constants.quotes,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.video_collection),
                label: Constants.videos,
              ),
            ],
            currentIndex: value.selectedIndex,
            onTap: (index) {
              value.setIndex(index);
            },
          );
        },
      ),
      
    );
  }
}
