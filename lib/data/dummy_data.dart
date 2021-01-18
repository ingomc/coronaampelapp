import '../models/countys.dart';

// ignore: non_constant_identifier_names
Countys DUMMY_CITYS = Countys(
  locations: [
    Location(
        bez: 'Bezirk',
        cases7Per100K: 23.4,
        gen: 'Coburg',
        newCases: 43,
        rs: '323'),
    Location(
        bez: 'Kreis',
        cases7Per100K: 123.4,
        gen: 'Kronach',
        newCases: 243,
        rs: '3123'),
    Location(
        bez: 'Landkreis',
        cases7Per100K: 55.4,
        gen: 'Bamberg',
        newCases: 24,
        rs: '31233'),
  ],
  date: 'Date',
);
