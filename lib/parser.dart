import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';

class Parser{
  Future main() async {
    var client = http.Client();

    // RSS feed
    var response = await client
        .get('http://www.france24.com/fr/actualites/rss');
    //http://www.france24.com/fr/actualites/rss
    //https://mcfsp-uac.bj/fr/feed'
    //http://search.yahoo.com/mrss
    var channel = RssFeed.parse(response.body);
    return channel;
  }
}