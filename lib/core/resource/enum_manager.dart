import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:car_connect/core/resource/color_manager.dart';

abstract class EnumManager {
    static String individualClient = 'Individual_Client';
    static String individualCompany = 'Commercial_Company';
    static String principle = 'Principal';


    static String faqs = 'faqs';
    static String aboutUs = 'about_us';
    static String whyUs = 'why_insure_iraq';

    static Map<String, String> insuranceRequestStatus = {
      premium: premiumCode,
      draft: draftCode,
      quotationRequested: quotationRequestedCode,
      quotationSent: quotationSentCode,
      quotationUnderProgress: quotationUnderProgressCode,
      quotationApproved: quotationApprovedCode,
    };

    static Map<String, Color> insuranceRequestStatusColor = {
      premiumCode: AppColorManager.blue,
      draftCode: AppColorManager.blue,
      quotationRequestedCode: AppColorManager.yellow,
      quotationSentCode: AppColorManager.blue,
      quotationUnderProgressCode: AppColorManager.blue,
      quotationApprovedCode: AppColorManager.green,
      cancelledCode : AppColorManager.red,
      "": AppColorManager.textAppColor
    };
    static Map<String, Color> claimStatusColor = {
      "1": AppColorManager.yellow,
      "2": AppColorManager.blue,
      "3": AppColorManager.green,
      "" : AppColorManager.textAppColor
    };



    static String premium = 'premium';
    static String draft = 'draft';
    static String quotationRequested = 'quotationRequested';
    static String quotationSent = 'quotationSent';
    static String quotationUnderProgress = 'quotationUnderProgress';
    static String quotationApproved = 'quotationApproved';
    static String cancelled = 'Cancelled';

    static String premiumCode = "1";
    static String draftCode = "2";
    static String quotationRequestedCode = "3";
    static String quotationSentCode = "4";
    static String quotationUnderProgressCode = "5";
    static String quotationApprovedCode = "6";
    static String cancelledCode = "7";



    static String inannaFlow = "1";
    static String isaFlow = "2";

    static String iraq = "iraq";


    static String optional() => "optional";

    static String none() => "none";

    static String mandatory() => "mandatory";


    static String dropDown = "dropDown";
    static const String string = "string";
    static const String date = "date";
    static const String number = "number";
    static const String textArea = "textArea";
    static const String pricingRate = "pricingRate";
    static const String ageBased = "ageBased";
    static const String user = "user";
    static const String file = "file";
    static const String issueDate = "issueDate";
    static const String expiredDate = "expiredDate";
    static const String mergeFilds = "mergeFilds";
    static const String table = "table";
    static const String splitRow = "splitRow";


}

