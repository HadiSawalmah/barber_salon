import 'package:flutter/material.dart';

import 'definition_process.dart';

class BookingTableSection extends StatelessWidget {
  const BookingTableSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: SizedBox(
        height: 250,
        child: Column(
          children: [
            SizedBox(
              height: 70,
              child: Row(
                children: [
                  TextButton(onPressed: () {}, child: Text("Upcoming Booking")),
                  TextButton(onPressed: () {}, child: Text("All")),
                  TextButton(onPressed: () {}, child: Text("canceled")),
                ],
              ),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Start time", style: _titleStyle()),
                    Text("Book Services", style: _titleStyle()),
                    Text("Client", style: _titleStyle()),
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
                  children: [
                    DefinitionProcess(),
                    SizedBox(height: 12),
                    DefinitionProcess(),
                    SizedBox(height: 12),
                    DefinitionProcess(),
                    SizedBox(height: 12),
                    DefinitionProcess(),
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
