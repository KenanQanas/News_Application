import 'package:flutter/material.dart';

Widget MyDivider() {
  return const Divider(
    color: Colors.grey,
    thickness: 2.0,
    indent: 50.0,
    endIndent: 50.0,
  );
}

Widget BuildArticle(dynamic article, context) {
  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              //'${article['urlToImage']}'
              image: NetworkImage(
                '${article['urlToImage']}',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      Expanded(
        child: SizedBox(
          height: 120.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  '${article['title']}',
                  style: Theme.of(context).primaryTextTheme.bodyText1,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                '${article['publishedAt']}',
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

void navigateTo({required BuildContext context, required Widget screen}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => screen,
    ),
  );
}
