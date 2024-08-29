import 'dart:math';
import 'content_getter.dart';
import 'http.dart';

void main(List<String> arguments) async {
  final http = Http();
  final contentGetter = ContentGetter(http);

  final total = await contentGetter.getTotalContentCount();
  print('Total count of content is $total');

  final pageCount = (total ~/ 30);
  print('Count of pages is $pageCount');

  var pages = <int>[for (int i = 1; i <= pageCount; i++) i];
  var randomPage = Random().nextInt(pages.length);

  if (pageCount < 15) {

    final pageContent = await contentGetter.getPageContent(1);
    print('Content of page one is : \n $pageContent');

  } else {

    final favoriteContents = await contentGetter.getFavoriteContents();
    for (var content in favoriteContents) {
      print('Title: ${content.title}');
    }

    final pageContent = await contentGetter.getPageContent(randomPage);
    print('Content of page $randomPage ');

    for (var content in pageContent) {
      print('Title: ${content.title}');
    }
    pages.removeAt(randomPage);
  }
}
