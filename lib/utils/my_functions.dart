import 'dart:ffi';
import 'dart:io';
import 'package:boboloc/models/car_contract_model.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

class MyFunctions {
  Future<Directory?> getDirectoryImage() async {
    Directory? directory;
    if (Platform.isIOS) {
      directory = await getApplicationDocumentsDirectory();
    } else {
      directory = Directory('/storage/emulated/0/Download');

      if (!await directory.exists()) {
        directory = await getExternalStorageDirectory();
      }
    }
    return directory;
  }

  Future<Uint8List> pickImageFromgallery() async {
    final ImagePicker imagePicker = ImagePicker();

    //pick image from gallery, it will return XFile
    final XFile? imagePicked =
        await imagePicker.pickImage(source: ImageSource.gallery);

    //Convert image path to file
    File imagePickedPathConvertedToFile = File(imagePicked!.path);

    // Convert file to bytes

    return await imagePickedPathConvertedToFile.readAsBytes();
  }

  Future<void> generatorPdf({required CarContractModel contractDatas}) async {
    String carBrand = contractDatas.carBrand;

    String carModel = contractDatas.carModel;
    String carRegistrationNumber = contractDatas.carRegistrationNumber;
    String currentCarKilometer = contractDatas.currentCarKilometer;
    String kilometerAllowed = contractDatas.kilometerAllowed;
    String numberOfRentDays = contractDatas.numberOfRentDays;
    String ownerAdresse = contractDatas.ownerAdresse;
    String ownerCompanyName = contractDatas.ownerCompanyName;
    String ownerEmail = contractDatas.ownerEmail;
    String ownerFirstName = contractDatas.ownerFirstName;
    String ownerName = contractDatas.ownerName;
    String ownerPhoneNumber = contractDatas.ownerPhoneNumber;
    String priceExceedKilometer = contractDatas.priceExceedKilometer;
    String rentEndDay = contractDatas.rentEndDay;

    String rentPrice = contractDatas.rentPrice;
    String rentStartDay = contractDatas.rentStartDay;
    String rentalDeposit = contractDatas.rentalDeposit;
    String renterAdresse = contractDatas.renterAdresse;
    String renterCity = contractDatas.renterCity;

    String? renterEmail = contractDatas.renterEmail;
    String renterFirstName = contractDatas.renterFirstName;
    String renterName = contractDatas.renterName;
    String? renterPhoneNumber = contractDatas.renterPhoneNumber;
    String renterPostalCode = contractDatas.renterPostalCode;
    Uint8List renterIdentityCardRecto = contractDatas.renterIdentityCardRecto;
    Uint8List? renterIdentityCardVerso = contractDatas.renterIdentityCardVerso;
    Uint8List renterLicenseDriverRecto = contractDatas.renterLicenseDriverRecto;
    Uint8List? renterLicenseDriverVerso =
        contractDatas.renterLicenseDriverVerso;

    print('kss');
    final font = await rootBundle.load("fonts/roboto-medium.ttf");
    final ttf = pw.Font.ttf(font);

    final pdf = pw.Document();
    final headers = ['Le locataire', 'Le loueur'];
    final users = [
      "signature précédée de la mention manuscrite bon pour accord ",
      "signature précédée de la mention manuscrite bon pour accord "
    ];

    final datas = [
      [
        "signature précédée de la mention manuscrite bon pour accord ",
        "signature précédée de la mention manuscrite bon pour accord "
      ]
    ];

    //final datas = users.map((user) => [user.name, user.age]).toList();

    //debut de test

    Uint8List imagePickedPathConvertedTobytes = await pickImageFromgallery();

    pdf.addPage(
      pw.MultiPage(
          build: (pw.Context context) => [
                pw.Center(
                    child: pw.Text("Contrat de location de voiture",
                        style: pw.TextStyle(
                            color: const PdfColor(0.2, 0.4, 0.4, 1),
                            font: ttf,
                            fontSize: 20))),
                pw.SizedBox(height: 20),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('Entre les soussignés :',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.Text(
                      'Monsieur $renterFirstName, $renterName, demaurant $renterAdresse.',
                    )
                  ],
                ),
                pw.SizedBox(
                  height: 10,
                ),
                pw.Container(
                    width: 500,
                    decoration: const pw.BoxDecoration(),
                    child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.end,
                        children: [
                          pw.Text(
                            " Ci après le \"Locataire\",",
                          ),
                          pw.Text(
                            "D'une part,",
                          )
                        ])),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('Et :',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.Text(
                      'Monsieur $ownerFirstName, $ownerName, demaurant $ownerAdresse.',
                    )
                  ],
                ),
                pw.Container(
                    width: 500,
                    decoration: const pw.BoxDecoration(),
                    child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.end,
                        children: [
                          pw.Text(
                            "Ci après le \"Loueur\"",
                          ),
                          pw.Text(
                            "D'autre part,",
                          )
                        ])),
                pw.SizedBox(height: 10),
                pw.Container(
                    width: 500,
                    child: pw.Text(
                        'Le loueur et le locataire étant ensemble désignés les "parties" et individuellement une "partie"')),
                pw.SizedBox(height: 10),
                pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('IL A ETE CONVENU CE QUI SUIT ;'),
                      pw.SizedBox(height: 10),
                      pw.Text("1.1 - Nature et date d'effet du contrat ",
                          style: const pw.TextStyle(
                              color: PdfColor(0.2, 0.4, 0.4, 1))),
                      pw.SizedBox(height: 10),
                      pw.Text(
                          "Le loueur met à disposition du locataire, un véhicule de marque $carBrand, immatriculé $carRegistrationNumber, à titre onéreux et à compter du $rentStartDay Kilométrage du véhicule :$currentCarKilometer kms "),
                      pw.SizedBox(height: 10),
                      pw.Text("1.2 - Etat du véhicule ",
                          style: const pw.TextStyle(
                              color: PdfColor(0.2, 0.4, 0.4, 1))),
                      pw.SizedBox(height: 10),
                      pw.Text(
                          "Lors de la remise du véhicule et lors de sa restitution, un procès-verbal de l'état du véhicule sera établi entre le locataire et le loueur. Le véhicule devra être restitué le même état que lors de sa remise. Toutes les détériorations sur le véhicule constatées sur le PV de sortie seront à la charge du locataire. Le locataire certifie être en possession du permis l'autorisant à conduire le présent véhicule. "),
                      pw.SizedBox(height: 10),
                      pw.Text("1.3 - Prix de la location du de la voiture",
                          style: const pw.TextStyle(
                              color: PdfColor(0.2, 0.4, 0.4, 1))),
                      pw.SizedBox(height: 10),
                      pw.Text(
                          "Les parties s'entendent sur un prix de location $rentPrice euros. Ce prix comprend un forfait de $kilometerAllowed kms pour la durée du contrat. "),
                      pw.SizedBox(height: 10),
                      pw.Text(
                          "Nombre de jours de location : $numberOfRentDays jours.",
                          style: const pw.TextStyle(
                              color: PdfColor(0.2, 0.4, 0.4, 1))),
                      pw.SizedBox(height: 10),
                      pw.Text("1.4 - Kilométrage supplémentaires ",
                          style: const pw.TextStyle(
                              color: PdfColor(0.2, 0.4, 0.4, 1))),
                      pw.SizedBox(height: 10),
                      pw.Text(
                          "Tout kilomètre réalisé au-delà du forfait indiqué à l'article 1.3 du présent contrat sera facturé au prix de $priceExceedKilometer euros. "),
                      pw.SizedBox(height: 10),
                      pw.Text("1.5 - Durée et restitution de la voiture ",
                          style: const pw.TextStyle(
                              color: PdfColor(0.2, 0.4, 0.4, 1))),
                      pw.SizedBox(height: 10),
                      pw.Text(
                          "Le contrat est à durée indéterminée. Il pourra y être mis fin par chacune des parties à tout moment en adressant un courrier recommandé en respectant un préavis d'un mois."),
                      pw.SizedBox(height: 10),
                      pw.Text("1.7 - Clause en cas de litige",
                          style: const pw.TextStyle(
                              color: PdfColor(0.2, 0.4, 0.4, 1))),
                      pw.SizedBox(height: 5),
                      pw.Text(
                          "Les parties conviennent expressément que tout litige pouvant naître de l'exécution du présent contratrelèvera de la compétence du tribunal de commerce de Pontoise ."),
                      pw.Text(
                          "Fait en deux exemplaires originaux remis à chacune des parties,"),
                      pw.SizedBox(height: 10),
                      pw.Text("1.8 - Pièces justificatifs du locataire",
                          style: const pw.TextStyle(
                              color: PdfColor(0.2, 0.4, 0.4, 1))),
                      pw.SizedBox(height: 10),
                      pw.Container(
                          height: 200,
                          width: 200,
                          child: pw.Image(
                              pw.MemoryImage(renterIdentityCardRecto))),
                      pw.Container(
                          height: 200,
                          width: 200,
                          child: pw.Image(
                              pw.MemoryImage(renterIdentityCardVerso!))),
                      pw.Container(
                          height: 200,
                          width: 200,
                          child: pw.Image(
                              pw.MemoryImage(renterLicenseDriverRecto))),
                      pw.Container(
                          height: 200,
                          width: 200,
                          child: pw.Image(
                              pw.MemoryImage(renterLicenseDriverVerso!))),
                      pw.SizedBox(height: 15),
                      pw.Text(
                          "Fait en deux exemplaires originaux remis à chacune des parties, "),
                      pw.Text("A ---, le --- "),
                      pw.SizedBox(height: 10),
                      pw.Table.fromTextArray(headers: headers, data: datas),
                    ])
              ]),
    );

    PermissionStatus status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }

    final output = await getDirectoryImage();

    if (output != null) {
      final file = File("${output.path}/testImage2233.pdf");
      await file.writeAsBytes(await pdf.save());
    }
  }
}
