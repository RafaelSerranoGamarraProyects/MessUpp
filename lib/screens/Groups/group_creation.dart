import 'package:messup/models/models.dart';
import 'package:flutter/material.dart';
import 'package:messup/theme/custom_styles.dart';
import 'package:provider/provider.dart';
import '../../providers/providers.dart';
import '../../widgets/widgets.dart';

class GroupCreation extends StatelessWidget {
  const GroupCreation({super.key});

  @override
  Widget build(BuildContext context) {
		return GestureDetector(
      onTap: () =>  FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
			appBar: AppBar(title: const Text('Crear Grupo', style: TextStyle(color: AppTheme.textColorPrimary)),
      iconTheme: const IconThemeData(color: AppTheme.textColorPrimary),),
			resizeToAvoidBottomInset: false,
      body:  const Stack(
        children: [
          Background(),
					CreateGroupBox(),
        ],
      ),
    ));
  }
}

class CreateGroupBox extends StatelessWidget {
  const CreateGroupBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ChangeNotifierProvider(
          create: (_) => CreateGroupProvider(),
          child: const Column(
    			children: [
						GroupNameSection(),
						ParticipantsSection(),
						SummnitButton()
    			]),
        ),
      ],
    );
  }
}

class SummnitButton extends StatelessWidget {
  const SummnitButton({ super.key });

  @override
  Widget build(BuildContext context) {
		final userProvider = Provider.of<UsersProvider>(context);
		final groupProvider = Provider.of<GroupsProvider>(context);
		final createGroupProvider = Provider.of<CreateGroupProvider>(context);
		final size = MediaQuery.of(context).size;
    return ElevatedButton(onPressed:() {
    	 if( createGroupProvider.name != "" ) {
					createGroupProvider.participants.add(userProvider.userLogged!.getUserName);
					final newGroup = Group(name: createGroupProvider.name, creationDate: DateTime.now(), image: "", participants: createGroupProvider.participants, transactions: []);
					groupProvider.createGroup(newGroup);
					Navigator.pop(context);
    	 }
    	 
    },
     style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryColor, minimumSize: Size(size.width - 40, 100)),
     child: const Text("Crear grupo", style: TextStyle(color: AppTheme.textColorPrimary)));
  }
}

class GroupNameSection extends StatelessWidget {
  const GroupNameSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
    	padding: EdgeInsets.only(top: 20, bottom: 0,left: 5, right: 5),
    	child: Column(
    	children: [
    	Text('Nombre del Grupo', style: TextStyle(color: AppTheme.textColorPrimary, fontWeight: FontWeight.normal, fontSize: 20)),
    	AddGroupName(),
    	],),
    );
  }
}

class ParticipantsSection extends StatelessWidget {
  const ParticipantsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
    	padding: EdgeInsets.only(top: 20, bottom: 0,left: 5, right: 5),
    	child: Column(
    	children: [
    	Text('Participantes', style: TextStyle(color: AppTheme.textColorPrimary, fontWeight: FontWeight.normal, fontSize: 20)),
    	AddParticipantForm(),
    	],
    	),
    );
  }
}


