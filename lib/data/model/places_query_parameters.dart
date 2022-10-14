class PlacesQueryParameters {
  final int? count;
  final int? offset;
  final String? pageBy;
  final String? pageAfter;
  final String? pagePrior;
  final List<String> sortBy;

  PlacesQueryParameters(
      {this.count,
      this.offset,
      this.pageBy,
      this.pageAfter,
      this.pagePrior,
      required this.sortBy,
      });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'count': count,
      'offset': offset,
      'pageBy': pageBy,
      'pageAfter': pageAfter,
      'pagePrior': pagePrior,
      'sortBy': sortBy,
    };
  }
}
