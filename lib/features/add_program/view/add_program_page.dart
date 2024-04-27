import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gym_helper/app/common/helpers.dart';
import 'package:gym_helper/app/common/ui/theme_manager/theme_manager.dart';

import '../../../app/common/ui/widgets/app_bar_manager.dart';
import '../../../app/common/ui/widgets/basic_button.dart';
import '../../../app/common/ui/widgets/field_manager.dart';
import '../../../app/common/ui/widgets/loading_overlay.dart';
import '../../../app/settings/service_locator.dart';
import '../../../domain/workout_repo/models/workout_model.dart';
import '../bloc/add_program_bloc.dart';

final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
const String programFieldName = 'program_field_name';
const String programFieldDescription = 'program_field_description';

@RoutePage()
class AddProgramPage extends StatefulWidget {
  const AddProgramPage({
    Key? key,
    this.workoutModel,
  }) : super(key: key);

  final WorkoutModel? workoutModel;

  @override
  State<AddProgramPage> createState() => _AddProgramPageState();
}

class _AddProgramPageState extends State<AddProgramPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddProgramBloc>(
      create: (BuildContext context) => ServiceLocator.addProgramBloc,
      child: Scaffold(
        body: BlocBuilder<AddProgramBloc, AddProgramState>(
          builder: (BuildContext context, AddProgramState state) {
            return LoadingOverlay(
              isLoading: state.isLoading,
              child: CustomScrollView(
                shrinkWrap: true,
                slivers: <Widget>[
                  AppBarManager.getSliverAppBar(context),
                  state.when(
                    createWorkout: (bool isLoading) =>
                        const SliverFormBuilder(),
                    openWorkout: (bool isLoading, WorkoutModel workoutModel) {
                      return SliverList(
                        delegate: SliverChildListDelegate(
                          <Widget>[
                            Text(
                              workoutModel.name,
                              style: context.customTextStyles.label,
                            ),
                            Text(workoutModel.description ?? ''),
                          ],
                        ),
                      );
                    },
                    initial: (bool isLoading) {
                      context.read<AddProgramBloc>().add(
                            AddProgramEvent.initialization(
                              workoutModel: widget.workoutModel,
                            ),
                          );

                      return const SliverFillRemaining();
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

//class Program

class SliverFormBuilder extends StatelessWidget {
  const SliverFormBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Spacer(flex: 5),
          FormBuilder(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 24,
              ),
              child: Column(
                children: <Widget>[
                  FieldManager(
                    context: context,
                    fieldName: programFieldName,
                    labeltext: context.l10n.workoutName,
                    isRequired: true,
                  ).buildField(),
                  const SizedBox(height: 16),
                  FieldManager(
                    context: context,
                    fieldName: programFieldDescription,
                    labeltext: context.l10n.workoutDescription,
                  ).buildField(),
                ],
              ),
            ),
          ),
          const Spacer(flex: 1),
          const CreateProgramButton(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class CreateProgramButton extends StatelessWidget {
  const CreateProgramButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasicButton(
      text: context.l10n.createWorkout,
      elevation: 0,
      onTap: () {
        final FormBuilderState? forBuilderState = _formKey.currentState;
        if (forBuilderState != null && forBuilderState.saveAndValidate()) {
          final String name = forBuilderState.value[programFieldName] as String;
          final String desription =
              forBuilderState.value[programFieldDescription] as String;
          context.read<AddProgramBloc>().add(
                AddProgramEvent.addWorkout(
                  name: name,
                  description: desription,
                ),
              );
        }
      },
    );
  }
}
