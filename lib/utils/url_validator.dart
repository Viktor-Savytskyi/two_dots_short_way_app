bool isValidUrl(String input) {
  final uri = Uri.tryParse(input.trim());
  if (uri == null) return false;
  return  uri.scheme == 'https' && uri.host.isNotEmpty;
}
