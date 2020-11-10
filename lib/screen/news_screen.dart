import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/news.dart';
import 'package:news_app/screen/newsDetailScreen.dart';
import 'package:news_app/widgets/newsWidget.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<News> newsData = new List();
  bool isLoading = true;

  getNewsData() async {
    try {
      var url =
          'http://newsapi.org/v2/everything?q=bitcoin&from=2020-10-10&sortBy=publishedAt&apiKey=e8ac89412f24429fbf8eff84afa682a5';
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        // log(jsonResponse['articles'].toString());
        jsonResponse['articles'].forEach((v) => newsData.add(News.fromJson(v)));
        isLoading = false;
        setState(() {});
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      log(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNewsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Latest News from all Around Globe'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 14.0),
              child: ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: newsData.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 14.0, top: 10.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return NewsDetailScreen(
                            news: newsData[index],
                          );
                        }));
                      },
                      child: NewsWidget(
                        news: newsData[index],
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(
                  color: Colors.grey,
                ),
              ),
            ),
    );
  }
}
