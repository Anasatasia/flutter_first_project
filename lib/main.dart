import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'news_card.dart';
import 'dart:convert';
import 'logger.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class CurrentTheme extends ChangeNotifier {
  bool isDark = false;
  void changeTheme() {
    isDark = !isDark;
    notifyListeners();
  }
}

void main() {
  initLogger();
  logger.info('Start main');
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (context) => CurrentTheme())],
    child: const MyHomePage(),
  ));
}

const apiKey = 'f12f5c958cbd40b1bde28a1f68a67fe4';

Future<List<News>> getNews() async {
  Uri uri =
      Uri.parse('https://newsapi.org/v2/everything?q=animals&apiKey=$apiKey');

  final response = await http.get(uri);
  logger.info('get news ${response.statusCode}');

  if (response.statusCode == 201 || response.statusCode == 200) {
    List articles = json.decode(response.body)['articles'];
    List<News> news = articles.map((x) => News.fromJson(x)).toList();
    return news;
  } else {
    return [];
  }
}

class News {
  String title, description, urlToImage, author, content, url;

  News(this.title, this.description, this.urlToImage, this.author, this.content,
      this.url);

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
        json['title'] ?? '',
        json['description'] ?? '',
        json['urlToImage'] ?? 'No Image',
        json['author'] ?? '',
        json['content'] ?? '',
        json['url'] ?? '');
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var news = getNews();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: AppTheme.theme(Provider.of<CurrentTheme>(context).isDark),
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Pig.Press'),
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () {
                    logger.info('change theme');
                    var currentThemeChanger =
                        Provider.of<CurrentTheme>(context, listen: false);
                    currentThemeChanger.changeTheme();
                  },
                  icon: Provider.of<CurrentTheme>(context).isDark
                      ? Image.asset('assets/pig.png')
                      : Image.asset('assets/pig_light.png'),
                )
              ],
            ),
            body: Center(
                child: FutureBuilder(
              future: news,
              builder: (context, news) {
                if (!news.hasData) {
                  logger.info('no news');
                  return const Center(child: Text('sorry, no news yet'));
                } else {
                  logger.info('add list with news');
                  return ListView.builder(
                    itemCount: news.data?.length,
                    itemBuilder: (context, index) => NewsCard(
                      title: news.data!.elementAt(index).title,
                      author: news.data!.elementAt(index).author,
                      imageUrl: news.data!.elementAt(index).urlToImage,
                      description: news.data!.elementAt(index).description,
                      content: news.data!.elementAt(index).content,
                      url: news.data!.elementAt(index).url,
                    ),
                  );
                }
              },
            ))));
  }
}
