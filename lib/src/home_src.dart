import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stackwelth/data/Api/get_news.dart';
import 'detail_src.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(NewsController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        leading: title(),
        leadingWidth: 130,
        actions: [
          setting(onPressed: () {},),
        ],
      ),
      body: Column(
        children: [
          searchField(onChanged: ctrl.onSearchChanged,),
          Divider(indent: 7,endIndent: 7,),
          Expanded(
            child: Obx(() {
              if (ctrl.loading.value && ctrl.items.isEmpty) {
                return const Center(child: SizedBox(width: 30, height: 30, child: CircularProgressIndicator(color: Colors.red)));
              }
              if (ctrl.isEmpty.value) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network("https://cdni.iconscout.com/illustration/premium/thumb/no-data-available-4085811-3385480.png", height: 150),
                      const SizedBox(height: 10),
                      Text("No news found", style: GoogleFonts.newsreader(fontSize: 16)),
                    ],
                  ),
                );
              }
              return GridView.builder(
                controller: ctrl.scrollCtrl,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 270,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                padding: const EdgeInsets.all(10),
                itemCount: ctrl.items.length,
                itemBuilder: (_, i) {
                  final item = ctrl.items[i];
                  return GestureDetector(
                    onTap: () => Get.to(() => NewsDetail(item: item), transition: Transition.fadeIn),
                    child: Hero(
                      tag: item.title ?? '$i',
                      child: Card(
                        elevation: 0.1,
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                child: Image.network(item.urlToImage ?? '', fit: BoxFit.cover, width: double.infinity,
                                  errorBuilder: (_, __, ___) => Image.network(
                                      'https://static.thenounproject.com/png/504708-200.png',
                                      fit: BoxFit.contain),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(6),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.title ?? '',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.newsreader(fontWeight: FontWeight.bold, fontSize: 16),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    item.description ?? '',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.newsreader(fontSize: 13, color: Colors.black87),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    item.sourceName ?? '',
                                    style: GoogleFonts.newsreader(color: Colors.red, fontSize: 11,fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget title() => Padding(
    padding: EdgeInsets.only(left: 16),
    child: Center(
      child: Text(
        'Slack News',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Colors.white,
        ),
      ),
    ),
  );

  Widget setting({required void Function() onPressed}) => IconButton(
    icon: const Icon(Icons.settings),
    onPressed: onPressed,
    color: Colors.white,
  );

  Widget searchField({void Function(String)? onChanged}) => Padding(
    padding: EdgeInsets.only(top: 5,left: 7,right: 7,),
    child: SizedBox(
      height: 40,
      child: TextFormField(
        onChanged: onChanged,
        style: GoogleFonts.newsreader(fontSize: 16,fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          hintText: 'Search...',
          hintStyle: GoogleFonts.newsreader(fontSize: 16,fontWeight: FontWeight.bold),
          contentPadding: EdgeInsets.only(top: 5,left: 10),
          suffixIcon: const Icon(Icons.search),
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    ),
  );

}