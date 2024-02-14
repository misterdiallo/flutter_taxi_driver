class APIResponse<T> {
  final dynamic data;
  final bool error;
  final String? errorMessage;
  APIResponse({this.data, this.error = false, this.errorMessage});
}
