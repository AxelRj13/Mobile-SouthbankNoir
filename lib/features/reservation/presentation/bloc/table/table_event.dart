abstract class TableEvent {
  const TableEvent();
}

class TabChange extends TableEvent {
  final int tabIndex;

  TabChange({required this.tabIndex});
}

class GetTables extends TableEvent {
  final String date;

  const GetTables({required this.date});
}
