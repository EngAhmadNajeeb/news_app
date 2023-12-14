import 'package:dio/dio.dart';
import 'package:news_app/core/constants/constants.dart';
import 'package:news_app/features/daily_news/data/models/response_moel.dart';
import 'package:retrofit/retrofit.dart';
part 'articles_api_service.g.dart';

@RestApi(baseUrl: kBaseUrl)
abstract class ArticleApiService {
  factory ArticleApiService(Dio dio) = _ArticleApiService;

  @GET('{section}.json')
  Future<ResponseModel> getNewsArticles(
    @Path('section') String section,
    @Query('api-key') String key,
  );
}
