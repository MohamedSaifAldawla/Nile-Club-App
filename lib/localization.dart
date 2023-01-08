import 'package:get/get.dart';

class Localization implements Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': {
          //----------------------------------- Auth Pages -------------------------//
          "Select Language": "Select Language",
          "AppName": "Nile Club",
          "Welcome": "Welcome",
          "WelcomeText": "Welcome to Nile Club App \nLet's book your ticket",
          "Login": "Login",
          "Register": "Register",
          "Intro Register": "Register",
          "Register New Account": "Register New Account",
          "Complete yor details": "Complete your details and continue",
          "Login as a": "Login as a ",
          "Vistor": "Visitor",
          "---- OR ----": "---- OR ----",
          "Email": "Email",
          "Enter your email": "Enter your email",
          "Enter your email": "Please enter your email",
          "Please Enter valid email": "Please enter valid email",
          "Firstname": "First name",
          "Client Name": "Client Name",
          "Client Phone": "Client Phone",
          "Enter your First name": "Enter your First name",
          "Please Enter your First name": "Please enter your First name",
          "Last name": "Last name",
          "Enter your Last name": "Enter your Last name",
          "Phone": "Phone",
          "Date of birth": "Date of birth",
          "Gender": "Gender",
          "Male": "Male",
          "Female": "Female",
          "Address": "Address",
          "Adult": "Adult",
          "Child": "Child",
          "Occupation": "Occupation",
          "Enter your Occupation": "Enter your Occupation",
          "Enter your Phone": "Enter your phone",
          "Please Enter your Phone": "Please enter your Phone",
          "Phone number is too short": "Phone number is too short from 10",
          "Password": "Password",
          "Enter your Password": "Enter your password",
          "New Password": "New Password",
          "Confirm New password": "Confirm New password",
          "Confirm password": "Confirm password",
          "Re-enter your password": "Re-enter your password",
          "Login with your Username": "Login with your Username and password",
          "Remember me": "Remember me",
          "Forgot Password": "Forgot Password ?",
          "Redeem Account": "Redeem Account",
          "Verification code": "Verification code",
          "OTP Verification": "OTP Verification",
          "Verification body": "We texted you a code please enter it below",
          "Please Enter your Last name": "Please enter your Last name",
          "Please Enter Valid Username": "Please enter valid username",
          "Please Enter your password": "Please enter your password",
          "Please Re-Enter your password": "Please Re-Enter your password",
          "Password is too short":
              "Password is too short must bee\n at least 8 digits",
          "Password did not matched": "Password did not matched",
          "Please Enter your name": "Please enter your name",
          "Please Enter your phone number": "Please enter your phone number",
          "Please Enter your address": "Please enter your address",
          "Enter your Address": "Enter your Address",
          "By continuing":
              "By continuing you confirm that you agree with our terms and conditions",
          "Reset": "Reset",
          "ٌRedeem": "ٌRedeem",
          "Reset Password": "Reset Password",
          "New password sent to your phone number":
              "New password sent to your phone number",
          "Reset Pass Body":
              "Please enter your phone number and \n we will send you reset code",
          "Continue": "Continue",
          "confirm Upadte": "confirm Update",
          "Registered successfully":
              "Registered successfully , please activate your account we will send you a verification code .",
          "Password has been changed": "Password has been changed",
          "Connection lost":
              "Connection lost please try again later or check your internet",
          'Connection time out': 'Connection time out',
          //----------------------------------- Home Page -------------------------//
          "Home": "Home",
          "Hello,": "Hello,",
          "Latest offers": "Latest offers",
          "News feed": "News feed",
          "See all": "See all",
          "Services": "Services",
          "Cinema": "Cinema",
          "Offers": "Offers",
          "New price": "New price ",
          "Original": "Original ",
          "Events": "Events",
          "Event Details": "Event Details",
          "Start Date": "Start Date",
          "Entrance": "Entrance",
          "Book Now": "Book Now",
          'Total Balance': 'Total Balance',
          "no offers yet": "Sorry , there is no offers",
          "no Events yet": "Sorry , there is no events",
          "no Transaction yet": "Sorry , there is no transaction",
          "no Movies yet": "Sorry , there is no movies",
          //----------------------------------- Profile Page -------------------------//
          "Profile": "Profile",
          "Language": "Language",
          "My Account": "My Account",
          "Wallet": "Wallet",
          "Account Details": "Account Details",
          "Update your account information":
              "Update your account information username \nand password",
          "Charge Wallet": "Charge Wallet",
          "Money Transfer": "Money Transfer",
          "Scan QR Code": "Scan QR Code",
          "Please align QR": "Please align QR within frame to scan",
          "Scan": "Start Scanning",
          "Resume Scanning": "Resume Scanning",
          "Enter your Amount": "Enter Amount",
          "Serial": "Serial number",
          "Enter serial number": "Enter serial number",
          "Please Enter serial": "Please Enter serial",
          "Ex:": "Ex: 100.00",
          "Ex:2": "Ex: 12457858954",
          "Enter amount": "Enter amount to be charge on your wallet",
          "Please Enter amount": "Please Enter amount",
          "Help Center": "Help Center",
          "Private Policy": "Private Policy",
          "Settings": "Settings",
          "Memberships Type": "Memberships Type",
          "Membership Type": "Membership Type",
          "Expire Date": "Expire Date",
          "Memberships": "Memberships",
          "submit form": "submit form",
          "Membership Confirmation": "Membership Confirmation",
          "Membership Activation": "Membership Activation",
          "Activate": "Activate",
          "View Memberships": "View Memberships",
          "Tap on the QR": "Tap on the QR to start scanning",
          "Log Out": "Log Out",
          "Confirm Logout": "Are you sure \nyou wan't to Logout ?",
          "Confirm Deleting":
              "Are you sure you wan't to delete \nyour account ?",
          "Yes": "Yes",
          "No": "No",
          "Cancel": "Cancel",
          "Platinum Membership": "Platinum Membership",
          "Golden Membership": "Golden Membership",
          "Add family members": "Add family members",
          "Adult's": "Adult's",
          "children's": "children's",
          "Add Adult": "Add Adult",
          "Add Child": "Add Child",
          "Number of months": "Select number of months",
          'Please select': 'Please select number of months',
          'Month': 'Month',
          '3 Months': '3 Months',
          '6 Months': '6 Months',
          '12 Months': '12 Months',
          "Membership status": "Membership status",
          "New": "New",
          "Exist": "Exist",
          "Membership ID": "Membership ID",
          "Enter your membership ID": "Enter your membership ID",
          "Please Enter your Membership ID": "Please Enter your Membership ID",
          "Membership Join": "Membership Join",
          "This QR contains":
              "This QR contains yor membership subscription details and packages, please show it when it requested",
          "Please complete the form below to join our membership":
              "Please complete the form below to join our membership",
          "Your application is under processing":
              "Your application is under processing",
          "Upload Personal Photo":
              "Please upload Personal Photo have a white background",
          "Personal Photo not selected": "Personal Photo not uploaded",
          "Upload Personal identification": "Upload Personal identification",
          "Personal ID not selected": "Personal ID not uploaded",
          "Please upload your personal photo and id":
              "Please upload your personal photo and id",
          "Sorry ,you reached the maximum number":
              "Sorry ,you reached the maximum number of adding adults to your membership",
          "Dark Mode": "Dark Mode",
          "Finger Authorization": "Fingerprint Authorization",
          "Delete account": "Delete account",
          "Please use finger":
              "Authenticate using your fingerprint \nto open the app",
          "Authenticate": "Authenticate",
          "Fingerprint activated successfully":
              "Fingerprint activated successfully",
          "Fingerprint not supported":
              "Fingerprint not supported in your phone",
          "Please enable fingerprint":
              "Please enable fingerprint security features from phone settings",
          //----------------------------------- Services Page -------------------------//
          "Comercial Services": "Commercial Services",
          "Service Details": "Service Details",
          "Service price": "Service price :",
          "Ticket type": "Ticket type :",
          "Total Price": "Total Price",
          "Remaning Balance": "Remaining Balance",
          "Confirm booking": "Confirm booking",
          "Sorry": "Sorry ,you must choose number of persons for the ticket",
          "message": "Sorry..No sufficient balance",
          //----------------------------------- Transaction Page -------------------------//
          "Transactions": "Transactions",
          "History": "History",
          "Latest Transactions": "Latest Transactions",
          //----------------------------------- News Page -------------------------//
          "News": "News Feed",
          "News Details": "News Details",

          //----------------------------------- Ticket Info -------------------------//
          "successfully booked": "Ticket reserved successfully",
          "Status": "Status :",
          "Amount": "Amount :",
          "Add Amount": "Amount",
          "Name": "Name :",
          "family": "family",
          "Phone no": "Phone no :",
          "Note": "Note :",
          "Booking Details": "Booking Details",
          "Transferred amount": "Transferred amount",
          "From": "From :",
          "To": "To :",
          "Date": "Date :",
          "No. of persons": "No. of persons :",
          "No. of family": "No. of family :",
          "person": " Person",
          "Service": "Service :",
          "Type": "Type :",
          "Package name": "Package name :",
          "Ticket organizer": "Ticket organizer :",
          "Ticket quantity": "Ticket quantity :",
          "Ticket name": "Ticket name :",
          "No. of Adults": "No. of Adults :",
          "No. of children's": "No. of children's :",
          "Save your ticket": "Save your ticket",
          "Extra fees": "Extra fees :",
          "Transaction id": "Transaction id :",
          "Saved successfully": "Saved successfully",
          'SDG': ' SDG',
          //----------------------------------- State Page -------------------------//
          "Successfull": "Completed Successfully",
          "Error": "Error",
          "Success": "Success",
          "Order canceled": "Payment has been canceled",
          "Order approved": "Payment successful, wallet charged successfully",
          "Transfer approved":
              "Transfer successful, wallet charged successfully",
          "Order declined": "Payment has been declined",
          "homepage": "Back to home",

          //----------------------------------- Contact Page -------------------------//
          "Contact us": "Contact us",
          'Working Hours': 'Working Hours',
          'Phone Numbers': 'Phone Numbers',
          'Email Address': 'Email Address',
          'Office Location': 'Office Location',
          "--------  Reach us on  --------": "--------  Reach us on  --------",

