import 'package:flutter/material.dart';
import 'package:qlct/theme/colors.dart';

const kPrimaryColor = Color(0xFF6F35A5);
const kPrimaryLightColor = Color(0xFFF1E6FF);
const kPrimaryWhiteColor = Color(0xffffffff);
const kPrimaryBlackColor = Color(0xff000000);

const List<String> listMonth = [
  "Jan",
  "Feb",
  "Mar",
  "Apr",
  "May",
  "Jun",
  "Jul",
  "Aug",
  "Sep",
  "Oct",
  "Nov",
  "Dec",
];

const List<String> listYear = ["2021", "2022"];

const Map<String, String> budgetOptions = {
  "test 1":"BG000010",
  "huyen":"BG000008",
  "test new":"BG000011",
  "đầu tư":"BG000006",
};


const Map<String, String> categoryOptions = {
  "waterAndBill":"1",
  "Water Bill":"1",
  "Gift & Charity":"8",
  "Salary":"9",
  "Phone Bill":"4",
  "Pension":"12",
  "Gaming":"7",
  "Food & Beverage":"5",
  "Saving":"11",
  "Electricity Bill":"0",
  "Sporting":"6",
  "Internet Bill":"3",
  "House Rental":"2",
  "Investment":"10",
};

const Map<String, String> categorySelectFinal = {
  "waterBill":"1",
  "giftAndCharity":"8",
  "salary":"9",
  "phoneBill":"4",
  "pension":"12",
  "gaming":"7",
  "foodAndBeverage":"5",
  "saving":"11",
  "electricity Bill":"0",
  "sporting":"6",
  "internetBill":"3",
  "houseRental":"2",
  "investment":"10",
};


const Map<int, String> categorySelect = {
  0:"Electricity Bill",
  1:"Water Bill",
  2:"House Rental",
  3:"Internet Bill",
  4:"Phone Bill",
  5:"Food & Beverage",
  6:"Sporting",
  7:"Gaming",
  8:"Gift & Charity",
  9:"Salary",
  10:"Investment",
  11:"Saving",
  12:"Pension",
};

const Map<int, Color> categoryColors = {
  0:QLCTColors.mainBlueColor,
  1:QLCTColors.mainPurpleColor,
  2:QLCTColors.mainERallyColor,
  3:QLCTColors.mainDRallyColor,
  4:QLCTColors.mainPinkColor,
  5:QLCTColors.mainGreenLightColor,
  6:QLCTColors.mainYellowColor,
  7:QLCTColors.mainGreenColor,
  8:QLCTColors.mainARallyColor,
  9:QLCTColors.mainRedColor,
  10:QLCTColors.mainFRallyColor,
  11:QLCTColors.mainCRallyColor,
  12:QLCTColors.mainBRallyColor,
};


const Map<String, String> recurringOptions = {
  "Never repeat":noneScheduleNotify,
  "Everyday":dayScheduleNotify,
  "Every week":weekScheduleNotify,
  "Every month":monthScheduleNotify,
};

const noneScheduleNotify = "NONE";
const dayScheduleNotify = "DAY";
const weekScheduleNotify = "WEEK";
const monthScheduleNotify = "MONTH";