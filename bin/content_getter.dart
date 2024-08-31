import 'content_model.dart';
import 'http.dart';
import 'response_extention.dart';

class ContentFetcher {
  final Http http;

  ContentFetcher(this.http);

  Future<int> fetchTotalContentCount() async {
    final response = await http.get('/v1/content/contentApi/getCountContents/');
    if (response.isSuccess()) {
      return response.countData;
    } else {
      throw Exception('Failed to fetch content count');
    }
  }

  Future<List<Content>> fetchFavoriteContents() async {
    final Map<String, String> queryParams = {
      'isChosenGeneral': 'true',
      'count': '6',
    };

    final response = await http.get('/v1/content/contentApi/getContents/',
        queryParams: queryParams);
    if (response.isSuccess()) {
      var data = response.data;
      return (data['contents'] as List)
          .map((contentJson) => Content.fromJson(contentJson))
          .toList();
    } else {
      throw Exception('Failed to fetch favorite contents');
    }
  }

  Future<List<Content>> fetchPageContent(int page) async {
    final Map<String, String> queryParams = {
      'page': page.toString(),
      'count': '30',
    };

    final response = await http.get('/v1/content/contentApi/getContents/',
        queryParams: queryParams);
    if (response.isSuccess()) {
      var data = response.data;
      return (data['contents'] as List)
          .map((contentJson) => Content.fromJson(contentJson))
          .toList();
    } else {
      throw Exception('Failed to fetch page content');
    }
  }
}
