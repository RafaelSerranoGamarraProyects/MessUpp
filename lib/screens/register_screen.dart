import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:messup/models/models.dart';
import '../providers/providers.dart';
import '../theme/custom_styles.dart';
import '../widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
	const RegisterScreen({super.key});

	@override
	Widget build(BuildContext context) {
		return const Scaffold(
      resizeToAvoidBottomInset: false,
			body: Stack(
				children:[
					Background(),
        	HeaderLoginIcon(),
					RegisterBoxSV()
				],
			),
		);
	}
}

class RegisterBoxSV extends StatelessWidget {
  const RegisterBoxSV({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CardContainer(
              child: Column(
                children: [
                  Text('Registro', style: Theme.of(context).textTheme.headlineMedium ),
                  ChangeNotifierProvider(
                    create: ( _ ) => LoginFormProvider(),
                    child: _RegisterForm()
                  ),
      
                ],)),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: TextButton(
                onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
                child: const Text('¿Usted Ya tiene Cuenta? Inicie Sesion', style: TextStyle(color: AppTheme.textColorPrimary, fontWeight: FontWeight.bold, fontSize: 20) )
              ),
            ),
          ],
      ),
    );
  }
}

class _RegisterForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UsersProvider>(context);
    final loginForm = Provider.of<LoginFormProvider>(context);

    return Form(
      key: loginForm.formKey,
      autovalidateMode: AutovalidateMode.disabled,

      child: Column(
        children: [
          
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.formInputDecoration(
                hintText: 'john.doe@gmail.com',
                labelText: 'Correo electrónico',
                prefixIcon: Icons.alternate_email_rounded
              ),
              onChanged: ( value ) => loginForm.email = value,
              validator: (value) => CustomValidators.emailValidator(value: value),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.formInputDecoration(
                hintText: '*********',
                labelText: 'Contraseña',
                prefixIcon: Icons.lock_outline
              ),
              onChanged: ( value ) => loginForm.password = value,
              validator: (value) => CustomValidators.passwordValidator(value: value),
            ),
          ),


          MaterialButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            disabledColor: Colors.grey,
            elevation: 0,
            color: AppTheme.primaryColor,
            onPressed: loginForm.isLoading ? null : () async{
              
              FocusScope.of(context).unfocus();              
              if( !loginForm.isValidForm() ) return;

              loginForm.isLoading = true;
              
              final response =  await userProvider.register(loginForm.email, loginForm.password);

              if(response["error"] == null){
                userProvider.createUser(User(email: loginForm.email, password: loginForm.password));
                // ignore: use_build_context_synchronously
                Navigator.pushReplacementNamed(context, 'login');
              }else{
                // print(response["error"]);
                return ;
              
              }              
              
              loginForm.isLoading = false;

            },
            child: Container(
              padding: const EdgeInsets.symmetric( horizontal: 80, vertical: 15),
              child: Text(
                loginForm.isLoading 
                  ? 'Espere'
                  : 'Ingresar',
                style: const TextStyle( color: AppTheme.textColorPrimary),
              )
            )
          )

        ],
      ),
    );
  }
}