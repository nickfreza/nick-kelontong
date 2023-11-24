import 'package:brik_test/app/app.dart';
import 'package:brik_test/bootstrap.dart';

void main() {
  bootstrap(
    builder: () => const App(),
    env: '.env',
  );
}
