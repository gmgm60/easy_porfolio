import 'dart:convert';
import 'package:easy_porfolio/core/services/image_services/src/core/models/picked_image.dart';
import 'package:easy_porfolio/core/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_porfolio/core/theme/extension/theme_accessors_extension.dart';
import 'package:easy_porfolio/core/utils/responsive_util.dart';
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
  Uint8List? _imageBytes;
  List<PickedImage> _screenshots = [];

  void _loadProjectData(AdminProject? project) {
    setState(() {
      _formData = ProjectFormModel(
        title: project?.title ?? '',
        description: project?.description ?? '',
        liveDemoUrl: project?.liveDemoUrl ?? '',
        repositoryUrl: project?.repositoryUrl ?? '',
        technologies: project?.technologies.join(', ') ?? '',
        isFeatured: project?.isFeatured ?? false,
      );
    });

    // Load existing image from base64
    Uint8List? imageBytes;
    if (project?.imageUrl.isNotEmpty ?? false) {
      try {
        String base64String = project!.imageUrl;
        // Handle data URL format
        if (base64String.startsWith('data:image')) {
          final commaIndex = base64String.indexOf(',');
          if (commaIndex != -1) {
            base64String = base64String.substring(commaIndex + 1);
          }
        }
        imageBytes = base64Decode(base64String);
      } catch (_) {
        imageBytes = null;
      }
    }

    // Load existing screenshots from base64
    final screenshots = <PickedImage>[];
    if (project?.screenshots.isNotEmpty ?? false) {
      for (final base64 in project!.screenshots) {
        try {
          String base64String = base64;
          // Handle data URL format
          if (base64String.startsWith('data:image')) {
            final commaIndex = base64String.indexOf(',');
            if (commaIndex != -1) {
              base64String = base64String.substring(commaIndex + 1);
            }
          }
          final bytes = base64Decode(base64String);
          // Store with both bytes and path for preservation
          screenshots.add(
            PickedImage(
              name: 'screenshot_${screenshots.length}.jpg',
              path: base64, // Keep original for preservation
              bytes: bytes,
            ),
          );
        } catch (_) {
          // Skip invalid base64
        }
      }
    }

    setState(() {
      _imageBytes = imageBytes;
      _screenshots = screenshots;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadProjectData(widget.project);
  }

  @override
  void didUpdateWidget(ProjectFormWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Always reload data when project changes
    if (oldWidget.project?.id != widget.project?.id) {
      _loadProjectData(widget.project);
    }
  }

  void _handleSave() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }

    final technologies = _parseTechnologies();
    final now = DateTime.now();

    // Preserve existing image if no new image was picked
    String imageBase64;
    if (_imageBytes != null) {
      // New image was picked, encode it
      imageBase64 = base64Encode(_imageBytes!);
    } else if (widget.project?.imageUrl.isNotEmpty ?? false) {
      // Keep existing image (might be base64 or data URL)
      String existing = widget.project!.imageUrl;
      if (existing.startsWith('data:image')) {
        // Extract base64 from data URL
        final commaIndex = existing.indexOf(',');
        imageBase64 = commaIndex != -1
            ? existing.substring(commaIndex + 1)
            : existing;
      } else {
        imageBase64 = existing;
      }
    } else {
      imageBase64 = '';
    }

    // Encode screenshots to base64 (preserve existing if no new bytes)
    final screenshotBase64List = <String>[];
    for (final screenshot in _screenshots) {
      if (screenshot.bytes != null) {
        // New screenshot with bytes
        screenshotBase64List.add(base64Encode(screenshot.bytes!));
      } else if (screenshot.path != null) {
        // Existing screenshot (from path/base64)
        String base64String = screenshot.path!;
        if (base64String.startsWith('data:image')) {
          final commaIndex = base64String.indexOf(',');
          base64String = commaIndex != -1
              ? base64String.substring(commaIndex + 1)
              : base64String;
        }
        screenshotBase64List.add(base64String);
      }
    }

    final screenshotBytesList = _screenshots
        .where((img) => img.bytes != null)
        .map((img) => img.bytes!)
        .toList();

    final project = AdminProject(
      id:
          widget.project?.id ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      title: _formData.title.trim(),
      description: _formData.description.trim(),
      imageUrl: imageBase64,
      isFeatured: _formData.isFeatured,
      technologies: technologies,
      liveDemoUrl: _formData.liveDemoUrl.trim().isEmpty
          ? null
          : _formData.liveDemoUrl.trim(),
      repositoryUrl: _formData.repositoryUrl.trim().isEmpty
          ? null
          : _formData.repositoryUrl.trim(),
      screenshots: screenshotBase64List,
      createdAt: widget.project?.createdAt ?? now,
      updatedAt: now,
    );

    widget.onSave(project, _imageBytes, screenshotBytesList);
  }

  List<String> _parseTechnologies() {
    final text = _formData.technologies.trim();
    return text
        .split(',')
        .map((t) => t.trim())
        .where((t) => t.isNotEmpty)
        .toList();
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
                initialImageUrl: _imageBytes != null
                    ? base64Encode(_imageBytes!)
                    : null,
                onImagePicked: (PickedImage image) {
                  setState(() {
                    _imageBytes = image.bytes;
                  });
                },
              ),
              SizedBox(height: spacing.lg),

              // Title / Description / Technologies
              _ProjectMainFieldsSection(
                formData: _formData,
                onChanged: (updated) {
                  setState(() {
                    _formData = updated;
                  });
                },
              ),
              SizedBox(height: spacing.md),

              // URLs
              _ProjectUrlsSection(
                isMobile: isMobile,
                formData: _formData,
                onChanged: (updated) {
                  setState(() {
                    _formData = updated;
                  });
                },
              ),
              SizedBox(height: spacing.md),

              // Screenshots Multi-Image Picker
              MultiImagePickerWidget(
                label: 'Screenshots',
                initialImages: _screenshots
                    .where((img) => img.bytes != null)
                    .map((img) => base64Encode(img.bytes!))
                    .toList(),
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
                  setState(() {
                    _formData = _formData.copyWith(isFeatured: value ?? false);
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
        AppTextField(
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
        AppTextField(
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
        AppTextField(
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
            child: AppTextField(
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
            child: AppTextField(
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
        AppTextField(
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
        AppTextField(
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
