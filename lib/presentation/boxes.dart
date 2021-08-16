import 'package:hive/hive.dart';
import '../data/tables/movie_table.dart';

class Boxes {
  static Box<MovieTable> getTransactions() =>
      Hive.box<MovieTable>('movieBox');
}
