import 'package:flutter_dotenv/flutter_dotenv.dart';

class DotenvVar {
  static String baseUrl = dotenv.env['BASE_URL']!;
}
