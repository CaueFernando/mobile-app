import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steptostop_app/main.dart';
import 'package:steptostop_app/providers/pet_provider.dart';
import 'package:steptostop_app/providers/theme_provider.dart';
import 'package:steptostop_app/providers/user_provider.dart';

void main() {
  testWidgets('SteptoStop dashboard renders core actions', (tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => PetProvider()),
          ChangeNotifierProvider(create: (_) => UserProvider()),
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ],
        child: const StepToStopApp(),
      ),
    );

    expect(find.text('Dashboard'), findsWidgets);
    expect(find.text('Dias sem nicotina'), findsOneWidget);
    await tester.drag(find.byType(Scrollable), const Offset(0, -420));
    await tester.pump();
    expect(find.text('+1 Puff'), findsOneWidget);
    expect(find.text('+1 Cigarro'), findsOneWidget);
    expect(find.text('Compartilhar progresso'), findsOneWidget);
  });
}
