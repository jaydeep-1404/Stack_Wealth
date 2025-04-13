
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../data/Models/news_model.dart';

class NewsDetail extends StatelessWidget {
  final NewsDataModel item;
  const NewsDetail({super.key, required this.item});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 45,
        leading: backButton(onPressed: () => Get.back(),),
        backgroundColor: Colors.red,
        title: title(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Hero(
              tag: item.title ?? '',
              child: ClipRRect(
                child: Image.network(
                  item.urlToImage ?? '',
                  height: 220,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Image.network('https://static.thenounproject.com/png/504708-200.png'),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(item.title ?? '', style: GoogleFonts.newsreader(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(item.sourceName ?? '', style: GoogleFonts.newsreader(color: Colors.red,fontWeight: FontWeight.bold)),
                const Spacer(),
                Text(
                  item.publishedAt != null ? DateFormat.yMMMd().format(DateTime.parse(item.publishedAt!)) : '',
                  style: GoogleFonts.newsreader(fontSize: 12,fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(item.description ?? '', style: GoogleFonts.newsreader(fontSize: 15)),
            const SizedBox(height: 12),
            Text(item.content ?? '', style: GoogleFonts.newsreader(fontSize: 15)),
          ],
        ),
      ),
    );
  }

  Widget backButton({required void Function() onPressed}) => IconButton(
    icon: const Icon(
      Icons.arrow_back_ios_new,
      color: Colors.white,
      size: 20,
    ),
    onPressed: onPressed,
  );

  Widget title() => const Text('Slack News',
    style: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,
      color: Colors.white,
    ),
  );
  // Widget title() => ;

}

