class NewsItem {
  final String title;
  final String time;
  final String src;
  final String category;
  final String pic;
  final String content;
  final String url;
  final String weburl;

  NewsItem(this.title, this.time, this.src, this.category, this.pic,
      this.content, this.url, this.weburl);

  NewsItem.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        time = json['time'],
        src = json['src'],
        category = json['category'],
        pic = json['pic'],
        content = json['content'],
        url = json['url'],
        weburl = json['weburl'];
}

