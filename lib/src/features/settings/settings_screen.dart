import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/backup_service.dart';
import '../../providers/providers.dart';
import '../onboarding/onboarding_screen.dart';

/// Data management: export, import and delete-all.
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          _sectionHeader(context, 'Your data'),
          ListTile(
            leading: const Icon(Icons.ios_share),
            title: const Text('Export data'),
            subtitle: const Text('Save a JSON backup of all your data.'),
            onTap: () => _export(context, ref),
          ),
          ListTile(
            leading: const Icon(Icons.file_download_outlined),
            title: const Text('Import data'),
            subtitle: const Text('Restore from a backup. Replaces all data.'),
            onTap: () => _import(context, ref),
          ),
          ListTile(
            leading: Icon(Icons.delete_forever_outlined,
                color: Theme.of(context).colorScheme.error),
            title: Text('Delete all data',
                style: TextStyle(color: Theme.of(context).colorScheme.error)),
            onTap: () => _deleteAll(context, ref),
          ),
          const Divider(),
          _sectionHeader(context, 'About'),
          ListTile(
            leading: const Icon(Icons.list_alt),
            title: const Text('Add common symptoms'),
            subtitle: const Text('Pick from the suggested list again.'),
            onTap: () => openOnboarding(context),
          ),
          const ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('Eir Symptom Tracker'),
            subtitle: Text('Version 1.3.0'),
          ),
        ],
      ),
    );
  }

  Widget _sectionHeader(BuildContext context, String text) => Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
        child: Text(text,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                )),
      );

  Future<void> _export(BuildContext context, WidgetRef ref) async {
    final messenger = ScaffoldMessenger.of(context);
    final service = ref.read(backupServiceProvider);
    try {
      final bytes = Uint8List.fromList(await service.exportToBytes());
      final path = await FilePicker.saveFile(
        dialogTitle: 'Save Eir backup',
        fileName: service.suggestedFileName,
        type: FileType.custom,
        allowedExtensions: const ['json'],
        bytes: bytes,
      );
      if (path == null) return; // cancelled
      messenger.showSnackBar(const SnackBar(content: Text('Backup saved')));
    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text('Export failed: $e')));
    }
  }

  Future<void> _import(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Import backup?'),
        content: const Text(
            'Importing will replace ALL current data with the contents of the '
            'backup file. This can\'t be undone.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel')),
          FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Choose file')),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;

    final messenger = ScaffoldMessenger.of(context);
    final service = ref.read(backupServiceProvider);
    try {
      final result = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: const ['json'],
        withData: true,
      );
      final bytes = result?.files.singleOrNull?.bytes;
      if (bytes == null) return; // cancelled
      final count = await service.importFromBytes(bytes);
      messenger.showSnackBar(
          SnackBar(content: Text('Imported $count entries')));
    } on ImportException catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(e.message)));
    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text('Import failed: $e')));
    }
  }

  Future<void> _deleteAll(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete all data?'),
        content: const Text(
            'Every symptom type and entry will be permanently removed.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel')),
          FilledButton(
            style: FilledButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.error),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete everything'),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;

    final messenger = ScaffoldMessenger.of(context);
    await ref.read(symptomRepositoryProvider).deleteAll();
    messenger.showSnackBar(const SnackBar(content: Text('All data deleted')));
  }
}
