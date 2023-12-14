import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/presentation/app_confirm_dialog.dart';
import 'package:news_app/core/presentation/app_network_image.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/presentation/pages/article_details.dart';

class ListItemCard extends StatelessWidget {
  const ListItemCard({super.key, required this.model, this.onDelete});
  final ArticleEntity model;
  final Function()? onDelete;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 3.w),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.horizontal(
            start: Radius.circular(10.r),
          ),
          border: Border.all(color: Theme.of(context).colorScheme.outline),
        ),
        height: MediaQuery.of(context).size.width / 3,
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ArticleDetails(model: model),
                  ),
                ),
                child: Row(
                  children: [
                    AppNetworkImage(
                      url: model.smallImgUrl().mUrl,
                      borderRadius: BorderRadiusDirectional.horizontal(
                          start: Radius.circular(10.r)),
                      width: MediaQuery.of(context).size.width / 3,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(5.r),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              model.aTitle,
                              style: TextStyle(
                                fontSize: 15.sp,
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
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => AppConfirmDialog(
                      title: 'Remove article',
                      description:
                          'Are you sure you want to remove this article from the archive?',
                      postiveText: 'Yes',
                      negativeText: 'No',
                      onCancel: () => Navigator.pop(context),
                      onAccept: () {
                        Navigator.pop(context);
                        onDelete!();
                      },
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.all(10.r),
                  child: const SizedBox(
                    height: double.infinity,
                    child: Icon(
                      Icons.remove_circle_outline_rounded,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
