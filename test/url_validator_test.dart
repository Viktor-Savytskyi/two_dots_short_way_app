import 'package:flutter_test/flutter_test.dart';
import 'package:two_dots_short_way_app/utils/url_validator.dart';

void main() {
  test('accepts https url', () {
    expect(isValidUrl('https://someurl.com'), isTrue);
  });

  test('rejects url without scheme', () {
    expect(isValidUrl('someurl.com'), isFalse);
  });

  test('rejects empty host', () {
    expect(isValidUrl('https://'), isFalse);
  });

  test('rejects http url', () {
    expect(isValidUrl('http://someurl.com'), isFalse);
  });

}