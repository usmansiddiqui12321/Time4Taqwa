import 'package:time4taqwa/exportall.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final authController = Get.put(AuthController());
  bool isRemember = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          elevation: 0,
          leading: const BackButton(
            color: AppColors.whitecolor,
          )),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              children: [
                20.h.verticalSpace,
                Image(
                  image: const AssetImage("assets/Quran.png"),
                  height: 70.sp,
                  width: 70.sp,
                ),
                const Text('Let’s Sign you in',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.lightTextColor)),
                const SizedBox(height: 5),
                const Text(
                  ' ipsum dolor sit aLoremmet, consectetur',
                  style: TextStyle(fontSize: 14, color: AppColors.kGrey60),
                ),
                const SizedBox(height: 30),

                AuthField(
                  title: 'Email Address',
                  hintText: 'Enter your email address',
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    } else if (!value.isEmail) {
                      return 'Invalid email address';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 15),
                // Password Field.
                AuthField(
                  title: 'Password',
                  hintText: 'Enter your password',
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    } else if (value.length < 8) {
                      return 'Password should be at least 8 characters long';
                    }
                    return null;
                  },
                  isPassword: true,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    RememberMeCard(
                      onChanged: (value) {
                        setState(() {
                          isRemember = value;
                        });
                      },
                    ),
                    const Spacer(),
                    CustomTextButton(
                      onPressed: () {
                        Get.to(() => const ForgetPassword());
                      },
                      text: 'Forget Password',
                      color: Colors.white,
                      fontSize: 12.sp,
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                GetBuilder(
                    init: authController,
                    builder: (controller) {
                      return PrimaryButton(
                        isloading: authController.loading,
                        color: AppColors.lightTextColor,
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            //! login
                            authController.login(
                                email: _emailController.text,
                                password: _passwordController.text);
                          }
                        },
                        text: 'Sign In',
                      );
                    }),
                const SizedBox(height: 20),
                RichText(
                  text: TextSpan(
                    text: 'Don’t have an account? ',
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.kGrey70),
                    children: [
                      TextSpan(
                        text: 'Sign Up',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.off(() => const SignUpPage());
                          },
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.whitecolor),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                // const TextWithDivider(),

                // const SizedBox(height: 20),
                const AgreeTermsTextCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
