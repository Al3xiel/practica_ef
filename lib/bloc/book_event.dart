import 'package:flutter/services.dart';

abstract class BookEvent {}

class FetchBooksEvent extends BookEvent {
  final String? contentFilter;
  FetchBooksEvent([this.contentFilter]);
}
