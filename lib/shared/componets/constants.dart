import '../Network/local/cache_helper.dart';
import 'componets.dart';

void printFullText(String text)
{
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String token ='';