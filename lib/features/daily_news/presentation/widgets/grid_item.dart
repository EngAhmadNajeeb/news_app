import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/presentation/app_network_image.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/presentation/pages/article_details.dart';

class GridItemWidget extends StatelessWidget {
  const GridItemWidget({super.key, required this.model, this.onDelete});
  final ArticleEntity model;
  final Function()? onDelete;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 3.w),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.vertical(
            top: Radius.circular(10.r),
          ),
          border: Border.all(color: Theme.of(context).colorScheme.outline),
        ),
        child: Column(
          children: [
            Expanded(
              child: InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ArticleDetails(model: model),
                  ),
                ),
                child: Column(
                  children: [
                    AppNetworkImage(
                      url: model.smallImgUrl().mUrl,
                      borderRadius: BorderRadiusDirectional.vertical(
                          top: Radius.circular(10.r)),
                      height: MediaQuery.of(context).size.width / 3,
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(5.r),
                        child: Column(
                          children: [
                            Text(
                              model.aTitle,
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                model.aAbstract,
                                maxLines: 5,
                                overflow: TextOverflow.fade,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: onDelete != null,
              child: InkWell(
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.all(10.r),
                  child: const SizedBox(
                    width: double.infinity,
                    child: Icon(
                      Icons.remove_circle_outline_rounded,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
