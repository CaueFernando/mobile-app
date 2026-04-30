import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:steptostop_app/main.dart';
import 'package:steptostop_app/providers/pet_provider.dart';
import 'package:steptostop_app/providers/theme_provider.dart';
import 'package:steptostop_app/providers/user_provider.dart';

void main() {
  testWidgets('onboarding completes all four steps and opens dashboard',
      (tester) async {
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

    expect(find.text('Escolha seu idioma'), findsOneWidget);
    await _tapVisibleText(tester, 'Continuar');
    await tester.pumpAndSettle();

    expect(find.text('Bem-vindo!'), findsOneWidget);
    expect(find.text('Como voc\u00ea quer chamar seu pet?'), findsOneWidget);
    await _tapVisibleText(tester, 'Continuar');
    await tester.pumpAndSettle();

    expect(find.text('O que voc\u00ea usa?'), findsOneWidget);
    await tester.tap(find.text('Ambos'));
    await tester.pump();
    await _tapVisibleText(tester, 'Continuar');
    await tester.pumpAndSettle();

    expect(find.text('Quanto voc\u00ea gasta?'), findsOneWidget);
    expect(find.text('VAPE'), findsOneWidget);
    expect(find.text('CIGARRO'), findsOneWidget);
    await _tapVisibleText(tester, 'Come\u00e7ar jornada');
    await tester.pumpAndSettle();

    expect(find.text('Dashboard'), findsWidgets);
    expect(find.text('Dias sem nicotina'), findsOneWidget);
    await tester.drag(find.byType(Scrollable), const Offset(0, -420));
    await tester.pump();
    expect(find.text('+1 Puff'), findsOneWidget);
    expect(find.text('+1 Cigarro'), findsOneWidget);
  });
}

Future<void> _tapVisibleText(WidgetTester tester, String text) async {
  final finder = find.text(text).last;
  await tester.ensureVisible(finder);
  await tester.pump();
  await tester.tap(finder);
}
