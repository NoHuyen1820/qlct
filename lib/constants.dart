import 'package:flutter/material.dart';

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

const Map<int, String> categorySelect = {
  1:"Water Bill",
  8:"Gift & Charity",
  9:"Salary",
  4:"Phone Bill",
  12:"Pension",
  7:"Gaming",
  5:"Food & Beverage",
  11:"Saving",
  0:"Electricity Bill",
  6:"Sporting",
  3:"Internet Bill",
  2:"House Rental",
  10:"Investment",
};




const Map<String, String> recurringOptions = {
  "Never repeat":"00",
  "Everyday":"01",
  "Every week":"07",
  "Every month":"30",
};
