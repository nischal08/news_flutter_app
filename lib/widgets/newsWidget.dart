import 'package:flutter/material.dart';

import '../news.dart';

class NewsWidget extends StatelessWidget {
  News news; //News is only data type
  NewsWidget({this.news});

  getImage(String imageURL) {
    if (imageURL != null) {
      return Image.network(imageURL);
    } else {
      return SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          news.title,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            news.author,
            style: TextStyle(color: Colors.grey.shade700),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 14.0),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    news.description,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: getImage(news.urlToImage),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
