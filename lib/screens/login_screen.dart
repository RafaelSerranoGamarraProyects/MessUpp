import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfg_app/theme/custom_validators.dart';

import '../providers/providers.dart';
import '../theme/custom_styles.dart';
import '../widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
	const LoginScreen({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: Stack(
				children:const  [
					Background(),
					
        	HeaderLoginIcon(),
					
					Center(
            child: LoginBoxSV()
          )
				],
			),
		);
	}
}

class LoginBoxSV extends StatelessWidget {
  const LoginBoxSV({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CardContainer(
            child: Column(
              children: [
                Text('Login', style: Theme.of(context).textTheme.headlineMedium ),
                ChangeNotifierProvider(
                  create: ( _ ) => LoginFormProvider(),
                  child: _LoginForm()
                ),
    
              ],)),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text('¿No tiene cuenta de TFG APP?', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20) ),
          ),
        ],
    );
  }
}

class _LoginForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UsersProvider>(context);
    final loginForm = Provider.of<LoginFormProvider>(context);

    return Form(
      key: loginForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,

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
            onPressed: loginForm.isLoading ? null : () async {
              
              FocusScope.of(context).unfocus();              
              if( !loginForm.isValidForm() ) return;

              loginForm.isLoading = true;
              userProvider.login(loginForm.email, loginForm.password);

              if(userProvider.user.email!="") return;
              // TODO: validar si el login es correcto
              loginForm.isLoading = false;

              Navigator.pushReplacementNamed(context, 'home');
            },
            child: Container(
              padding: const EdgeInsets.symmetric( horizontal: 80, vertical: 15),
              child: Text(
                loginForm.isLoading 
                  ? 'Espere'
                  : 'Ingresar',
                style: const TextStyle( color: Colors.white ),
              )
            )
          )

        ],
      ),
    );
  }
}