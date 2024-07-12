import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';
import '../theme/custom_styles.dart';
import '../widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
	const LoginScreen({super.key});

	@override
	Widget build(BuildContext context) {
		return const Scaffold(
      resizeToAvoidBottomInset: false,
			body: Stack(
				children:[
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
    super.key,
  });

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
         Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: TextButton(
                onPressed: () => Navigator.pushReplacementNamed(context, 'register'),
                child: const Text('¿Aun no tiene una cuenta? Registro', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20) )
              ),
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
              keyboardType: TextInputType.visiblePassword,
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
              
              final response = await userProvider.login(loginForm.email, loginForm.password);

              if(response["error"] == null){
                //get User
                userProvider.user = loginForm.email;
                userProvider.getLoggedUser();
                
                await userProvider.storage.write(key: 'idToken', value: response["idToken"]);
                await userProvider.storage.write(key: 'email', value: response["email"]);
                // ignore: use_build_context_synchronously
                Navigator.pushReplacementNamed(context, 'home');
                loginForm.isLoading = false;
              }else{
                // print(response["error"]["message"]);
                loginForm.isLoading = false;
                return ;
              
              }              
           

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