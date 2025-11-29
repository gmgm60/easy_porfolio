 import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
 import 'package:easy_porfolio/core/theme/extension/theme_accessors_extension.dart';
import 'package:easy_porfolio/core/utils/responsive_util.dart';
import 'package:easy_porfolio/core/widgets/custom_text_form_field.dart';
import 'package:easy_porfolio/core/widgets/multi_image_picker_widget.dart';
import 'package:easy_porfolio/core/widgets/fade_scale_animation.dart';
import 'package:easy_porfolio/features/admin_projects/domain/entities/admin_project.dart';
import 'package:easy_porfolio/features/admin_projects/presentation/widgets/image_picker_widget.dart';

/// Form widget for creating/editing a project.
class ProjectFormWidget extends StatefulWidget {
  const ProjectFormWidget({
    super.key,
    this.project,
    required this.onSave,
    required this.onCancel,
  });

  final AdminProject? project;
  final Function(
      AdminProject project,
      Uint8List? imageBytes,
      List<Uint8List> screenshotBytes,
      ) onSave;
  final VoidCallback onCancel;

  @override
  State<ProjectFormWidget> createState() => _ProjectFormWidgetState();
}

class _ProjectFormWidgetState extends State<ProjectFormWidget> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _liveDemoUrlController;
  late final TextEditingController _repositoryUrlController;
  late final TextEditingController _technologiesController;

  String? _imageUrl;
  Uint8List? _imageBytes;
  bool _isFeatured = false;
  List<String> _technologies = [];
  List<PickedImageData> _screenshots = [];
  List<String> _existingScreenshotUrls = [];

  @override
  void initState() {
    super.initState();
    final project = widget.project;

    _titleController = TextEditingController(text: project?.title ?? '');
    _descriptionController = TextEditingController(text: project?.description ?? '');
    _liveDemoUrlController = TextEditingController(text: project?.liveDemoUrl ?? '');
    _repositoryUrlController = TextEditingController(text: project?.repositoryUrl ?? '');
    _technologiesController = TextEditingController(
      text: project?.technologies.join(', ') ?? '',
    );

    _imageUrl = project?.imageUrl;
    _isFeatured = project?.isFeatured ?? false;
    _technologies = List<String>.from(project?.technologies ?? []);
    _existingScreenshotUrls = List<String>.from(project?.screenshots ?? []);

    // Initialize screenshots with existing URLs
    _screenshots = _existingScreenshotUrls
        .map((url) => PickedImageData(url: url))
        .toList();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _liveDemoUrlController.dispose();
    _repositoryUrlController.dispose();
    _technologiesController.dispose();
    super.dispose();
  }

  void _handleSave() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }

    _parseTechnologies();
    final now = DateTime.now();

    final screenshotData = _buildScreenshotData();

    final project = AdminProject(
      id: widget.project?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      imageUrl: _imageUrl ?? '',
      isFeatured: _isFeatured,
      technologies: _technologies,
      liveDemoUrl: _liveDemoUrlController.text.trim().isEmpty
          ? null
          : _liveDemoUrlController.text.trim(),
      repositoryUrl: _repositoryUrlController.text.trim().isEmpty
          ? null
          : _repositoryUrlController.text.trim(),
      screenshots: screenshotData.urls,
      createdAt: widget.project?.createdAt ?? now,
      updatedAt: now,
    );

    widget.onSave(
      project,
      _imageBytes,
      screenshotData.bytes,
    );
  }

  void _parseTechnologies() {
    final text = _technologiesController.text.trim();
    _technologies = text
        .split(',')
        .map((t) => t.trim())
        .where((t) => t.isNotEmpty)
        .toList();
  }

  _ScreenshotData _buildScreenshotData() {
    final screenshotUrls = <String>[];
    final screenshotBytesList = <Uint8List>[];

    // Keep existing URLs that are still present
    for (final url in _existingScreenshotUrls) {
      final stillExists = _screenshots.any((img) => img.url == url);
      if (stillExists) {
        screenshotUrls.add(url);
      }
    }

    // Add new screenshots (data URLs + bytes)
    for (final screenshot in _screenshots) {
      if (screenshot.bytes != null) {
        final dataUrl = 'data:image/jpeg;base64,${base64Encode(screenshot.bytes!)}';
        screenshotUrls.add(dataUrl);
        screenshotBytesList.add(screenshot.bytes!);
      } else if (screenshot.url != null &&
          !_existingScreenshotUrls.contains(screenshot.url)) {
        screenshotUrls.add(screenshot.url!);
      }
    }

    return _ScreenshotData(
      urls: screenshotUrls,
      bytes: screenshotBytesList,
    );
  }

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacingTokens;
    final isMobile = ResponsiveUtil.isMobile(context);

    return FadeScaleAnimation(
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(isMobile ? spacing.md : spacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Main Project Image Picker
              ImagePickerWidget(
                initialImageUrl: _imageUrl,
                onImagePicked: (url, bytes) {
                  setState(() {
                    _imageUrl = url;
                    _imageBytes = bytes;
                  });
                },
              ),
              SizedBox(height: spacing.lg),

              // Title / Description / Technologies
              _ProjectMainFieldsSection(
                titleController: _titleController,
                descriptionController: _descriptionController,
                technologiesController: _technologiesController,
                onTechnologiesChanged: (_) => _parseTechnologies(),
              ),
              SizedBox(height: spacing.md),

              // URLs
              _ProjectUrlsSection(
                isMobile: isMobile,
                liveDemoUrlController: _liveDemoUrlController,
                repositoryUrlController: _repositoryUrlController,
              ),
              SizedBox(height: spacing.md),

              // Screenshots Multi-Image Picker
              MultiImagePickerWidget(
                label: 'Screenshots',
                initialImages: _existingScreenshotUrls,
                onImagesChanged: (images) {
                  setState(() {
                    _screenshots = images;
                  });
                },
                maxImages: 10,
              ),
              SizedBox(height: spacing.md),

              // Featured Checkbox
              _ProjectFeaturedSection(
                value: _isFeatured,
                onChanged: (value) {
                  setState(() {
                    _isFeatured = value ?? false;
                  });
                },
              ),
              SizedBox(height: spacing.lg),

              // Action Buttons
              _ProjectActionsSection(
                isMobile: isMobile,
                onSave: _handleSave,
                onCancel: widget.onCancel,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ScreenshotData {
  const _ScreenshotData({
    required this.urls,
    required this.bytes,
  });

  final List<String> urls;
  final List<Uint8List> bytes;
}

/// Title, description, technologies section.
class _ProjectMainFieldsSection extends StatelessWidget {
  const _ProjectMainFieldsSection({
    required this.titleController,
    required this.descriptionController,
    required this.technologiesController,
    required this.onTechnologiesChanged,
  });

  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController technologiesController;
  final ValueChanged<String> onTechnologiesChanged;

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacingTokens;

    return Column(
      crossAxisAlignment:  .stretch,
      spacing: spacing.sm,
      children: [
        CustomTextFormField(
          controller: titleController,
          labelText: 'Title',
          validationType: ValidationType.name,
          fieldName: 'Title',
          isRequired: true,
          textInputAction: TextInputAction.next,
        ),
         CustomTextFormField(
          controller: descriptionController,
          labelText: 'Description',
          validationType: ValidationType.description,
          fieldName: 'Description',
          isRequired: true,
          maxLines: 4,
          minLines: 3,
          textInputAction: TextInputAction.next,
        ),
         CustomTextFormField(
          controller: technologiesController,
          labelText: 'Technologies',
          hintText: 'Flutter, Dart, Firebase',
          validationType: ValidationType.commaSeparatedList,
          fieldName: 'Technologies',
           onChanged: onTechnologiesChanged,
          textInputAction: TextInputAction.next,
        ),
      ],
    );
  }
}

/// Live Demo URL + Repository URL, responsive for mobile / desktop.
class _ProjectUrlsSection extends StatelessWidget {
  const _ProjectUrlsSection({
    required this.isMobile,
    required this.liveDemoUrlController,
    required this.repositoryUrlController,
  });

  final bool isMobile;
  final TextEditingController liveDemoUrlController;
  final TextEditingController repositoryUrlController;

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacingTokens;

    if (!isMobile) {
      return Row(
        spacing: spacing.sm,
        children: [
          Expanded(
            child: CustomTextFormField(
              controller: liveDemoUrlController,
              labelText: 'Live Demo URL',
              validationType: ValidationType.url,
              fieldName: 'Live Demo URL',
              keyboardType: TextInputType.url,
              textInputAction: TextInputAction.next,
            ),
          ),
           Expanded(
            child: CustomTextFormField(
              controller: repositoryUrlController,
              labelText: 'Repository URL',
              validationType: ValidationType.url,
              fieldName: 'Repository URL',
              keyboardType: TextInputType.url,
              textInputAction: TextInputAction.done,
            ),
          ),
        ],
      );
    }

    return Column(
      children: [
        CustomTextFormField(
          controller: liveDemoUrlController,
          labelText: 'Live Demo URL',
          validationType: ValidationType.url,
          fieldName: 'Live Demo URL',
           keyboardType: TextInputType.url,
          textInputAction: TextInputAction.next,
        ),
        SizedBox(height: spacing.md),
        CustomTextFormField(
          controller: repositoryUrlController,
          labelText: 'Repository URL',
          validationType: ValidationType.url,
          fieldName: 'Repository URL',
           keyboardType: TextInputType.url,
          textInputAction: TextInputAction.done,
        ),
      ],
    );
  }
}

/// Featured checkbox section.
class _ProjectFeaturedSection extends StatelessWidget {
  const _ProjectFeaturedSection({
    required this.value,
    required this.onChanged,
  });

  final bool value;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    final textStyles = context.textStyles;

    return CheckboxListTile(
      title: Text(
        'Featured Project',
        style: textStyles.bodyMediumTextStyle,
      ),
      value: value,
      onChanged: onChanged,
      contentPadding: EdgeInsets.zero,
    );
  }
}

/// Save / Cancel buttons, responsive layout.
class _ProjectActionsSection extends StatelessWidget {
  const _ProjectActionsSection({
    required this.isMobile,
    required this.onSave,
    required this.onCancel,
  });

  final bool isMobile;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacingTokens;

    if (!isMobile) {
      return Row(
        spacing: spacing.sm,
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: onCancel,
               child: const Text('Cancel'),
            ),
          ),
           Expanded(
            child: ElevatedButton(
              onPressed: onSave,
               child: const Text('Save'),
            ),
          ),
        ],
      );
    }

    return Column(
      spacing: spacing.sm,
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onSave,
             child: const Text('Save'),
          ),
        ),
         SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: onCancel,
             child: const Text('Cancel'),
          ),
        ),
      ],
    );
  }
}
