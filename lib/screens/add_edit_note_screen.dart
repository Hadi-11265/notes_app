import 'package:flutter/material.dart';
import '../services/firestore_service.dart';

class AddEditNoteScreen extends StatefulWidget {
  final String? noteId;
  final String? existingTitle;
  final String? existingDescription;

  const AddEditNoteScreen({
    super.key,
    this.noteId,
    this.existingTitle,
    this.existingDescription,
  });

  @override
  State<AddEditNoteScreen> createState() => _AddEditNoteScreenState();
}

class _AddEditNoteScreenState extends State<AddEditNoteScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _firestoreService = FirestoreService();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.existingTitle != null) {
      _titleController.text = widget.existingTitle!;
    }
    if (widget.existingDescription != null) {
      _descriptionController.text = widget.existingDescription!;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  bool get _isEditing => widget.noteId != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? '✏️ Edit Note' : '➕ Add new note'),
        elevation: 0,
      ),
      body: _isLoading 
          ? const Center(child: CircularProgressIndicator()) 
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        labelText: '📌 Title',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.title),
                      ),
                      validator: (value) => (value == null || value.trim().isEmpty) ? 'টাইটেল লিখো' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        labelText: '📝 Description',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.description),
                      ),
                      maxLines: 6,
                      validator: (value) => (value == null || value.trim().isEmpty) ? 'বিবরণ লিখো' : null,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _isLoading ? null : _saveNote,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text(
                        _isEditing ? '💾 Note Update' : '💾 Save',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Future<void> _saveNote() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final title = _titleController.text.trim();
      final description = _descriptionController.text.trim();

    
      if (_isEditing) {
        await _firestoreService.updateNote(widget.noteId!, title, description).timeout(
          const Duration(seconds: 2),
          onTimeout: () => debugPrint("Update timed out but proceed"),
        );
      } else {
        await _firestoreService.addNote(title, description).timeout(
          const Duration(seconds: 2),
          onTimeout: () => debugPrint("Add timed out but proceed"),
        );
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ Note Processing'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 1),
          ),
        );
        Navigator.pop(context, true); 
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('❌ Error: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }
}
