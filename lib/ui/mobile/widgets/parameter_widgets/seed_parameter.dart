import 'package:flutter/material.dart';
import 'package:maid/providers/app_data.dart';
import 'package:maid/providers/session.dart';
import 'package:provider/provider.dart';

class SeedParameter extends StatelessWidget {
  const SeedParameter({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller =
        TextEditingController(text: context.read<AppData>().currentSession.model.seed.toString());

    return Consumer<AppData>(
      builder: (context, appData, child) {
        final session = appData.currentSession;
        
        return Column(
          children: [
            SwitchListTile(
              title: const Text('Random Seed'),
              value: session.model.randomSeed,
              onChanged: (value) {
                session.model.randomSeed = value;
                session.notify();
              },
            ),
            Divider(
              height: 20,
              indent: 10,
              endIndent: 10,
              color: Theme.of(context).colorScheme.primary,
            ),
            if (!session.model.randomSeed)
              ListTile(
                title: Row(
                  children: [
                    const Expanded(
                      child: Text('seed'),
                    ),
                    Expanded(
                      flex: 2,
                      child: TextField(
                        controller: controller,
                        decoration: const InputDecoration(
                          labelText: 'seed',
                        ),
                        onChanged: (value) {
                          session.model.seed = int.parse(value);
                          session.notify();
                        },
                      ),
                    ),
                  ],
                ),
              ),
          ],
        );
      }
    );
  }
}
