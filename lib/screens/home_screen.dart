import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'map_screen.dart';

class HomeScreen extends StatefulWidget{
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Razorpay _razorpay;
  var gKey=GlobalKey<ScaffoldState>();
  var options;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
  return Scaffold(
    key: gKey,
    appBar: AppBar(
      title: Text("Home Page"),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FlatButton(
            child: Text("Map",style: TextStyle(color: Colors.white),),
            color: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>MapScreen()));
            },
          ),
          SizedBox(height: 30,),
          FlatButton(
            child: Text("Payment Gateway",style: TextStyle(color: Colors.white)),
            color: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onPressed: (){
              _razorpay.open(options);
            },
          ),
        ],
      ),
    ),
  );
  }

  @override
  void initState() {
    options = {
      'key': 'rzp_test_3CcrVCVFCMbGfn',
      'amount': 100,
      'name': 'Suhail P M',
      'description': 'Payment For Testing',
      'prefill': {
        'contact': '9744480144',
        'email': 'suhail0404@gmail.com'
      }
    };
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    SnackBar snack=SnackBar(content: Text("SUCCESS: " + response.paymentId),);
    gKey.currentState.showSnackBar(snack);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    SnackBar snack=SnackBar(content: Text("ERROR: " + response.code.toString() + " - " + response.message),);
    gKey.currentState.showSnackBar(snack);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    SnackBar snack=SnackBar(content: Text("EXTERNAL_WALLET: " + response.walletName,));
    gKey.currentState.showSnackBar(snack);
  }
}