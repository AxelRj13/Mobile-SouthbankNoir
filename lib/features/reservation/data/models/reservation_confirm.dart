import '../../domain/entities/reservation_confirm.dart';
import '../../domain/entities/table_detail.dart';

class ReservationConfirmModel extends ReservationConfirmEntity {
  const ReservationConfirmModel({
    int? storeId,
    String? storeName,
    String? storeImage,
    String? date,
    String? dateDisplay,
    String? event,
    String? personName,
    String? personPhone,
    List<TableDetailEntity>? table,
  }) : super(
          storeId: storeId,
          storeName: storeName,
          storeImage: storeImage,
          date: date,
          dateDisplay: dateDisplay,
          event: event,
          personName: personName,
          personPhone: personPhone,
          table: table,
        );
}
