import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_porfolio/core/theme/extension/theme_accessors_extension.dart';
import 'package:easy_porfolio/core/utils/responsive_util.dart';
import 'package:easy_porfolio/core/widgets/custom_text_form_field.dart';
import 'package:easy_porfolio/core/widgets/multi_image_picker_widget.dart';
import 'package:easy_porfolio/core/widgets/fade_scale_animation.dart';
import 'package:easy_porfolio/features/admin_projects/data/models/project_form_model.dart';
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
  )
  onSave;
  final VoidCallback onCancel;

  @override
  State<ProjectFormWidget> createState() => _ProjectFormWidgetState();
}

class _ProjectFormWidgetState extends State<ProjectFormWidget> {
  final _formKey = GlobalKey<FormState>();

  late ProjectFormModel _formData;
  String? _imageUrl;
  Uint8List? _imageBytes;
  List<PickedImageData> _screenshots = [];
  List<String> _existingScreenshotUrls = [];

  @override
  void initState() {
    super.initState();
    final project = widget.project;

    _formData = ProjectFormModel(
      title: project?.title ?? '',
      description: project?.description ?? '',
      liveDemoUrl: project?.liveDemoUrl ?? '',
      repositoryUrl: project?.repositoryUrl ?? '',
      technologies: project?.technologies.join(', ') ?? '',
      isFeatured: project?.isFeatured ?? false,
    );

    _imageUrl = project?.imageUrl;
    _existingScreenshotUrls = List<String>.from(project?.screenshots ?? []);

    // Initialize screenshots with existing URLs
    _screenshots = _existingScreenshotUrls
        .map((url) => PickedImageData(url: url))
        .toList();
  }

  void _handleSave() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }

    final technologies = _parseTechnologies();
    final now = DateTime.now();

    final screenshotData = _buildScreenshotData();

    final project = AdminProject(
      id:
          widget.project?.id ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      title: _formData.title.trim(),
      description: _formData.description.trim(),
      imageUrl: _imageUrl ?? '',
      isFeatured: _formData.isFeatured,
      technologies: technologies,
      liveDemoUrl: _formData.liveDemoUrl.trim().isEmpty
          ? null
          : _formData.liveDemoUrl.trim(),
      repositoryUrl: _formData.repositoryUrl.trim().isEmpty
          ? null
          : _formData.repositoryUrl.trim(),
      screenshots: screenshotData.urls,
      createdAt: widget.project?.createdAt ?? now,
      updatedAt: now,
    );

    widget.onSave(project, _imageBytes, screenshotData.bytes);
  }

  List<String> _parseTechnologies() {
    final text = _formData.technologies.trim();
    return text
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
        final dataUrl =
            'data:image/jpeg;base64,${base64Encode(screenshot.bytes!)}';
        screenshotUrls.add(dataUrl);
        screenshotBytesList.add(screenshot.bytes!);
      } else if (screenshot.url != null &&
          !_existingScreenshotUrls.contains(screenshot.url)) {
        screenshotUrls.add(screenshot.url!);
      }
    }

    return _ScreenshotData(urls: screenshotUrls, bytes: screenshotBytesList);
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
                formData: _formData,
                onChanged: (updated) {
                  _formData = updated;
                 },
              ),
              SizedBox(height: spacing.md),

              // URLs
              _ProjectUrlsSection(
                isMobile: isMobile,
                formData: _formData,
                onChanged: (updated) {
                  _formData = updated;

                },
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
                value: _formData.isFeatured,
                onChanged: (value) {
                  _formData = _formData.copyWith(isFeatured: value ?? false);

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
  const _ScreenshotData({required this.urls, required this.bytes});

  final List<String> urls;
  final List<Uint8List> bytes;
}

/// Title, description, technologies section.
class _ProjectMainFieldsSection extends StatelessWidget {
  const _ProjectMainFieldsSection({
    required this.formData,
    required this.onChanged,
  });

  final ProjectFormModel formData;
  final ValueChanged<ProjectFormModel> onChanged;

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacingTokens;

    return Column(
      crossAxisAlignment: .stretch,
      spacing: spacing.sm,
      children: [
        CustomTextFormField(
          value: formData.title,
          labelText: 'Title',
          validationType: ValidationType.name,
          fieldName: 'Title',
          isRequired: true,
          textInputAction: TextInputAction.next,
          onChanged: (value) {
            onChanged(formData.copyWith(title: value));
          },
        ),
        CustomTextFormField(
          value: formData.description,
          labelText: 'Description',
          validationType: ValidationType.description,
          fieldName: 'Description',
          isRequired: true,
          maxLines: 4,
          minLines: 3,
          textInputAction: TextInputAction.next,
          onChanged: (value) {
            onChanged(formData.copyWith(description: value));
          },
        ),
        CustomTextFormField(
          value: formData.technologies,
          labelText: 'Technologies',
          hintText: 'Flutter, Dart, Firebase',
          validationType: ValidationType.commaSeparatedList,
          fieldName: 'Technologies',
          onChanged: (value) {
            onChanged(formData.copyWith(technologies: value));
          },
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
    required this.formData,
    required this.onChanged,
  });

  final bool isMobile;
  final ProjectFormModel formData;
  final ValueChanged<ProjectFormModel> onChanged;

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacingTokens;

    if (!isMobile) {
      return Row(
        spacing: spacing.sm,
        children: [
          Expanded(
            child: CustomTextFormField(
              value: formData.liveDemoUrl,
              labelText: 'Live Demo URL',
              validationType: ValidationType.url,
              fieldName: 'Live Demo URL',
              keyboardType: TextInputType.url,
              textInputAction: TextInputAction.next,
              onChanged: (value) {
                onChanged(formData.copyWith(liveDemoUrl: value));
              },
            ),
          ),
          Expanded(
            child: CustomTextFormField(
              value: formData.repositoryUrl,
              labelText: 'Repository URL',
              validationType: ValidationType.url,
              fieldName: 'Repository URL',
              keyboardType: TextInputType.url,
              textInputAction: TextInputAction.done,
              onChanged: (value) {
                onChanged(formData.copyWith(repositoryUrl: value));
              },
            ),
          ),
        ],
      );
    }

    return Column(
      children: [
        CustomTextFormField(
          value: formData.liveDemoUrl,
          labelText: 'Live Demo URL',
          validationType: ValidationType.url,
          fieldName: 'Live Demo URL',
          keyboardType: TextInputType.url,
          textInputAction: TextInputAction.next,
          onChanged: (value) {
            onChanged(formData.copyWith(liveDemoUrl: value));
          },
        ),
        SizedBox(height: spacing.md),
        CustomTextFormField(
          value: formData.repositoryUrl,
          labelText: 'Repository URL',
          validationType: ValidationType.url,
          fieldName: 'Repository URL',
          keyboardType: TextInputType.url,
          textInputAction: TextInputAction.done,
          onChanged: (value) {
            onChanged(formData.copyWith(repositoryUrl: value));
          },
        ),
      ],
    );
  }
}

/// Featured checkbox section.
class _ProjectFeaturedSection extends StatelessWidget {
  const _ProjectFeaturedSection({required this.value, required this.onChanged});

  final bool value;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    final textStyles = context.textStyles;

    return CheckboxListTile(
      title: Text('Featured Project', style: textStyles.bodyMediumTextStyle),
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
            child: ElevatedButton(onPressed: onSave, child: const Text('Save')),
          ),
        ],
      );
    }

    return Column(
      spacing: spacing.sm,
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(onPressed: onSave, child: const Text('Save')),
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
