import 'package:flutter/material.dart';
import 'package:news/detailed_new.dart';
import 'logger.dart';

class NewsCard extends StatelessWidget {
  final String title;
  final String author;
  final String imageUrl;
  final String description;
  final String content;
  final String url;

  const NewsCard(
      {required this.title,
      required this.author,
      required this.imageUrl,
      required this.description,
      required this.content,
      required this.url,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(14),
        padding: const EdgeInsets.all(14),
        constraints: const BoxConstraints(maxHeight: 350),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor,
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      height: 175,
                      errorBuilder: (context, error, trace) {
                        return const SizedBox(
                            height: 175,
                            child: Center(child: Text('No Image')));
                      },
                    )),
              ),
              Flexible(
                fit: FlexFit.loose,
                child: Text(description,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: Theme.of(context).textTheme.titleMedium),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 5),
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                  child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'More details',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                  ),
                                  Expanded(
                                      child: Container(
                                    margin: const EdgeInsets.only(right: 35),
                                    child: SizedBox(
                                      width: 30,
                                      height: 30,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          shape: const CircleBorder(),
                                          padding: const EdgeInsets.all(0),
                                        ),
                                        child: Image.asset(
                                          'assets/pig_walk.png',
                                          height: 20,
                                          width: 20,
                                          fit: BoxFit.fitWidth,
                                        ),
                                        onPressed: () {
                                          logger.info(
                                              'open window with new $title');
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return DetailedNew(
                                                title: title,
                                                imageUrl: imageUrl,
                                                content: content,
                                                url: url,
                                                author: author);
                                          }));
                                        },
                                      ),
                                    ),
                                  )),
                                ],
                              )),
                              Expanded(
                                child: Text(
                                  author,
                                  style: Theme.of(context).textTheme.titleSmall,
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ))
            ]));
  }
}
