import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'main.dart';
import 'logger.dart';
import 'package:provider/provider.dart';

void _launchURL(url) async {
  final Uri url0 = Uri.parse('$url');
  if (!await launchUrl(url0)) {
    throw Exception('Could not launch $url0');
  }
}

class DetailedNew extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String content;
  final String url;
  final String author;

  const DetailedNew(
      {required this.title,
      required this.imageUrl,
      required this.content,
      required this.url,
      required this.author,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child: Container(
              margin: const EdgeInsets.all(14),
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          flex: 1,
                          child: ElevatedButton(
                            onPressed: () {
                              logger.info('go to the web with new $title');
                              _launchURL(url);
                            },
                            child: const Text('Go To Website'),
                          )),
                      Expanded(
                        flex: 1,
                        child: Text(
                          author,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.titleSmall,
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          errorBuilder: (context, error, trace) {
                            return const SizedBox(
                                height: 175,
                                child: Center(child: Text('No Image')));
                          },
                        )),
                  ),
                  Text(content, style: Theme.of(context).textTheme.titleMedium),
                ],
              )),
        ));
  }
}
