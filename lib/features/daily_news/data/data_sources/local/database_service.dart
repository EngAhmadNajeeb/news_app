import 'package:fluttertoast/fluttertoast.dart';
import 'package:news_app/core/util/general_function.dart';
import 'package:news_app/features/daily_news/data/models/article.dart';
import 'package:news_app/features/daily_news/data/models/media.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/objectbox.g.dart';

class DatabaseService {
  Store store;
  DatabaseService(this.store);

  List<ArticleModel> getArticles() {
    List<ArticleModel> articles = store.box<ArticleModel>().getAll();
    for (var article in articles) {
      List<MediaModel> articleMedia = store
          .box<MediaModel>()
          .query(MediaModel_.article.equals(article.id))
          .build()
          .find();
      for (var media in articleMedia) {
        article.aMultimedia.add(media.getEntity());
      }
    }
    return articles;
  }

  bool removeLocalArticle(ArticleEntity article) {
    try {
      ArticleModel? model = checkIsArticleInArchive(article.aTitle);
      if (model != null) {
        store.box<ArticleModel>().remove(model.id);
        store
            .box<MediaModel>()
            .query(MediaModel_.article.equals(model.id))
            .build()
            .remove();
        store
            .box<MediaModel>()
            .query(MediaModel_.article.equals(0))
            .build()
            .remove();
        Fluttertoast.showToast(msg: 'Removed Successfully');
        return true;
      }
      Fluttertoast.showToast(msg: 'Article not found');
      return false;
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      return false;
    }
  }

  bool saveLocalArticle(ArticleEntity article) {
    try {
      var articlModel = GenFunc.articleEntityToModel(article);
      for (var media in article.aMultimedia) {
        articlModel.multimedia.add(GenFunc.mediaEntityToModel(media));
      }
      store.box<ArticleModel>().put(articlModel, mode: PutMode.insert);
      Fluttertoast.showToast(msg: 'Added to Archive Successfully');
      return true;
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      return false;
    }
  }

  ArticleModel? checkIsArticleInArchive(String title) {
    return store
        .box<ArticleModel>()
        .query(ArticleModel_.title.equals(title))
        .build()
        .findFirst();
  }
}
