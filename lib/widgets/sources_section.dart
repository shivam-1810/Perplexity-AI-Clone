import 'package:flutter/material.dart';
import 'package:perplexity_clone/services/chat_web_service.dart';
import 'package:perplexity_clone/theme/colors.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher.dart';

class SourcesSection extends StatefulWidget {
  const SourcesSection({super.key});

  @override
  State<SourcesSection> createState() => _SourcesSectionState();
}

class _SourcesSectionState extends State<SourcesSection> {
  bool isLoading = true;
  List _searchResults = [
    {
      'title': 'Ind Vs Aus Live Score 4th Test',
      'url': 'http://google.com/search?q=Ind+Vs+Aus+Live+Score+4th+Test',
    },
    {
      'title': 'Ind Vs Aus Live Score 4th Test',
      'url': 'http://google.com/search?q=Ind+Vs+Aus+Live+Score+4th+Test',
    },
    {
      'title': 'Ind Vs Aus Live Score 4th Test',
      'url': 'http://google.com/search?q=Ind+Vs+Aus+Live+Score+4th+Test',
    },
  ];

  @override
  void initState() {
    super.initState();
    ChatWebService().searchResultStream.listen((data) {
      setState(() {
        _searchResults = data['data'];
        isLoading = false;
      });
    });
  }

  void launchURL(Uri uri) async {
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $uri';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.source_outlined,
              color: Colors.white70,
            ),
            SizedBox(width: 8),
            Text(
              'Sources',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
        SizedBox(height: 16),
        Skeletonizer(
          enabled: isLoading,
          containersColor: AppColors.cardColor,
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            children: _searchResults.map((res) {
              return GestureDetector(
                onTap: () {
                  launchUrl(Uri.parse(res['url']));
                },
                child: Container(
                  width: 150,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.cardColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Text(
                        res['title'],
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        res['url'],
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}
