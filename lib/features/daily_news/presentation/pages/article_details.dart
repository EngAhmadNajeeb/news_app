import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/presentation/app_network_image.dart';
import 'package:news_app/core/presentation/image_view.dart';
import 'package:news_app/core/util/date_helper.dart';
import 'package:news_app/core/util/general_function.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';

class ArticleDetails extends ConsumerStatefulWidget {
  final ArticleEntity model;
  const ArticleDetails({required this.model, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ArticleDetailsState();
}

class _ArticleDetailsState extends ConsumerState<ArticleDetails> {
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text(widget.model.aTitle)),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ImageView(
                  heroTag: widget.model.largImgUrl().mUrl,
                  imagePath: widget.model.largImgUrl().mUrl,
                ),
              )),
              child: Hero(
                tag: widget.model.largImgUrl().mUrl,
                child: AppNetworkImage(
                  url: widget.model.largImgUrl().mUrl,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 3,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.model.aByline,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Published on ${DateHelper.dateToUiString(widget.model.aPublishedDate)}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                      Text(
                        'Updated at ${DateHelper.dateToUiString(widget.model.aUpdatedAt)}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  SizedBox(height: 15.h),
                  Text(
                    'Title',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  Text(
                    widget.model.aTitle,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      // color: Colors.blue,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    'Abstract',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  Text(
                    widget.model.aAbstract,
                    style: TextStyle(fontSize: 20.sp),
                  ),
                  InkWell(
                    onTap: () => GenFunc.launchUrl1(widget.model.aUrl),
                    child: const Text(
                      'See more',
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
   
        },
        child: Icon(
          Icons.bookmark,
          size: 40.r,
        ),
      ),
    );
  }
}
