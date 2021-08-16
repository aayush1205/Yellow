import '../data/tables/movie_table.dart';
import 'package:flutter/material.dart';

class CreateMovieDialog extends StatefulWidget {
  final MovieTable? movieTable;
  final Function(int id, String title, String posterPath) onClickedDone;

  const CreateMovieDialog({
    Key? key,
    this.movieTable,
    required this.onClickedDone,
  }) : super(key: key);

  @override
  _CreateMovieDialogState createState() => _CreateMovieDialogState();
}

class _CreateMovieDialogState extends State<CreateMovieDialog> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final posterPathController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.movieTable != null) {
      final movieTable = widget.movieTable;
      titleController.text = movieTable!.title;
      posterPathController.text = movieTable.posterPath;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    posterPathController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.movieTable != null;
    final ftitle = isEditing ? 'Edit Movie' : 'Add Movie';

    return AlertDialog(
      title: Text(ftitle),
      content: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 8),
              buildName(),
              SizedBox(height: 8),
              buildPosterPath(),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        buildCancelButton(context),
        buildAddButton(context, isEditing: isEditing),
      ],
    );
  }

  Widget buildName() => TextFormField(
        controller: titleController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter Movie Title',
        ),
        validator: (name) =>
            name != null && name.isEmpty ? 'Enter a Title' : null,
      );

  Widget buildPosterPath() => TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter Poster Path',
        ),
        // validator: (path) => path != null ? 'Enter a valid path' : null,
        controller: posterPathController,
      );

  Widget buildCancelButton(BuildContext context) => TextButton(
        child: Text('Cancel'),
        onPressed: () => Navigator.of(context).pop(),
      );

  Widget buildAddButton(BuildContext context, {required bool isEditing}) {
    final text = isEditing ? 'Save' : 'Add';

    return TextButton(
      child: Text(text),
      onPressed: () async {
        final isValid = formKey.currentState!.validate();

        if (isValid) {
          final title = titleController.text;
          final posterPath = posterPathController.text;

          widget.onClickedDone(1, title, posterPath);

          Navigator.of(context).pop();
        }
      },
    );
  }
}
