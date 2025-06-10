import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/user/reservation_provider_user.dart';
import 'definition_process.dart';

class BookingTableSection extends StatefulWidget {
  const BookingTableSection({super.key});

  @override
  State<BookingTableSection> createState() => _BookingTableSectionState();
}

class _BookingTableSectionState extends State<BookingTableSection> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<ReservationProviderUser>(
        context,
        listen: false,
      ).fetchLast4CompletedReservations();
    });
  }

  @override
  Widget build(BuildContext context) {
    final reservationProvider = Provider.of<ReservationProviderUser>(context);

    return Card(
      elevation: 10,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 230),

        child: Column(
          children: [
            SizedBox(
              height: 60,
              child: Row(
                children: [
                  TextButton(onPressed: () {}, child: Text("All Booking")),
                ],
              ),
            ),
            Column(
              children: [
                Row(
                  children: [
                    Text("Start time", style: _titleStyle()),
                    SizedBox(width: 35),
                    Text("Services", style: _titleStyle()),
                    SizedBox(width: 25),
                    Text("Client", style: _titleStyle()),
                    SizedBox(width: 40),
                    Text("Employee", style: _titleStyle()),
                  ],
                ),
                SizedBox(height: 4),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.black,
                ),
                SizedBox(height: 10),

                Column(
                  children:
                      reservationProvider.lastFiveReservations.isNotEmpty
                          ? reservationProvider.lastFiveReservations
                              .map(
                                (res) => Column(
                                  children: [
                                    DefinitionProcess(
                                      startTime: res.date.toString(),
                                      services: res.serviceTitle,
                                      clientName: res.userName,
                                      employeeName: res.barberName,
                                    ),
                                    const SizedBox(height: 12),
                                  ],
                                ),
                              )
                              .toList()
                          : [
                            const Text(
                              "There are no completed reservations",
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 117, 115, 115),
                              ),
                            ),
                          ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  TextStyle _titleStyle() {
    return TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
  }
}
