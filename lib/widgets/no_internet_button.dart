import 'package:flutter/material.dart';
import '../pages/home.dart';

class NoInternetButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.warning_sharp,
          size: 40,
        ),
        Container(
          margin: EdgeInsets.only(left: 35, top: 15, bottom: 15, right: 35),
          child: Center(
            child: Text(
              "У Вас нет интернета или возникли проблемы с подключением.",
              style: TextStyle(color: Colors.white, fontSize: 16.0),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            homePageKey.currentState?.setPageNumber(PageType.downloads);
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.deepPurple,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
          ),
          child: Text(
            "Перейти в Загрузки",
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ),
      ],
    );
  }
}
