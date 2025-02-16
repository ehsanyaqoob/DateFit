import 'package:Dofit/utils/exports.dart';

class SimplifyLoader extends StatelessWidget {

  const SimplifyLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xffD8AF69)),
        ),
      ),
    );
  }
}