import 'dart:ffi';
import 'dart:io';
import 'package:boboloc/models/car_contract_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

class MyFunctions {
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

  Future<String> generatorPdf({required CarContractModel contractDatas}) async {
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
    String ownerPhoneNumber = contractDatas.ownerPhoneNumber;
    String priceExceedKilometer = contractDatas.priceExceedKilometer;
    String rentEndDay = contractDatas.rentEndDay.toString();

    String rentPrice = contractDatas.rentPrice;
    String rentStartDay = contractDatas.rentStartDay.toString();
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

    Uint8List imagePickedPathConvertedTobytes = await pickImageFromgallery();

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
        child: pw.Text('Prénom :',
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
        child: pw.Text('Téléphone :',
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
        child: pw.Text('Modèle :',
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
            child: pw.Text('Identification du véhicule',
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
              child: pw.Text('Informations générales',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)))),
    ]);

    pw.TableRow tableRowDepart = pw.TableRow(children: [
      pw.Padding(
        padding: const pw.EdgeInsets.all(10.0),
        child: pw.Text('Départ :',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
      ),
      pw.Padding(
          padding: const pw.EdgeInsets.all(10.0), child: pw.Text(rentStartDay)),
    ]);

    pw.TableRow tableRowRetour = pw.TableRow(children: [
      pw.Padding(
        padding: const pw.EdgeInsets.all(10.0),
        child: pw.Text('Retour :',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
      ),
      pw.Padding(
          padding: const pw.EdgeInsets.all(10.0), child: pw.Text(rentEndDay)),
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
        child: pw.Text('Kilomètre au départ :',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
      ),
      pw.Padding(
          padding: const pw.EdgeInsets.all(10.0),
          child: pw.Text('$currentCarKilometer Km')),
    ]);

    pw.TableRow tableRowCustomerSignature = pw.TableRow(children: [
      pw.Padding(
        padding: const pw.EdgeInsets.all(10.0),
        child: pw.Text('Signature du locataire :',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
      ),
      pw.Padding(padding: const pw.EdgeInsets.all(10.0), child: pw.Text('')),
    ]);

    pw.TableRow tableRowOwnerSignature = pw.TableRow(children: [
      pw.Padding(
        padding: const pw.EdgeInsets.all(10.0),
        child: pw.Text('Signature du loueur :',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
      ),
      pw.Padding(padding: const pw.EdgeInsets.all(10.0), child: pw.Text('')),
    ]);

    pw.TableRow tableRowCarKilometerAllowed = pw.TableRow(children: [
      pw.Padding(
        padding: const pw.EdgeInsets.all(10.0),
        child: pw.Text('Kilométre autorisé :',
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
        child: pw.Text('N° de permis :',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
      ),
      pw.Padding(
          padding: const pw.EdgeInsets.all(10.0), child: pw.Text('75524456')),
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
                              'N° de contrat : ',
                            ),
                            pw.Container(child: pw.Text('875269'))
                          ])
                        ])
                      ]),
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
                pw.SizedBox(height: 20),
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
                        pw.SizedBox(height: 15),
                        pw.Container(
                            width: 200,
                            child: pw.Text(
                                "Le présent contrat est établie au moment de la prise en charge du véhicule. Il est indissociable du contrat de location. Ce dernier fait foi entre les deux parties.")),
                      ]),
                      pw.Container(
                          height: 220,
                          width: 275,
                          decoration:
                              const pw.BoxDecoration(color: PdfColors.grey))
                    ]),
                pw.Container(
                    width: 482,
                    height: 83,
                    child: pw.Column(children: [
                      pw.Text(
                          "Le loueur met à disposition le véhicule mentionné ci-dessus au locataire préalablement identifié. Les parties conviennent expressément que tout litige pouvant naître de l'exécution du présent contrat relèvera de la compétence d'un tribunal de commerce.Ce contrat est fait en deux exemplaires originaux remis à chacune des parties."),
                      pw.Row(children: [
                        pw.Text('Le loueur : '),
                        pw.Text('$ownerName '),
                        pw.Text('$ownerFirstName '),
                        pw.Text('Demeurant à '),
                        pw.Text('$ownerAdresse .'),
                      ]),
                    ])),
                pw.Row(children: [
                  pw.Text('Loueur mandaté par la société : '),
                  pw.Text('$ownerCompanyName.')
                ]),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                    children: [
                      pw.Table(children: [
                        tableRowOwnerSignature,
                      ]),
                      pw.Table(children: [tableRowCustomerSignature])
                    ]),
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
                            pw.MemoryImage(renterIdentityCardVerso!),
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
                          ))
                    ])
              ]),
    );

    PermissionStatus status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }

    final output = await getDirectoryImage();

    if (output != null) {
      final file = File("${output.path}/testImage7000.pdf");
      await file.writeAsBytes(await pdf.save());
      String contractUrl = await addContractToStorage(file);

      return contractUrl;
    }
    return '';
  }
}
