# دليل البدء السريع - نظام موافقة المدير

## 🚀 تشغيل النظام

### 1. تشغيل التطبيق
bash
cd hrms-project-backend-master
mvn spring-boot:run


### 2. إضافة البيانات التجريبية
sql
-- تشغيل ملف البيانات التجريبية
source ManagerApprovalData.sql


### 3. فتح لوحة تحكم المدير
افتح الملف ManagerApprovalDashboard.html في المتصفح

## 📊 البيانات التجريبية

### المدراء
- *المدير 1*: manager1@company.com (ID: 101)
- *المدير 2*: manager2@company.com (ID: 102)  
- *المدير 3*: manager3@company.com (ID: 103)

### الموظفين
- *الموظف 1*: employee1@company.com (ID: 201)
- *الموظف 2*: employee2@company.com (ID: 202)
- *الموظف 3*: employee3@company.com (ID: 203)
- *الموظف 4*: employee4@company.com (ID: 204)
- *الموظف 5*: employee5@company.com (ID: 205)

## 🎯 الميزات الرئيسية

### 1. عرض الطلبات
- جميع الطلبات
- الطلبات المعلقة
- الطلبات المعتمدة
- الطلبات المرفوضة
- الطلبات العاجلة

### 2. إجراءات المدير
- ✅ موافقة سريعة
- ❌ رفض مع سبب
- ⏸ تعليق لطلب معلومات
- 📝 إضافة ملاحظات

### 3. الإحصائيات
- إحصائيات فورية
- تقارير مفصلة
- إحصائيات حسب النوع والحالة

## 🔧 API Endpoints

### الحصول على الطلبات

GET /api/manager-approval/all/{managerId}
GET /api/manager-approval/pending/{managerId}
GET /api/manager-approval/status/{status}/{managerId}


### إجراءات الموافقة

POST /api/manager-approval/approve
POST /api/manager-approval/reject
POST /api/manager-approval/pending


### الإحصائيات

GET /api/manager-approval/statistics/{managerId}/{year}
GET /api/manager-approval/report/{managerId}


## 📝 أمثلة الاستخدام

### الموافقة على طلب
json
POST /api/manager-approval/approve
{
    "leaveRequestId": 1,
    "managerId": 101,
    "action": "APPROVE",
    "managerNotes": "موافقة على طلب الإجازة"
}


### رفض طلب
json
POST /api/manager-approval/reject
{
    "leaveRequestId": 1,
    "managerId": 101,
    "action": "REJECT",
    "rejectionReason": "عدم توفر رصيد إجازة كافي",
    "managerNotes": "يرجى مراجعة رصيد الإجازة"
}


## 🎨 واجهة المستخدم

### الميزات
- تصميم حديث وجذاب
- تجاوب كامل مع جميع الأجهزة
- ألوان وأيقونات معبرة
- تجربة مستخدم سلسة

### الألوان
- 🔵 أزرق أساسي: #3498db
- 🟢 أخضر للنجاح: #27ae60
- 🔴 أحمر للخطأ: #e74c3c
- 🟠 برتقالي للتحذير: #f39c12

## 📁 الملفات المهمة

### Backend
- ManagerApprovalDto.java - DTO لموافقة المدير
- LeaveRequestForManagerDto.java - DTO لعرض الطلبات
- ManagerApprovalService.java - واجهة الخدمة
- ManagerApprovalManager.java - تنفيذ الخدمة
- ManagerApprovalController.java - REST API

### Frontend
- ManagerApprovalDashboard.html - لوحة تحكم المدير

### البيانات
- ManagerApprovalData.sql - البيانات التجريبية
- ManagerApprovalSystem.md - التوثيق الكامل

## 🚨 استكشاف الأخطاء

### مشاكل شائعة
1. *التطبيق لا يعمل*: تأكد من تشغيل قاعدة البيانات
2. *لا تظهر البيانات*: تأكد من تشغيل ملف البيانات التجريبية
3. *خطأ في الاتصال*: تأكد من أن التطبيق يعمل على المنفذ 8080

### سجلات التطبيق
bash
# عرض سجلات التطبيق
tail -f logs/application.log


## 📞 الدعم

- 📧 البريد الإلكتروني: support@company.com
- 📖 التوثيق الكامل: ManagerApprovalSystem.md
- 🐛 تقارير الأخطاء: bugs@company.com

## ✨ الميزات القادمة

- [ ] نظام تنبيهات متقدم
- [ ] تقارير PDF
- [ ] نظام توقيع إلكتروني
- [ ] تفويض الصلاحيات
- [ ] تطبيق موبايل

---

*النظام جاهز للاستخدام! 🎉*