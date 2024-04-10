import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gym_helper/app/common/helpers.dart';

import 'package:gym_helper/features/add_workout/bloc/add_workout_bloc.dart';

import '../../../app/common/widgets/field_manager.dart';
import '../../../app/settings/service_locator.dart';

final _formKey = GlobalKey<FormBuilderState>();
const String programFieldName = 'program_field_name';
const String programFieldDescription = 'program_field_description';

@RoutePage()
class AddWorkoutPage extends StatefulWidget {
  const AddWorkoutPage({Key? key}) : super(key: key);

  @override
  State<AddWorkoutPage> createState() => _AddWorkoutPageState();
}

class _AddWorkoutPageState extends State<AddWorkoutPage> {
  String? name;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ServiceLocator.addWorkoutBloc,
      child: Scaffold(
        body: BlocBuilder<AddWorkoutBloc, AddWorkoutState>(
          builder: (context, state) {
            return CustomScrollView(
              slivers: [
                const SliverAppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.red,
                ),
                SliverMainAxisGroup(
                  slivers: [
                    SliverToBoxAdapter(
                      child: FormBuilder(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FieldManager(
                              context: context,
                              fieldName: programFieldName,
                              labeltext: context.l10n.workoutName,
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
                  ],
                ),
                /* SliverPadding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  sliver: SliverToBoxAdapter(
                    child: FormBuilder(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FieldManager(
                            context: context,
                            fieldName: programFieldName,
                            labeltext: context.l10n.workoutName,
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
                ), */
                SliverToBoxAdapter(
                  child: ElevatedButton(
                    child: const Text('Submit'),
                    onPressed: () {
                      final forBuilderState = _formKey.currentState;
                      if (forBuilderState != null &&
                          forBuilderState.saveAndValidate()) {
                        context.read<AddWorkoutBloc>().add(
                              AddWorkoutEvent.addWorkout(name: name!),
                            );
                      }
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
