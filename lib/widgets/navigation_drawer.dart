import 'package:flutter/material.dart';
import '../models/auth.dart';
import '../pages/home.dart';

class MenuDrawer extends StatelessWidget {
  MenuDrawer({super.key, required this.setPageNumber, required this.update});

  Function setPageNumber;
  Function update;

  @override
  Widget build(BuildContext context) => Drawer(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            buildMenuItems(context),
            buildFooter(context),
          ],
        ),
      ));

  Widget buildFooter(BuildContext context) => Padding(
      padding: const EdgeInsets.all(15),
      child: Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            "Автор: Давыдов Д.В. ИКБО-24-20",
            style: TextStyle(
                fontSize: 12,
                color: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.color
                    ?.withAlpha(100)),
          )));

  Widget buildMenuItems(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 48.0),
        child: Wrap(
          runSpacing: 5,
          children: [
            ListTile(
              leading: const Icon(Icons.priority_high),
              title: const Text("Новости"),
              onTap: () => setPageNumber(PageType.news),
            ),
            ListTile(
              leading: const Icon(Icons.search_rounded),
              title: const Text("Поиск"),
              onTap: () => setPageNumber(PageType.search),
            ),
            ListTile(
              leading: const Icon(Icons.bookmark),
              title: const Text("Закладки"),
              onTap: () => setPageNumber(PageType.bookmarks),
            ),
            ListTile(
              leading: const Icon(Icons.error),
              title: const Text("Частые ошибки"),
              onTap: () => setPageNumber(PageType.info),
            ),
            ListTile(
              leading: const Icon(Icons.download),
              title: const Text("Загрузки"),
              onTap: () => setPageNumber(PageType.downloads),
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text("Помощь"),
              onTap: () => setPageNumber(PageType.help),
            ),
            ListTile(
              leading: const Icon(Icons.arrow_back),
              title: const Text("Выйти из аккаунта"),
              onTap: () async {
                await deleteUserId();
                update();
              },
            )
          ],
        ),
      );
}
