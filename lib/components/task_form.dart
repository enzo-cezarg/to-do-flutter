import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_firebase/providers/task_provider.dart';

class TaskForm extends StatefulWidget {
  const TaskForm({super.key});

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _dateTimeController = TextEditingController();

  DateTime? _selectedDateTime;

  @override
  void dispose() {
    _descriptionController.dispose();
    _dateTimeController.dispose();
    super.dispose();
  }

  Future<void> _pickDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (date == null || !context.mounted) return;

    final time = await showTimePicker(
      // ignore: use_build_context_synchronously
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time == null || !context.mounted) return;

    final dateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    setState(() {
      _selectedDateTime = dateTime;
      _dateTimeController.text = '${date.day}/${date.month}/${date.year} ${time.format(context)}';
    });
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final added = await context.read<TaskProvider>().addTask(_descriptionController.text, false, _selectedDateTime!);
      final messenger = ScaffoldMessenger.of(context);
      messenger.clearSnackBars();
      added
          ? messenger.showSnackBar(
              SnackBar(
                backgroundColor: Colors.green,
                duration: Duration(seconds: 2),
                content: Text(
                  'Added.',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          : messenger.showSnackBar(
              SnackBar(
                backgroundColor: Theme.of(context).colorScheme.error,
                duration: Duration(seconds: 2),
                content: Text(
                  'Oops! Something went wrong.',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          top: 16,
          right: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 96,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return 'This field is required.';
                  }

                  if (v.trimLeft().length < 3) {
                    return 'Description must be at least 3 characters long.';
                  }

                  return null;
                }),
            TextFormField(
              controller: _dateTimeController,
              decoration: const InputDecoration(labelText: 'Date'),
              readOnly: true,
              onTap: _pickDateTime,
              validator: (v) => v == null || v.isEmpty ? 'This field is required.' : null,
            ),
            Container(
              width: double.infinity,
              height: 45,
              margin: EdgeInsets.only(top: 32),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
                onPressed: _submitForm,
                child: Text('Submit'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
