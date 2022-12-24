import 'package:flutter/material.dart';
import 'package:tolesson/const/general_path.dart';
import 'package:tolesson/ui/shared/widget/custom_elevated_button.dart';
import 'package:tolesson/ui/shared/widget/global_navigation_mixin.dart';
import 'package:tolesson/vexana/cutomFiled.dart';
import 'package:tolesson/vexana/vexana_%20model.dart';
import 'package:vexana/vexana.dart';
import 'package:kartal/kartal.dart';

class SignPage extends StatefulWidget {
  const SignPage({super.key});

  @override
  State<SignPage> createState() => _SignPageState();
}

class _SignPageState extends State<SignPage>
    with AppText, AppColor, AppIcon, AppSize, GlobalNavigationMixin {
//vexana

  late final INetworkManager networkManeger;

  final TextEditingController _mailTextEditingController =
      TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();

  GlobalKey<FormState> globalKey = GlobalKey();
  List<VexanaModel>? items;
  @override
  void dispose() {
    _passwordEditingController.dispose();
    _mailTextEditingController.dispose();
    super.dispose();
  }

//post model
  @override
  void initState() {
    super.initState();
    networkManeger = NetworkManager<INetworkModel<VexanaModel>>(
        options: BaseOptions(
            baseUrl: 'https://restapi-843b0-default-rtdb.firebaseio.com/'),
        noNetwork: NoNetwork(context));
  }

  Future<List<VexanaModel>?> sendUserInfo(VexanaModel model) async {
    final response = await networkManeger.send<VexanaModel, List<VexanaModel>>(
        'vexana.json',
        parseModel: VexanaModel(),
        method: RequestType.POST,
        data: model);
    return response.data;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Accaunt information vexana"),
        ),
        body: Form(
          autovalidateMode: AutovalidateMode.always,
          key: globalKey,
          child: Padding(
            padding: columnPadding,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  sizedBox,
                  Container(
                    padding: const EdgeInsets.all(16),
                    color: containerColor,
                    height: 400,
                    child: Column(
                      children: [
                        Center(
                            child: CustomUserLoginField(
                                controller: _mailTextEditingController,
                                validate: (value) => value.isValidEmail
                                    ? null
                                    : emailErrorText)),
                        sizedBox,
                        CustomUserLoginField(
                            controller: _passwordEditingController,
                            validate: (value) => value.isValidPassword
                                ? null
                                : "Bir sifre hesabi girin"),
                        sizedBox,
                      ],
                    ),
                  ),
                  sizedBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomElevatedButton(
                        onPressed: () {
                          if (globalKey.currentState?.validate() ?? false) {
                            final model = VexanaModel(
                                email: _mailTextEditingController.text,
                                password: _passwordEditingController.text);
                            sendUserInfo(model);
                            goToHomePage(context);
                          }
                        },
                        icon: iconNext,
                        text: buttonTextNext,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
