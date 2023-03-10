import 'dart:io';
import 'package:boboloc/models/car_contract_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';

class MyFunctions {
  // this function return the last day of the monthPicked
  getLimitDay({required int monthPicked}) {
    switch (monthPicked) {
      case 1:
        {
          return 31;
        }

      case 2:
        {
          return 28;
        }

      case 3:
        {
          return 31;
        }

      case 4:
        {
          return 30;
        }

      case 5:
        {
          return 31;
        }

      case 6:
        {
          return 30;
        }

      case 7:
        {
          return 31;
        }

      case 8:
        {
          return 31;
        }

      case 9:
        {
          return 30;
        }

      case 10:
        {
          return 31;
        }

      case 11:
        {
          return 30;
        }

      case 12:
        {
          return 31;
        }

      default:
        {
          //statements;
        }
        break;
    }
  }

// This function return the path of the mobile's download folder
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

  Future<String> addContractToStorage(File file) async {
    var randomNumber =
        Timestamp.fromDate(DateTime.now()).microsecondsSinceEpoch.toString();
    try {
      await FirebaseStorage.instance
          .ref('contracts/contract-$randomNumber.pdf')
          .putFile(file);
      String downloadUrl = await FirebaseStorage.instance
          .ref('contracts/contract-$randomNumber.pdf')
          .getDownloadURL();

      print(downloadUrl);

      return downloadUrl;
    } catch (e) {
      print(e);
      return '';
    }
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

  //Signature

  Future<Uint8List> exportSignature({mySignatureController}) async {
    final exportController = SignatureController(
        penStrokeWidth: 2,
        penColor: Colors.black,
        exportBackgroundColor: Colors.white,
        points: mySignatureController.points);

    final signature = await exportController.toPngBytes();

    exportController.dispose();

    return signature!;
  }

  Future<String> generatorPdf({required CarContractModel contractDatas}) async {
    var contractNumber =
        Timestamp.fromDate(DateTime.now()).microsecondsSinceEpoch.toString();
    String carBrand = contractDatas.carBrand;

    String carModel = contractDatas.carModel;
    String carRegistrationNumber = contractDatas.carRegistrationNumber;
    String currentCarKilometer = contractDatas.currentCarKilometer;
    String kilometerAllowed = contractDatas.kilometerAllowed;
    int numberOfRentDays = contractDatas.numberOfRentDays;
    String ownerAdresse = contractDatas.ownerAdresse;
    String ownerCompanyName = contractDatas.ownerCompanyName;
    String ownerEmail = contractDatas.ownerEmail;
    String ownerFirstName = contractDatas.ownerFirstName;
    String ownerName = contractDatas.ownerName;
    Uint8List ownerSignature = contractDatas.ownerSignature;
    String ownerPhoneNumber = contractDatas.ownerPhoneNumber;
    String priceExceedKilometer = contractDatas.priceExceedKilometer;
    String rentEndDay = contractDatas.rentEndDay.toString();
    int rentEndMonth = contractDatas.rentEndMonth;
    String rentEndYear = contractDatas.rentEndYear.toString();

    int rentPrice = contractDatas.rentPrice;
    String rentStartDay = contractDatas.rentStartDay.toString();
    int rentStartMonth = contractDatas.rentStartMonth;
    String rentStartYear = contractDatas.rentStartYear.toString();
    String rentalDeposit = contractDatas.rentalDeposit;
    String renterAdresse = contractDatas.renterAdresse;
    String renterCity = contractDatas.renterCity;

    Uint8List renterSignature = contractDatas.renterSignature;
    String renterEmail = contractDatas.renterEmail;
    String renterFirstName = contractDatas.renterFirstName;
    String renterName = contractDatas.renterName;
    String? renterPhoneNumber = contractDatas.renterPhoneNumber;
    String renterPostalCode = contractDatas.renterPostalCode;
    Uint8List renterIdentityCardRecto = contractDatas.renterIdentityCardRecto;
    Uint8List renterIdentityCardVerso = contractDatas.renterIdentityCardVerso;
    Uint8List renterLicenseDriverRecto = contractDatas.renterLicenseDriverRecto;
    Uint8List renterLicenseDriverVerso = contractDatas.renterLicenseDriverVerso;

    List monthsName = [
      '0',
      'janvier',
      'fevrier',
      'mars',
      'avril',
      'mai',
      'juin',
      'juillet',
      'aout',
      'septembre',
      'octobre',
      'novembre',
      'd??cembre'
    ];

    final font = await rootBundle.load("fonts/roboto-medium.ttf");
    final ttf = pw.Font.ttf(font);

    final pdf = pw.Document();

    pw.TableRow tableRowCustomerName = pw.TableRow(children: [
      pw.Padding(
        padding: const pw.EdgeInsets.all(10.0),
        child: pw.Text('Nom :',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
      ),
      pw.Padding(
          padding: const pw.EdgeInsets.all(10.0), child: pw.Text(renterName)),
    ]);

    pw.TableRow tableRowCustomerFirstName = pw.TableRow(children: [
      pw.Padding(
        padding: const pw.EdgeInsets.all(10.0),
        child: pw.Text('Pr??nom :',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
      ),
      pw.Padding(
          padding: const pw.EdgeInsets.all(10.0),
          child: pw.Text(renterFirstName)),
    ]);

    pw.TableRow tableRowCustomerAdresse = pw.TableRow(children: [
      pw.Padding(
        padding: const pw.EdgeInsets.all(10.0),
        child: pw.Text('Adresse :',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
      ),
      pw.Padding(
          padding: const pw.EdgeInsets.all(10.0),
          child: pw.Text(renterAdresse)),
    ]);

    pw.TableRow tableRowCustomerCity = pw.TableRow(children: [
      pw.Padding(
        padding: const pw.EdgeInsets.all(10.0),
        child: pw.Text('Ville :',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
      ),
      pw.Padding(
          padding: const pw.EdgeInsets.all(10.0), child: pw.Text(renterCity)),
    ]);

    pw.TableRow tableRowCustomerPhoneNumber = pw.TableRow(children: [
      pw.Padding(
        padding: const pw.EdgeInsets.all(10.0),
        child: pw.Text('T??l??phone :',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
      ),
      pw.Padding(
          padding: const pw.EdgeInsets.all(10.0),
          child: pw.Text(renterPhoneNumber!)),
    ]);

    pw.TableRow tableRowCustomerPostalCode = pw.TableRow(children: [
      pw.Padding(
        padding: const pw.EdgeInsets.all(10.0),
        child: pw.Text('Code postal :',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
      ),
      pw.Padding(
          padding: const pw.EdgeInsets.all(10.0),
          child: pw.Text(renterPostalCode)),
    ]);

    pw.TableRow tableRowCarBrand = pw.TableRow(children: [
      pw.Padding(
        padding: const pw.EdgeInsets.all(10.0),
        child: pw.Text('Marque :',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
      ),
      pw.Padding(
          padding: const pw.EdgeInsets.all(10.0), child: pw.Text(carBrand)),
    ]);

    pw.TableRow tableRowCarModel = pw.TableRow(children: [
      pw.Padding(
        padding: const pw.EdgeInsets.all(10.0),
        child: pw.Text('Mod??le :',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
      ),
      pw.Padding(
          padding: const pw.EdgeInsets.all(10.0), child: pw.Text(carModel)),
    ]);

    pw.TableRow tableRowCarRegistrationNumber = pw.TableRow(children: [
      pw.Padding(
        padding: const pw.EdgeInsets.all(10.0),
        child: pw.Text('Immatriculation :',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
      ),
      pw.Padding(
          padding: const pw.EdgeInsets.all(10.0),
          child: pw.Text(carRegistrationNumber)),
    ]);

    pw.TableRow tableRowCarTitle = pw.TableRow(children: [
      pw.Container(
        decoration: const pw.BoxDecoration(color: PdfColors.grey),
        child: pw.Padding(
            padding: const pw.EdgeInsets.all(10.0),
            child: pw.Text('Identification du v??hicule',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
      )
    ]);

    pw.TableRow tableRowCustomerTitle = pw.TableRow(children: [
      pw.Container(
          decoration: const pw.BoxDecoration(color: PdfColors.grey),
          child: pw.Padding(
              padding: const pw.EdgeInsets.all(10.0),
              child: pw.Text('Identification du locataire',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)))),
    ]);

    pw.TableRow tableRowGeneralDetails = pw.TableRow(children: [
      pw.Container(
          decoration: const pw.BoxDecoration(color: PdfColors.grey),
          child: pw.Padding(
              padding: const pw.EdgeInsets.all(10.0),
              child: pw.Text('Informations g??n??rales',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)))),
    ]);

    pw.TableRow tableRowDepart = pw.TableRow(children: [
      pw.Padding(
        padding: const pw.EdgeInsets.all(10.0),
        child: pw.Text('D??part :',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
      ),
      pw.Padding(
          padding: const pw.EdgeInsets.all(10.0),
          child: pw.Text("$rentStartDay/$rentStartMonth/$rentStartYear")),
    ]);

    pw.TableRow tableRowRetour = pw.TableRow(children: [
      pw.Padding(
        padding: const pw.EdgeInsets.all(10.0),
        child: pw.Text('Retour :',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
      ),
      pw.Padding(
          padding: const pw.EdgeInsets.all(10.0),
          child: pw.Text("$rentEndDay/$rentEndMonth/$rentEndYear")),
    ]);
    pw.TableRow tableRowPrice = pw.TableRow(children: [
      pw.Padding(
        padding: const pw.EdgeInsets.all(10.0),
        child: pw.Text('Tarif :',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
      ),
      pw.Padding(
          padding: const pw.EdgeInsets.all(10.0),
          child: pw.Text('$rentPrice euros')),
    ]);
    pw.TableRow tableRowCurrentKilometer = pw.TableRow(children: [
      pw.Padding(
        padding: const pw.EdgeInsets.all(10.0),
        child: pw.Text('Kilom??tre au d??part :',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
      ),
      pw.Padding(
          padding: const pw.EdgeInsets.all(10.0),
          child: pw.Text('$currentCarKilometer Km')),
    ]);

    pw.TableRow tableRowSignature = pw.TableRow(children: [
      pw.Padding(
        padding: const pw.EdgeInsets.all(10.0),
        child: pw.Text('Signature du locataire :',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
      ),
      pw.Padding(
        padding: const pw.EdgeInsets.all(10.0),
        child: pw.Text('Signature du loueur :',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
      ),
    ]);

    pw.TableRow tableRowSignatureSigned = pw.TableRow(children: [
      pw.Container(
          height: 60,
          width: 60,
          child: pw.Image(pw.MemoryImage(renterSignature))),
      pw.Container(
          height: 60,
          width: 60,
          child: pw.Image(pw.MemoryImage(ownerSignature)))
    ]);

    pw.TableRow tableRowCarKilometerAllowed = pw.TableRow(children: [
      pw.Padding(
        padding: const pw.EdgeInsets.all(10.0),
        child: pw.Text('Kilom??tre autoris?? :',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
      ),
      pw.Padding(
          padding: const pw.EdgeInsets.all(10.0),
          child: pw.Text('$kilometerAllowed Km')),
    ]);

    pw.TableRow tableRowCaution = pw.TableRow(children: [
      pw.Padding(
        padding: const pw.EdgeInsets.all(10.0),
        child: pw.Text('Caution :',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
      ),
      pw.Padding(
          padding: const pw.EdgeInsets.all(10.0),
          child: pw.Text('$rentalDeposit euros')),
    ]);

    pw.TableRow tableRowRentDays = pw.TableRow(children: [
      pw.Padding(
        padding: const pw.EdgeInsets.all(10.0),
        child: pw.Text('Jours de location :',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
      ),
      pw.Padding(
          padding: const pw.EdgeInsets.all(10.0),
          child: pw.Text('$numberOfRentDays jours')),
    ]);

    pw.TableRow tableRowCustomerLicenseDriverNumber = pw.TableRow(children: [
      pw.Padding(
        padding: const pw.EdgeInsets.all(10.0),
        child: pw.Text('Email :',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
      ),
      pw.Padding(
          padding: const pw.EdgeInsets.all(10.0), child: pw.Text(renterEmail)),
    ]);

    print('pdf created');
    pdf.addPage(
      pw.MultiPage(
          build: (pw.Context context) => [
                pw.Container(
                    child: pw.Column(children: [
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Column(children: [
                          pw.Text('Boboloc',
                              style: pw.TextStyle(
                                  fontSize: 30, fontWeight: pw.FontWeight.bold))
                        ]),
                        pw.Column(children: [
                          pw.Text('Contrat de location',
                              style: pw.TextStyle(
                                  fontSize: 20,
                                  fontWeight: pw.FontWeight.bold)),
                          pw.Row(children: [
                            pw.Text(
                              'N?? de contrat : ',
                            ),
                            pw.Container(child: pw.Text(contractNumber))
                          ])
                        ])
                      ]),
                  pw.SizedBox(height: 20),
                  pw.Container(
                      child: pw.Text(
                          "Le pr??sent contrat est ??tablie au moment de la prise en charge du v??hicule. Il est indissociable du contrat de location. Ce dernier fait foi entre les deux parties.")),
                  pw.Container(
                    child: pw.Text(
                        "Le loueur met ?? disposition le v??hicule mentionn?? ci-dessus au locataire pr??alablement identifi??. Les parties conviennent express??ment que tout litige pouvant na??tre de l'ex??cution du pr??sent contrat rel??vera de la comp??tence d'un tribunal de commerce.Ce contrat est fait en deux exemplaires originaux remis ?? chacune des parties."),
                  ),
                  pw.SizedBox(
                    height: 5,
                  ),
                  pw.Container(
                      width: 482,
                      child: pw.Column(children: [
                        pw.Row(children: [
                          pw.Text('Le loueur : '),
                          pw.Text('$ownerName '),
                          pw.Text('$ownerFirstName '),
                          pw.Text('Demeurant ?? '),
                          pw.Text('$ownerAdresse.'),
                        ]),
                      ])),
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Column(children: [
                          pw.SizedBox(height: 30),
                          pw.Table(
                              border:
                                  pw.TableBorder.all(color: PdfColors.black),
                              children: [
                                tableRowCustomerTitle,
                              ]),
                          pw.Table(
                              border:
                                  pw.TableBorder.all(color: PdfColors.black),
                              children: [
                                tableRowCustomerName,
                                tableRowCustomerFirstName,
                                tableRowCustomerPhoneNumber,
                                tableRowCustomerAdresse,
                                tableRowCustomerCity,
                                tableRowCustomerPostalCode,
                                tableRowCustomerLicenseDriverNumber
                              ])
                        ]),
                        pw.Column(children: [
                          pw.SizedBox(height: 30),
                          pw.Table(children: [tableRowGeneralDetails]),
                          pw.Table(
                              border:
                                  pw.TableBorder.all(color: PdfColors.black),
                              children: [
                                tableRowDepart,
                                tableRowRetour,
                                tableRowCaution,
                                tableRowRentDays,
                                tableRowCarKilometerAllowed,
                                tableRowPrice,
                                tableRowCurrentKilometer,
                              ]),
                        ]),
                      ])
                ])),
                pw.SizedBox(height: 10),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Column(children: [
                        pw.Table(
                            border: pw.TableBorder.all(color: PdfColors.black),
                            children: [
                              tableRowCarTitle,
                            ]),
                        pw.Table(
                            border: pw.TableBorder.all(color: PdfColors.black),
                            children: [
                              tableRowCarModel,
                              tableRowCarBrand,
                              tableRowCarRegistrationNumber,
                            ]),
                      ]),
                    ]),
                pw.SizedBox(height: 20),
                pw.Container(
                  child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Table(children: [
                          tableRowSignature,
                          tableRowSignatureSigned
                        ]),
                      ]),
                ),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                    children: [
                      pw.Container(
                          height: 200,
                          width: 220,
                          decoration:
                              const pw.BoxDecoration(color: PdfColors.grey),
                          child: pw.Image(
                            pw.MemoryImage(renterIdentityCardRecto),
                          )),
                      pw.Container(
                          height: 200,
                          width: 220,
                          decoration:
                              const pw.BoxDecoration(color: PdfColors.grey),
                          child: pw.Image(
                            pw.MemoryImage(renterIdentityCardVerso),
                          ))
                    ]),
                pw.SizedBox(height: 20),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                    children: [
                      pw.Container(
                          height: 200,
                          width: 220,
                          decoration:
                              const pw.BoxDecoration(color: PdfColors.grey),
                          child: pw.Image(
                            pw.MemoryImage(renterLicenseDriverRecto),
                          )),
                      pw.Container(
                          height: 200,
                          width: 220,
                          decoration:
                              const pw.BoxDecoration(color: PdfColors.grey),
                          child: pw.Image(
                            pw.MemoryImage(renterLicenseDriverVerso!),
                          )),
                    ]),
                pw.SizedBox(height: 20),
                pw.Container(
                  child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Table(children: [
                          tableRowSignature,
                          tableRowSignatureSigned
                        ]),
                      ]),
                ),
              ]),
    );

    PermissionStatus status = await Permission.storage.status;

    if (!status.isGranted) {
      await Permission.storage.request();
    }
    Permission.storage.request();

    final output = await getDirectoryImage();

    if (output != null) {
      final file = File("${output.path}/testImage8520.pdf");

      await file.writeAsBytes(await pdf.save());

      String contractUrl = await addContractToStorage(file);

      return contractUrl;
    }
    return '';
  }

  downloadPdf({pdfBytes}) async {
    PermissionStatus status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    final output = await getDirectoryImage();

    if (output != null) {
      String randomFileName =
          Timestamp.fromDate(DateTime.now()).microsecondsSinceEpoch.toString();

      final file = File("${output.path}/boboloc-$randomFileName.pdf");
      await file.writeAsBytes(await pdfBytes);
    }
  }
}
