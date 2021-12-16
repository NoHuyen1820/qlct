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
  "Hoá đơn tiền nước":"1",
  "Quà tặng & từ thiện":"8",
  "Lương":"9",
  "Hoá đơn điện thoại":"4",
  "Lương hưu":"12",
  "Giải trí":"7",
  "Đồ ăn & thức uống":"5",
  "Tiết kiệm":"11",
  "Hoá đơn điện":"0",
  "Thể thao":"6",
  " Hoá đơn Internet":"3",
  "Thuê nhà ":"2",
  "Đầu tư":"10",
  "Khác": "13",
};

const Map<String, String> categorySelectFinal = {
  "Hoá đơn tiền nước":"1",
  "Quà tặng & từ thiện":"8",
  "Lương":"9",
  "Tiền điện thoại":"4",
  "Lương hưu":"12",
  "Giải trí ":"7",
  "Đồ ăn & thức uống":"5",
  "Tiết kiệm":"11",
  "Hoá đơn điện":"0",
  "Thể thao":"6",
  " Hoá đơn Internet":"3",
  "Thuê nhà ":"2",
  "Đầu tư":"10",
  "Khác":"13",
};


const Map<int, String> categorySelect = {
  0:"Hoá đơn điện",
  1:"Hoá đơn tiền nước",
  2:"Thuê nhà",
  3:"Hoá đơn Internet",
  4:"Tiền điện thoại ",
  5:"Đồ ăn & thức uống",
  6:"Thể thao",
  7:"Giải trí",
  8:"Quà tặng & từ thiện",
  9:"Lương",
  10:"Đầu tư",
  11:"Tiết kiệm",
  12:"Lương hưu",
  13:"Khác",
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
  13:QLCTColors.mainDRallyColor,
};
const Map<String, String> completeOption ={
  "1 tháng": "1",
  "2 tháng":"2",
  "3 tháng":"3",
  "6 tháng":"6",
  "12 tháng":"12",
  "Không":"-1",
};

const Map<String, String> recurringOptions = {
  "Không lặp lại":noneScheduleNotify,
  "Mỗi ngày":dayScheduleNotify,
  "Mỗi tuần":weekScheduleNotify,
  "Mỗi tháng":monthScheduleNotify,
};

const noneScheduleNotify = "NONE";
const dayScheduleNotify = "DAY";
const weekScheduleNotify = "WEEK";
const monthScheduleNotify = "MONTH";