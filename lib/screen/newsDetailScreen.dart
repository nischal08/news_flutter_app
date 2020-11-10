import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:news_app/news.dart';
import 'package:news_app/widgets/newsWidget.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailScreen extends StatelessWidget {
  News news;
  NewsDetailScreen({this.news});
  NewsWidget newsWidget;

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  getImage(String imageURL) {
    if (imageURL != null) {
      return Image.network(imageURL);
    } else {
      return SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News in details"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 14.0),
        child: ListView(
          children: [
            Text(
              news.title,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 12.0),
              child: Text(
                news.author,
                style: TextStyle(color: Colors.grey.shade700),
              ),
            ),
            getImage(news.urlToImage),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                news.content,
              ),
            ),
            RaisedButton(
              onPressed: () {
                _launchURL(news.url);
                log(news.url);
              },
              color: Colors.green,
              child: Text(
                "Read Full News",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
