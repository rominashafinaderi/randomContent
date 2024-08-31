import 'dart:math';
import 'content_getter.dart';
import 'http.dart';

void main(List<String> arguments) async {
  final http = Http();
  final contentFetcher = ContentFetcher(http);

  try {
    final total = await contentFetcher.fetchTotalContentCount();

    if (total != null && total > 0) {
      print('Total count of content is $total');

      final pageCount = (total ~/ 30);
      print('Count of pages is $pageCount');

      var pages = <int>[for (int i = 1; i <= pageCount; i++) i];
      var randomPage = Random().nextInt(pages.length);

      if (pageCount < 15) {
        await _printPageContent(contentFetcher, 1);
      } else {
        await _printFavoriteContents(contentFetcher);
        await _printPageContent(contentFetcher, randomPage);
        pages.removeAt(randomPage);
      }
    } else {
      print('Failed to retrieve total content count.');
      await _printPageContent(contentFetcher, 1);
    }
  } catch (e) {
    print('An error occurred: $e \n');
  }
}

Future<void> _printPageContent(ContentFetcher contentFetcher, int page) async {
  final pageContent = await contentFetcher.fetchPageContent(page);
  print('Content of page $page:');
  for (var content in pageContent) {
    print('Title: ${content.title}');
  }
}

Future<void> _printFavoriteContents(ContentFetcher contentFetcher) async {
  final favoriteContents = await contentFetcher.fetchFavoriteContents();
  print('Favorite contents:');
  for (var content in favoriteContents) {
    print('Title: ${content.title}');
  }
}
