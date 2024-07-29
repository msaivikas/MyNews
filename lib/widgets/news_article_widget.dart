import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tapfirst/utils/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsArticleWidget extends StatelessWidget {
  final String sourceName;
  final String content;
  final DateTime publishedAt;
  final String? urlToImage;
  final String url;

  const NewsArticleWidget({
    super.key,
    required this.sourceName,
    required this.content,
    required this.publishedAt,
    this.urlToImage,
    required this.url,
  });

  Future<void> _launchUrl() async {
    final Uri urlSource = Uri.parse(url);
    if (await launchUrl(urlSource, mode: LaunchMode.externalApplication)) {
      // url launches in the if condition itself; don't launch the same url second time here
    } else {
      throw 'Could could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('dd MMM, yyyy HH:mm').format(publishedAt);
    return GestureDetector(
      onTap: () {
        _launchUrl();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.whiteColor,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 28.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sourceName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      content,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      formattedDate,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16.0),
              Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: urlToImage != null && urlToImage!.isNotEmpty
                        ? NetworkImage(urlToImage!)
                        : const AssetImage('assets/default_image.png')
                            as ImageProvider,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




// import 'package:flutter/material.dart';

// class NewsArticleWidget extends StatelessWidget {
//   final String author;
//   final String title;
//   final String content;

//   const NewsArticleWidget({
//     super.key,
//     required this.author,
//     required this.title,
//     required this.content,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text(title),
//         Text('- $author'),
//         Text(content),
//       ],
//     );
//   }
// }
