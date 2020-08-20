import 'package:chopper/chopper.dart';
part 'post_api_service.chopper.dart';

@ChopperApi()
abstract class PostApiService extends ChopperService {
  @Get(path: '/title/auto-complete')                                      //device Authorization
  Future<Response> getMoviesList([
    @Header("x-rapidapi-key") String apiKey,
    @Header("x-rapidapi-host") String hostName,
    @Query("q") String queryName
  ]);

  @Post()
  Future<Response> postPost(
     @Body() Map<String, dynamic> body,
  );

  static PostApiService create() {
    final client = ChopperClient(
      baseUrl: 'https://imdb8.p.rapidapi.com',
      services: [
        _$PostApiService(),
      ],
      converter: JsonConverter(),
    );
    return _$PostApiService(client);
  }
}