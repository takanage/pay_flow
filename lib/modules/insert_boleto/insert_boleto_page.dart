import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:payflow/modules/insert_boleto/insert_boleto_controller.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/widgets/input_text/input_text_widget.dart';
import 'package:payflow/shared/widgets/set_label_buttons/set_label_buttons.dart';

class InsertBoletoPage extends StatefulWidget {
  final String? barcode;

  const InsertBoletoPage({Key? key, this.barcode}) : super(key: key);

  @override
  _InsertBoletoPageState createState() => _InsertBoletoPageState();
}

class _InsertBoletoPageState extends State<InsertBoletoPage> {
  final controller = InsertBoletoController();
  final moneyInputTextController = MoneyMaskedTextController(
    leftSymbol: "R\$",
    decimalSeparator: ",",
  );
  final dueDateTextController = MaskedTextController(mask: "00/00/0000");
  final barcodeIntupTextController = TextEditingController();

  @override
  void initState() {
    if (widget.barcode != null) {
      barcodeIntupTextController.text = widget.barcode!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: BackButton(
          color: AppColors.input,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 93),
                child: Text(
                  "Preencha os dados do boleto",
                  style: TextStyles.titleBoldHeading,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Form(
                key: controller.formkey,
                child: Column(
                  children: [
                    InputTextWidget(
                      label: "Nome do boleto",
                      icon: Icons.description_outlined,
                      validator: controller.validateName,
                      onChanged: (value) {
                        controller.onChanged(name: value);
                      },
                    ),
                    InputTextWidget(
                      controller: dueDateTextController,
                      label: "Vencimento",
                      icon: FontAwesomeIcons.timesCircle,
                      validator: controller.validateVencimento,
                      onChanged: (value) {
                        controller.onChanged(dueDate: value);
                      },
                    ),
                    InputTextWidget(
                      controller: moneyInputTextController,
                      label: "Valor",
                      icon: FontAwesomeIcons.wallet,
                      validator: (_) => controller
                          .validateValor(moneyInputTextController.numberValue),
                      onChanged: (value) {
                        controller.onChanged(
                          value: moneyInputTextController.numberValue,
                        );
                      },
                    ),
                    InputTextWidget(
                      controller: barcodeIntupTextController,
                      label: "Código",
                      icon: FontAwesomeIcons.barcode,
                      validator: controller.validateCodigo,
                      onChanged: (value) {
                        controller.onChanged(barcode: value);
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: SetLabelButtons(
        enableSecondaryColor: true,
        primaryLabel: "Cancelar",
        primaryOnPressed: () {
          Navigator.pop(context);
        },
        secondaryLabel: 'Cadastrar',
        secondaryOnPressed: () async {
          await controller.cadastrarBoleto();
          Navigator.pop(context);
        },
      ),
    );
  }
}
