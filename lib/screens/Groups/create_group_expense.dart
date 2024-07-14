import 'package:messup/models/models.dart';
import 'package:flutter/material.dart';
import 'package:messup/theme/custom_styles.dart';
import 'package:messup/widgets/widgets.dart';
import 'package:provider/provider.dart';
import '../../providers/providers.dart';


class AddGroupExpense extends StatelessWidget {
  const AddGroupExpense({super.key});

  @override
  Widget build(BuildContext context) {
    final Group group = ModalRoute.of(context)!.settings.arguments as Group;
		return Scaffold(
			appBar: AppBar(title: const Text("Añadir gasto", style: TextStyle(color: AppTheme.textColorPrimary), overflow: TextOverflow.ellipsis,),
      iconTheme: const IconThemeData(color: AppTheme.textColorPrimary),),
			resizeToAvoidBottomInset: false,
      body:  const Stack(
        children: [
          Background(),
					_AddGroupExpenseForm(),
        ],
      ),
    );
  }
}

class _AddGroupExpenseForm extends StatelessWidget {
  const _AddGroupExpenseForm();

  @override
  Widget build(BuildContext context) {
    final Group group = ModalRoute.of(context)!.settings.arguments as Group;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ChangeNotifierProvider(
          create: (_) => CreateGroupExpenseProvider(),
          child: _CreateGroupExpenseFormBody(group: group),
        ),
      ],
    );
  }
}

class _CreateGroupExpenseFormBody extends StatelessWidget {
  const _CreateGroupExpenseFormBody({
    required this.group,
  });

  final Group group;

  @override
  Widget build(BuildContext context) {
    final createGroupExpense = Provider.of<CreateGroupExpenseProvider>(context);
    return Form(
      key: createGroupExpense.formKey,
      child: Column(
            children: [
                const _ExpenseTitleSection(),
              const _ExpenseAmountSection(),
              _PayerSection(group: group),
                const _BeneficiariesSection(),
                const SubmitButton()
            ]),
    );
  }
}

class _PayerSection extends StatelessWidget {
  const _PayerSection({
    required this.group,
  });

  final Group group;

  @override
  Widget build(BuildContext context) {
    final createGroupExpenseProvider = Provider.of<CreateGroupExpenseProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text('Pagador', style: TextStyle(color: AppTheme.textColorPrimary, fontWeight: FontWeight.normal, fontSize: 20)),
        ),
        PayerDropdown(participants: group.participants, onPayerSelected: (p0) => createGroupExpenseProvider.payer = p0),
      ],
    );
  }
}

class SubmitButton extends StatelessWidget {
  const SubmitButton({ super.key });

  @override
  Widget build(BuildContext context) {
		final createGroupExpenseProvider = Provider.of<CreateGroupExpenseProvider>(context);
    final groupsProvider = Provider.of<GroupsProvider>(context);

    final Group group = ModalRoute.of(context)!.settings.arguments as Group;
		final size = MediaQuery.of(context).size;

    return ElevatedButton(onPressed:() {
      if (createGroupExpenseProvider.isValidForm()) {
        group.transactions.add(createGroupExpenseProvider.createTransaction());
        groupsProvider.updateTransactions(group);
        Navigator.pop(context);
      }
    },
     style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryColor, minimumSize: Size(size.width - 40, 100)),
     child: const Text("Añadir Gasto", style: TextStyle(color: AppTheme.textColorPrimary),),);
  }
}

class _ExpenseTitleSection extends StatelessWidget {
  const _ExpenseTitleSection();

  @override
  Widget build(BuildContext context) {
    return const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Text('Titulo', style: TextStyle(color: AppTheme.textColorPrimary, fontWeight: FontWeight.normal, fontSize: 20)),
      ),
    AddGroupDebtName(),
    ],);
  }
}

class _ExpenseAmountSection extends StatelessWidget {
  const _ExpenseAmountSection();

  @override
  Widget build(BuildContext context) {
    return const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text('Cantidad a pagar', style: TextStyle(color: AppTheme.textColorPrimary, fontWeight: FontWeight.normal, fontSize: 20)),
        ),  
      AddGroupDebtAmount(),
    ],);
  }
}

class _BeneficiariesSection extends StatelessWidget {
  const _BeneficiariesSection();

  @override
  Widget build(BuildContext context) {
    final Group group = ModalRoute.of(context)!.settings.arguments as Group;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
    	  const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text('Participantes', style: TextStyle(color: AppTheme.textColorPrimary, fontWeight: FontWeight.normal, fontSize: 20)),
        ),
        BeneficiariesList(group: group),
    ],
    );
  }
}


