import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../data/models/barber/barber_model.dart';

class DefinitionBarberHomepage extends StatelessWidget {
  final BarberModel barber;

  const DefinitionBarberHomepage({super.key, required this.barber});
  Future<void> _launchFacebook(String url) async {
    final Uri uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffC77218),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            barber.barberImage != null && barber.barberImage!.startsWith('http')
                ? Image.network(
                  barber.barberImage!,
                  height: 70,
                  width: 70,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset("assets/images/image 4.png", height: 70);
                  },
                )
                : Image.asset("assets/images/image 4.png", height: 70),
            Text(
              barber.name,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              barber.phone,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: () {
                if (barber.barberFacebook.isNotEmpty) {
                  _launchFacebook(barber.barberFacebook);
                }
              },
              child: Icon(
                Icons.facebook,
                size: 40,
                color: const Color.fromARGB(255, 5, 90, 160),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
