import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:luisana_proyecto_flutter/main.dart';

void main() {
  testWidgets('Formulario widgets test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that the form fields are present.
    expect(find.text('Nombre Completo'), findsOneWidget);
    expect(find.text('Estado Actual'), findsOneWidget);
    expect(find.text('Género'), findsOneWidget);
    expect(find.text('Activar Notificaciones'), findsOneWidget);
    expect(find.text('Precio Estimado'), findsOneWidget);
    expect(find.text('Fecha de Nacimiento'), findsOneWidget);
    expect(find.text('Hora de Preferencia'), findsOneWidget);
  });
}
