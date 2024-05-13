import 'package:EnergyControl/pages/bookmarks.dart';
import 'package:EnergyControl/pages/help.dart';
import 'package:EnergyControl/pages/info.dart';
import 'package:EnergyControl/pages/news.dart';
import 'package:EnergyControl/pages/search.dart';
import 'package:EnergyControl/widgets/navigation_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum PageType { news, search, bookmarks, help, info }

class HomePage extends StatefulWidget {
  HomePage({super.key, required this.update});

  Function update;
  PageType currentPage = PageType.news;
  Map<PageType, Widget> pages = {
    PageType.news: const NewsPage(),
    PageType.search: const SearchPage(),
    PageType.bookmarks: BookmarksPage(),
    PageType.info: const InfoPage(),
    PageType.help: const HelpPage(),
  };

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void setPageNumber(PageType currentPage) {
    widget.currentPage = currentPage;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.account_balance_outlined),
            Padding(
              padding: EdgeInsets.only(right: 24),
              child: Text("ЭнергоКонтроль"),
            )
          ],
        ),
      ),
      body: widget.pages[widget.currentPage],
      drawer: MenuDrawer(
        setPageNumber: setPageNumber,
        update: widget.update,
      ),
    );
  }
}
