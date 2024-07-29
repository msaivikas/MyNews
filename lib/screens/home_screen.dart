import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapfirst/providers/auth_provider.dart' as user_auth_provider;
import 'package:tapfirst/providers/news_provider.dart';
import 'package:tapfirst/services/firebase_remote_config_service.dart';
import 'package:tapfirst/utils/app_colors.dart';
import 'package:tapfirst/widgets/news_article_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _initializeAndFetchNews();
  }

  Future<void> _initializeAndFetchNews() async {
    final newsProvider = Provider.of<NewsProvider>(context, listen: false);
    final remoteConfigService = FirebaseRemoteConfigService();

    await remoteConfigService.initialize();
    final countryCode = remoteConfigService.countryCodeTest;
    final apiKey = remoteConfigService.newsApiKey;

    newsProvider.storeNews(countryCode, apiKey);
  }

  Future<void> _signOut(BuildContext context) async {
    final authProvider =
        Provider.of<user_auth_provider.AuthProvider>(context, listen: false);

    try {
      await FirebaseAuth.instance.signOut();
      authProvider.setIsSignedOut();
    } catch (e) {
      debugPrint('Error signing out: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: const Text(
          'My News',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: AppColors.whiteColor),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            color: AppColors.whiteColor,
            onPressed: () => _signOut(context),
          ),
        ],
      ),
      body: Consumer<NewsProvider>(
        builder: (context, newsProvider, child) {
          if (newsProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (newsProvider.articles.isEmpty) {
            return const Center(child: Text('No news articles available.'));
          } else {
            return Container(
              color: AppColors.backgroundColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Top Headlines',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.all(20.0),
                      itemCount: newsProvider.articles.length,
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 10,
                        );
                      },
                      itemBuilder: (context, index) {
                        final article = newsProvider.articles[index];
                        return NewsArticleWidget(
                          sourceName: article.source.name,
                          content: article.content,
                          publishedAt: article.publishedAt,
                          urlToImage: article.urlToImage,
                          url: article.url,
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
