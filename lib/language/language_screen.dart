import 'package:demo/auth/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
import 'language_controller.dart';

class LanguageScreen extends ConsumerWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String? selected = ref.watch(languageControllerProvider);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 24),
              Center(
                child: Text(
                  'Choose Your Language',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  border: Border.all(color: const Color(0xFFE6E6E6)),
                ),
                child: ListView.builder(
                  padding: EdgeInsets.only(top: 15, bottom: 15),
                  shrinkWrap: true,
                  itemCount: kLanguages.length,
                  itemBuilder: (BuildContext context, int index) {
                    final AppLanguage lang = kLanguages[index];
                    return Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: RadioListTile<String>(
                        value: lang.code,
                        groupValue: selected ?? 'en',
                        onChanged: (String? v) {
                          if (v != null) {
                            ref
                                .read(languageControllerProvider.notifier)
                                .select(v);
                          }
                        },
                        title: Text(
                          lang.name,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(lang.sub),
                        controlAffinity: ListTileControlAffinity.trailing,
                        visualDensity: VisualDensity(vertical: -1),
                        activeColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF2563EB),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.all(
                        Radius.circular(15),
                      ),
                    ),
                  ),

                  onPressed: () async {
                    final String code = selected ?? 'en';
                    await ref
                        .read(languageControllerProvider.notifier)
                        .select(code);
                    await ref
                        .read(languageControllerProvider.notifier)
                        .persist();
                    if (context.mounted) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterScreen(),
                        ),
                      );
                    }
                    ;
                  },
                  child: const Text(
                    'Select',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xFFF6F7FB),
    );
  }
}
