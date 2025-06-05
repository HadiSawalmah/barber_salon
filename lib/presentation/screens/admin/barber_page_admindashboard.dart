import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../data/firebase/getbarber_firestor.dart';
import '../../../data/models/barber/barber_model.dart';
import '../../widgets/admin/card_barber_admin.dart';
import '../../widgets/admin/drawer_admin.dart';
import '../../widgets/admin/icon_circle_admin.dart';

void main() {
  runApp(BarberPageAdmindashboard());
}

class BarberPageAdmindashboard extends StatefulWidget {
  const BarberPageAdmindashboard({super.key});

  @override
  State<BarberPageAdmindashboard> createState() =>
      _BarberPageAdmindashboardState();
}

class _BarberPageAdmindashboardState extends State<BarberPageAdmindashboard> {
  final BarberService _barberService = BarberService();
  List<BarberModel> barbers = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchBarbers();
  }

  Future<void> fetchBarbers() async {
    try {
      List<BarberModel> fetchedBarbers = await _barberService.getBarbers();
      setState(() {
        barbers = fetchedBarbers;
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching barbers: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Barbers"), backgroundColor: Colors.grey[300]),
      drawer: DrawerAdmin(),

      body:
          isLoading
              ? Center(child: CircularProgressIndicator())
              : Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(height: 4),
                  IconCircleAdmin(
                    icon: Icon(Icons.add_circle_outline_outlined, size: 52),
                    onpress: () {
                      context.push("/AddBarber").then((value) {
                        if (value == true) {
                          fetchBarbers();
                        }
                      });
                    },
                  ),
                  SizedBox(height: 12),
                  Expanded(
                    child: ListView.builder(
                      itemCount: barbers.length,
                      itemBuilder: (context, index) {
                        return CardBarber(
                          barber: barbers[index],
                          onDeleted: fetchBarbers,
                        );
                      },
                    ),
                  ),
                ],
              ),
    );
  }
}
