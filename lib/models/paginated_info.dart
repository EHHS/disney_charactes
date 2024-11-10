import 'dart:convert';

class PaginationInfo {
  final int totalPages;
  final int count;
  final String? previousPage;
  final String? nextPage;

  PaginationInfo({
    required this.totalPages,
    required this.count,
    this.previousPage,
    this.nextPage,
  });

  factory PaginationInfo.fromJson(Map<String, dynamic> json) {
    return PaginationInfo(
      totalPages: json['totalPages'],
      count: json['count'],
      previousPage: json['previousPage'],
      nextPage: json['nextPage'],
    );
  }
}

