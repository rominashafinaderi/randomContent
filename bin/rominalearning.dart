import 'dart:math';
import 'content_getter.dart';
import 'http.dart';

void main(List<String> arguments) async {
  final http = Http();
  final contentGetter = ContentGetter(http);

  try {
    final total = await contentGetter.getTotalContentCount();

    if (total != null && total > 0) {
      print('Total count of content is $total');

      final pageCount = (total ~/ 30);
      print('Count of pages is $pageCount');

      var pages = <int>[for (int i = 1; i <= pageCount; i++) i];
      var randomPage = Random().nextInt(pages.length);

      if (pageCount < 15) {
        await _printPageContent(contentGetter, 1);
      } else {
        await _printFavoriteContents(contentGetter);
        await _printPageContent(contentGetter, randomPage);
        pages.removeAt(randomPage);
      }
    } else {
      print('Failed to retrieve total content count.');
    }
  } catch (e) {
    print('An error occurred: $e \n');
    await _printPageContent(contentGetter, 1);
  }
}

Future<void> _printPageContent(ContentGetter contentGetter, int page) async {
  final pageContent = await contentGetter.getPageContent(page);
  print('Content of page $page:');
  for (var content in pageContent) {
    print('Title: ${content.title}');
  }
}

Future<void> _printFavoriteContents(ContentGetter contentGetter) async {
  final favoriteContents = await contentGetter.getFavoriteContents();
  print('Favorite contents:');
  for (var content in favoriteContents) {
    print('Title: ${content.title}');
  }
}
