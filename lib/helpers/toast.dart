import 'package:checks/helpers/colors.dart';
import 'package:fluttertoast/fluttertoast.dart' as FlutterToast;

class Toast{
	static info(String message) => FlutterToast.Fluttertoast.showToast(
		msg: message,
		fontSize: 15,
		gravity: FlutterToast.ToastGravity.BOTTOM,
		toastLength: FlutterToast.Toast.LENGTH_LONG,
		textColor: MyColors.White,
		backgroundColor: MyColors.Info
	);

	static error(String message) => FlutterToast.Fluttertoast.showToast(
		msg: message,
		fontSize: 15,
		gravity: FlutterToast.ToastGravity.BOTTOM,
		toastLength: FlutterToast.Toast.LENGTH_LONG,
		textColor: MyColors.White,
		backgroundColor: MyColors.Error
	);
	static success(String message) => FlutterToast.Fluttertoast.showToast(
		msg: message,
		fontSize: 15,
		gravity: FlutterToast.ToastGravity.BOTTOM,
		toastLength: FlutterToast.Toast.LENGTH_LONG,
		textColor: MyColors.White,
		backgroundColor: MyColors.Success
	);
	static secondary(String message) => FlutterToast.Fluttertoast.showToast(
		msg: message,
		fontSize: 15,
		gravity: FlutterToast.ToastGravity.BOTTOM,
		toastLength: FlutterToast.Toast.LENGTH_LONG,
		textColor: MyColors.White,
		backgroundColor: MyColors.DarkGrey
	);
}