//A simple URL shortener

import 'dart:math';
import 'dart:io';

void main() {
  print('URL shortening Program');
  print("Enter the long URL you wish you shorten");
  var userUrl = stdin.readLineSync();
  Url url = Url(userUrl);
  print('Your shortened URL is ${url.shorten()}');
  print("Press 1 to view an original URL from a shortened version. or press Enter to exit");
  var userShortenedUrl = stdin.readLineSync().toString();
  if(userShortenedUrl == ''){
    exit(0);
  }
  print(url.getUrl(userShortenedUrl));
}

class Url {
  var url;
  Map <String, String> dictionaries = {}; 
  var domainName = 'blinkify';
  Url(url) {
    this.url = url;
  }

  String shorten() {
    if(this.url.startsWith('https://')|| this.url.startsWith('http://')){
      this.url = url;
    }else{
      this.url = 'https://'+url;
    }
    Random random = Random();
    String randomCharacters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ123456789abcdefghijklmnopqrstuvwxyz';
    final result = List.generate(5,(index) => randomCharacters[random.nextInt(randomCharacters.length)]).join();
    var shortenedUrl = 'https://${this.domainName}/'+result;
    dictionaries[shortenedUrl] = url;
    return shortenedUrl;
  }
  String getUrl(String shortenedUrl) {
    var originalUrl;
    for (var entry in this.dictionaries.entries) {
      if (shortenedUrl == entry.key) {
          originalUrl = entry.value;
          break;
      }
    }
    if (originalUrl == null) {
      return 'Url not found';
    }
    return originalUrl;
}

}
