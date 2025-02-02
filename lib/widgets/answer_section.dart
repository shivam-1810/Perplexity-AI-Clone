import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:perplexity_clone/services/chat_web_service.dart';
import 'package:perplexity_clone/theme/colors.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AnswerSection extends StatefulWidget {
  const AnswerSection({super.key});

  @override
  State<AnswerSection> createState() => _AnswerSectionState();
}

class _AnswerSectionState extends State<AnswerSection> {
  bool isLoading = true;
  String fullResponse = '''
As of now, the match between India and Australia has concluded. In the **5th Test** held at the Sydney Cricket Ground from January 3 to January 5, 2025, Australia won by **6 wickets**. 

### Match Summary:
- **Australia's Innings**:
  - 1st Innings: 181 all out
  - 2nd Innings: 162/4 (chased down the target)
  
- **India's Innings**:
  - 1st Innings: 185 all out
  - 2nd Innings: 157 all out

Travis Head scored an unbeaten 34 runs, and Beau Webster contributed with 39 runs in the second innings as Australia chased down the target of 162 runs successfully[1][5][6]. With this victory, Australia clinched the series **3-1** against India[1].

Citations:
[1] https://sports.ndtv.com/australia-vs-india-2024-25/india-vs-australia-live-score-5th-test-match-day-3-ind-vs-aus-live-scorecard-updates-jasprit-bumrah-sam-konstas-7399591
[2] https://indianexpress.com/article/sports/cricket/ind-vs-aus-4th-test-day-3-live-score-india-vs-australia-live-cricket-scorecard-updates-melbourne-cricket-ground-victoria-9747836/
[3] https://timesofindia.indiatimes.com/sports/cricket/india-vs-australia-5th-test-day-2-live-score-updates-border-gavaskar-trophy-2024-25-ind-vs-aus-live-streaming-online/liveblog/116926639.cms
[4] https://sports.ndtv.com/cricket/ind-vs-aus-scorecard-live-cricket-score-australia-in-india-4-test-series-2017-2nd-test-inau03042017182437
[5] https://www.business-standard.com/cricket/news/india-vs-australia-live-cricket-score-5th-test-streaming-full-scorecard-ind-vs-aus-day-3-highlights-125010400473_1.html
[6] https://www.cricbuzz.com/live-cricket-scores/91814/aus-vs-ind-5th-test-india-tour-of-australia-2024-25
[7] https://www.cricbuzz.com/live-cricket-scores/91778/aus-vs-ind-1st-test-india-tour-of-australia-2024-25
[8] https://www.espncricinfo.com/series/australia-vs-india-2024-25-1426547/australia-vs-india-5th-test-1426559/full-scorecard
''';

  @override
  void initState() {
    super.initState();
    ChatWebService().contentStream.listen((data) {
      if (isLoading) {
        fullResponse = '';
      }
      setState(() {
        fullResponse += data['data'];
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Perplexity',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Skeletonizer(
          containersColor: AppColors.cardColor,
          enabled: isLoading,
          child: Markdown(
            data: fullResponse,
            shrinkWrap: true,
            styleSheet:
                MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
              codeblockDecoration: BoxDecoration(
                color: AppColors.cardColor,
                borderRadius: BorderRadius.circular(10),
              ),
              code: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
