// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

class _$PostApiService extends PostApiService {
  _$PostApiService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  final definitionType = PostApiService;

  Future<Response> getMoviesList(
      [String apiKey,
      String hostName,
      String queryName]) {
    final $url = '/title/auto-complete';
    final $headers = {
      'x-rapidapi-key': apiKey,
      'x-rapidapi-host': hostName
    };
    final Map<String, dynamic> $params = {
      'q': queryName
    };
    final $request = Request('GET', $url, client.baseUrl, parameters: $params, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> postPost(Map<String, dynamic> body) {
    final $url = '';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }
}
