// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:naroureader/models/novel.dart';
import 'package:naroureader/models/savedList_modell.dart';
import '../database/savedList_helper.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.novel});

  final Novel novel;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final DatabaseHelper dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.detailTitle),
        elevation: 1,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await dbHelper.insertItem(
            Item(
              title: widget.novel.title,
              ncode: widget.novel.ncode,
              story: widget.novel.story,
            ),
          );

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.saveSuccess)),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SelectableText(
              widget.novel.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            SelectableText(
              l10n.authorLabel(widget.novel.writer),
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            SelectableText(
              l10n.urlLabel(widget.novel.ncode),
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            SelectableText(
              l10n.ncodeLabel(widget.novel.ncode),
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            const Divider(),
            SelectableText(
              widget.novel.story,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