//----------------------------------- Other Page -------------------------//
          "Maintenance": "Sorry the app is under maintenance",
          "No connection":
              "No internet, Please check your cellular data or wifi connection and restart the app",
          "Restart app": "Restart app",
        },
        'ar': {
          //----------------------------------- Auth Pages -------------------------//
          "Select Language": "أختيار اللغة",
          "AppName": "نادي النيل",
          "Welcome": "مرحبا بك",
          "WelcomeText": "مرحبا بك في تطبيق نادي النيل \n هيا بنا لحجز تذكرتك",
          "Login": "تسجيل الدخول",
          "Intro Register": "تسجيل مستخدم جديد",
          "Register": "مستخدم جديد",
          "Register2": "تسجيل",
          "Register New Account": "تسجيل مستخدم جديد",
          "Complete yor details": "قم بإكمال إدخال بيانتك ومواصلة التسجيل",
          "Login as a ": "تسجيل الدخول  ",
          "Visitor": "كزائر",
          "---- OR ----": "---- أو ----",
          "Email": "البريد الإلكتروني",
          "Enter your email": "قم بإدخال البريد الإلكتروني",
          "Please Enter valid email": "الرجاء إدخال بريد إلكتروني صحيح",
          "Firstname": "الإسم الأول",
          "Client Name": "إسم العميل",
          "Client Phone": "هاتف العميل",
          "Enter your First name": "قم بإدخال إسمك الأول",
          "Please Enter your First name": "الرجاء قم بإدخال الإسم الأول",
          "Last name": "الإسم الأخير",
          "Enter your Last name": "قم بإدخال الإسم الأخير",
          "Username": "إسم المستخدم",
          "Enter your Username": "قم بإدخال إسم المستخدم",
          "Phone": "رقم الهاتف",
          "Date of birth": "تاريخ الميلاد",
          "Gender": "النوع",
          "Male": "ذكر",
          "Female": "أنثى",
          "Address": "العنوان",
          "Adult": "بالغ",
          "Child": "طفل",
          "Occupation": "العمل",
          "Enter your Occupation": "قم بإدخال نوع العمل",
          "Enter your Phone": "قم بإدخال رقم هاتفك",
          "Please Enter your Phone": "الرجاء قم بإدخال رقم هاتفك",
          "Phone number is too short": "رقم الهاتف اقل من 10",
          "Password": "كلمه المرور",
          "Enter your Password": "قم بإدخال كلمه المرور",
          "New Password": "كلمه السر الجديده",
          "New password sent to your phone number":
              "تم إرسال كلمة المرور الي رقم هاتفك",
          "Confirm New password": "تأكيد كلمه المرور الجديدة",
          "Confirm password": "تأكيد كلمة المرور",
          "Re-enter your password": "أعد كتابه كلمة المرور",
          "Login with your Username":
              "قم بتسجيل دخولك عن طريق كتابة إسم المستخدم وكلمة المرور",
          "Remember me": "حفظ بيانات الدخول",
          "Forgot Password": "هل نسيت كلمة المرور ؟",
          "Redeem Account": "إستعاده الحساب المحذوف",
          "OTP Verification": "التحقق",
          "Verification code": "رمز التحقق",
          "Verification body":
              "لقد ارسلنا اليك رساله نصيه في رقم هاتفك الرجال إدخاله في الأسفل",
          "Please Enter your Last name": "الرجاء قم بإدخال الإسم الأخير",
          "Please Enter your Username": "الرجاء إدخال إسم المستحدم",
          "Please Enter Valid Username": "الرجاء إدخال إسم المستخدم بشكل صحيح",
          "Please Enter your password": "الرجاء إدخال كلمة المرور",
          "Please Re-Enter your password": "الرجاء قم بتأكيد كلمة المرور",
          "Password is too short": "كلمة المرور يجب ان تكون 8 كلمات",
          "Password did not matched": "كلمة المرور غير متطابقه",
          "Please Enter your name": "الرجاء إدخال الإسم",
          "Please Enter your phone number": "الرجاء إدخال رقم الهاتف",
          "Please Enter your address": "الرجاء إدخال العنوان",
          "Enter your Address": "فم بإدخال العنوان",
          "By continuing":
              "مواصلتك التسجيل سوف تؤكد لنا انك توافق علي الشروط والأحكام",
          "Reset": "إستعادة كلمة المرور",
          "ٌRedeem": "إستعاده الحساب",
          "Reset Password": "إستعادة كلمة المرور",
          "Reset Pass Body":
              "الرجاء إدخال رقم الهاتف  \n وسوف نقوم بإرسال رابط لإستعادة كلمة المرور",
          "Continue": "تأكيد",
          "confirm Upadte": "حفظ التعديلات",
          "Registered successfully":
              "تم التسجيل بنجاح الرجاء تفعيل حسابك عن طريق رمز التحقق الذي ارسل اليك .",
          "Password has been changed": "تم تغيير كلمة المرور بنجاح",
          "Connection lost": "الرجاء التحقق من إتصال الإنترنت",
          'Connection time out': 'انتهت مده إتصال الإنترنت',
          //----------------------------------- Home Page -------------------------//
          "Home": "الصفحه الرئيسية",
          "Hello,": "مرحبا بك ",
          "Latest offers": "آخر العروض",
          "News feed": "اخر الأخبار",
          "See all": "المزيد",
          "Services": "الخدمات",
          "Cinema": "السينما",
          "Offers": "العروض",
          "New price": "سعر جديد ",
          "Original": "السعر القديم ",
          "Events": "المناسبات",
          "Event Details": "تفاصيل الحفل",
          "Start Date": "التاريخ",
          "Entrance": "الدخول",
          "Book Now": "إحجز الأن",
          'Total Balance': 'إجمالي الرصيد',
          "no offers yet": "عذرآ لا يوجد عروض حاليآ",
          "no Events yet": "عذرآ لا يوجد مناسبات حاليآ",
          "no Transaction yet": "عذرآ لا يوجد إشتراكات حاليآ",
          "no Movies yet": "عذرآ لا توجد أفلام حاليا",
          //----------------------------------- Profile Page -------------------------//
          "Profile": "الصفحه الشخصية",
          "Language": "أختيار اللغة",
          "My Account": "حسابي",
          "Wallet": "المحفظة",
          "Account Details": "بيانات الحساب",
          "Update your account information":
              "تعديل بيانات الحساب إسم المستخدم وكلمه المرور",
          "Charge Wallet": "شحن المحفظة",
          "Money Transfer": "تحويل أموال",
          "Scan QR Code": "إمسح رمز ال QR",
          "Please align QR": "الرجاء وضع الرمز مع الإطار المحدد في الصورة",
          "Scan": "بدء المسح",
          "Resume Scanning": "إعاده المسح",
          "Enter your Amount": "أدخل القيمة",
          "Serial": "الرقم التسلسلي",
          "Enter serial number": "قم بإدخال الرقم التلسلي",
          "Please Enter serial": "الرجاء إدخال الرقم التسلسلي",
          "Ex:": "مثال: 100.00",
          "Ex:2": "مثال: 12457858954",
          "Enter amount": "ادخل القيمة المراد تحويلها الي المحفظة",
          "Please Enter amount": "الرجاء إدخال القيمة",
          "Help Center": "المساعدة",
          "Private Policy": "الشروط والأحكام",
          "Settings": "الإعدادات",
          "Memberships Type": "نوع العضوية",
          "Membership Type": "نوع العضوية",
          "Expire Date": "تاريخ الإنتهاء",
          "Memberships": "الإشتراكات والعضوية",
          "submit form": "تأكيد الطلب",
          "Membership Confirmation": "تأكيد العضوية",
          "Membership Activation": "تفعيل العضوية",
          "Activate": "تفعيل العضوية",
          "View Memberships": "عرض الإشتراكات",
          "Tap on the QR": "الرجاء الضغط علي ال QR لبدء العملية",
          "Log Out": "خروج",
          "Confirm Logout": "تأكيد تسجيل الخروج ؟",
          "Confirm Deleting": "تأكيد مسح الحساب الحالي ؟",
          "Yes": "نعم",
          "No": "إلغاء",
          "Cancel": "إلغاء",
          "Platinum Membership": "العضويه البلاتينيه",
          "Golden Membership": "العضويه الذهبيه",
          "Add family members": "إضافه أفراد العائلة للعضوية",
          "Adult's": "البالغين",
          "children's": "الأطفال",
          "Add Adult": "إضافة شخص بالغ",
          "Add Child": "إضافة طفل",
          "Number of months": "إختيار عدد الشهور",
          'Please select': 'الرجاء إختيار عدد الشهور',
          'Month': 'شهر',
          '3 Month': '3 أشهر',
          '6 Month': '6 أشهر',
          '12 Month': '12 شهر',
          "Membership status": "حاله العضوية",
          "New": "جديدة",
          "Exist": "عضو سابق",
          "Membership ID": "رقم العضوية",
          "Enter your membership ID": "أدخل رقم العضوية",
          "Please Enter your Membership ID": "الرجاء إدخال رقم العضوية",
          "Membership Join": "تقديم طلب عضوية",
          "This QR contains":
              "هذا الرمز يحتوي علي تفاصيل العضوية الخاصة بك الرجاء إبرازة عند الطلب",
          "Please complete the form below to join our membership":
              "الرجاء ملء الفورم ادناة لطلب الإنضمام",
          "Your application is under processing":
              "ستم إرسال البيانات وسوف يتم معاينة طلب العضوية",
          "Upload Personal Photo":
              "الرجاء رفع صوره شخصية تحتوي علي خلفيه بيضاء",
          "Personal Photo not selected": "لم يتم رفع الصوره الشخصية",
          "Upload Personal identification": "قم برفع إثبات الشخصية",
          "Personal ID not selected": "لم يتم رفع إثبات الشخصية",
          "Please upload your personal photo and id":
              "الرجاء رفع الصوره الشخصية وإثبات الشخصية",
          "Sorry ,you reached the maximum number":
              "عذرا ,لقد وصلت الي الحد المطلوب لإضافه افراد العائله البالغين",
          "Dark Mode": "الوضع الليلي",
          "Finger Authorization": "التحقق بالبصمة",
          "Delete account": "مسح الحساب",
          "Please use finger": "الرجاء إستخدام بصمه اليد للدخول الي التطبيق",
          "Authenticate": "بدء التحقق",
          "Fingerprint activated successfully": "تم تفعيل الدخول بالبصمة بنجاح",
          "Fingerprint not supported": "عذرا هاتفك لا يدعم الدخول بالبصمة",
          "Please enable fingerprint":
              "الرجاء تفعيل خاصيه البصمة من إعدادات الهاتف",
          //----------------------------------- Services Page -------------------------//
          "Comercial Services": "الخدمات التجاريه",
          "Service Details": "تفاصيل الخدمه",
          "Service price": "سعر الخدمه ",
          "Ticket type": "نوع التذكره :",
          "Total Price": "القيمه الكليه",
          "Remaning Balance": "الرصيد المتبقي",
          "Confirm booking": "تأكيد الحجز",
          "Sorry": "عذرا ,يجب عليك تحديد عدد الأشخاص",
          "message": "عذرا ليس لديك رصيد كافي",
          //----------------------------------- Transaction Page -------------------------//
          "Transactions": "التحويلات",
          "History": "المعاملات السابقة",
          "Latest Transactions": "آخر المعاملات",
          //----------------------------------- News Page -------------------------//
          "News": "الأخبار",
          "News Details": "تفاصيل الخبر",
          //----------------------------------- Ticket Info -------------------------//
          "successfully booked": "لقد تم حجز التذكره بنجاح",
          "Status": "حالة التذكره :",
          "Amount": "القيمة : ",
          "Name": "الإسم : ",
          "family": "عائله",
          "Phone no": "رقم الهاتف : ",
          "Note": "ملاحظة :",
          "Booking Details": "تفاصيل الحجز :",
          "Transferred amount": "المبلغ الذي تم تحويلة",
          "From": "تحويل من :",
          "To": "تحويل الي :",
          "Date": "التاريخ : ",
          "No. of persons": "عدد الأشخاص : ",
          "No. of family": "عدد العائله :",
          "person": " شخص",
          "Service": "مقدم الخدمة :",
          "Type": "النوع :",
          "Package name": "نوع الباقة :",
          "Ticket organizer": "منظم التذكرة :",
          "Ticket quantity": "العدد :",
          "Ticket name": "إسم التذكرة :",
          "No. of Adults": "عدد البالغين :",
          "No. of children's": "عدد الأطفال :",
          "Save your ticket": "حفظ التذكرة",
          "Extra fees": "منصرفات إضافية :",
          "Transaction id": "رقم المعاملة :",
          "Saved successfully": "تم الحفظ بنجاح",
          'SDG': ' جنية',
          //----------------------------------- State Page -------------------------//
          "Successfull": "نجاح",
          "Error": "خطأ",
          "Success": "نجحت العملية",
          "Order canceled": "تم إلغاء عملية الدفع",
          "Order approved": "تمت عملية الدفع تم تغذية المحفظه بنجاح",
          "Transfer approved": "تمت عملية تغذية المحفظه بنجاح",
          "Order decllined": "تم رفض عملية الدفع الرجاء مراجعه بيانات البطاقه",
          "homepage": "الرئيسية",

          //----------------------------------- Contact Page -------------------------//
          "Contact us": "التواصل",
          'Working Hours': 'ساعات العمل',
          'Phone Numbers': 'أرقام الإتصال',
          'Email Address': 'البريد الإلكتروني',
          'Office Location': 'الموقع',
          "--------  Reach us on  --------":
              "--------  تواصل معنا علي   --------",

          //----------------------------------- Other Page -------------------------//
          "Maintenance": "عذرآ التطبيق في وضع الصيانه",
          "No connection":
              "عذرا لايوجد هناك إتصال بالأنترنت ,قم بمراجعه الإتصال وإعاده تشغيل التطبيق",
          "Restart app": "إعاده تشغيل التطبيق",
        }
      };
}
