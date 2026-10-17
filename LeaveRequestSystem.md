# نظام طلب الإجازة - دليل سريع

## نظرة عامة
تم إنشاء نظام طلب الإجازة الكامل الذي يتكامل مع نظام رصيد الإجازة الموجود. النظام يتيح للموظفين تقديم طلبات إجازة وإدارتها من قبل المدراء.

## الملفات المضافة

### 1. الكيانات (Entities)
- LeaveRequest.java - كيان طلب الإجازة
- LeaveRequestDto.java - DTO لإنشاء طلب إجازة
- LeaveRequestApprovalDto.java - DTO لرد الموافقة/الرفض

### 2. طبقة الوصول للبيانات (Data Access)
- LeaveRequestDao.java - واجهة الوصول للبيانات مع استعلامات متقدمة

### 3. طبقة الأعمال (Business)
- LeaveRequestService.java - واجهة الخدمة
- LeaveRequestManager.java - تنفيذ الخدمة مع قواعد الأعمال

### 4. طبقة التحكم (Controller)
- LeaveRequestsController.java - REST API endpoints

### 5. قاعدة البيانات
- LeaveRequestsTable.sql - إنشاء الجدول والـ Views

### 6. التوثيق
- LeaveRequestAPI.md - توثيق شامل للـ API
- LeaveRequestSystem.md - هذا الدليل

## كيفية الاستخدام

### 1. إعداد قاعدة البيانات
sql
-- تشغيل ملف LeaveRequestsTable.sql في قاعدة البيانات
source LeaveRequestsTable.sql;


### 2. تشغيل التطبيق
bash
# في مجلد المشروع
mvn spring-boot:run


### 3. أمثلة الاستخدام

#### إنشاء طلب إجازة جديد
bash
curl -X POST http://localhost:8080/api/leaverequests/add \
  -H "Content-Type: application/json" \
  -d '{
    "employeeId": 1,
    "leaveType": "ANNUAL",
    "startDate": "2024-02-15",
    "endDate": "2024-02-17",
    "requestedDays": 3,
    "reason": "إجازة سنوية للراحة",
    "additionalNotes": "سأكون متاحاً للاتصال في حالات الطوارئ"
  }'


#### جلب طلبات إجازة موظف معين
bash
curl -X GET http://localhost:8080/api/leaverequests/getbyemployeeid/1


#### جلب الطلبات المعلقة (للمدراء)
bash
curl -X GET http://localhost:8080/api/leaverequests/getpendingrequests


#### الموافقة على طلب إجازة
bash
curl -X POST http://localhost:8080/api/leaverequests/approve \
  -H "Content-Type: application/json" \
  -d '{
    "leaveRequestId": 1,
    "approvedBy": 5,
    "status": "APPROVED"
  }'


#### رفض طلب إجازة
bash
curl -X POST http://localhost:8080/api/leaverequests/reject \
  -H "Content-Type: application/json" \
  -d '{
    "leaveRequestId": 1,
    "approvedBy": 5,
    "status": "REJECTED",
    "rejectionReason": "لا يوجد رصيد إجازة كافي"
  }'


## الميزات الرئيسية

### ✅ التحقق من الرصيد
- يتحقق النظام تلقائياً من توفر رصيد إجازة كافي
- يمنع الموافقة على الطلبات إذا كان الرصيد غير كافي

### ✅ منع التداخل
- يمنع إنشاء طلبات إجازة متداخلة لنفس الموظف
- يتحقق من التداخل مع الطلبات المعلقة والمعتمدة

### ✅ إدارة الحالات
- PENDING - معلق (افتراضي)
- APPROVED - معتمد (يخصم من الرصيد تلقائياً)
- REJECTED - مرفوض (مع سبب الرفض)
- CANCELLED - ملغي (من قبل الموظف)

### ✅ أنواع الإجازة
- ANNUAL - إجازة سنوية
- SICK - إجازة مرضية
- EMERGENCY - إجازة طارئة
- MATERNITY - إجازة أمومة
- PATERNITY - إجازة أبوة
- UNPAID - إجازة بدون راتب

### ✅ استعلامات متقدمة
- البحث حسب الموظف، النوع، الحالة، التاريخ
- جلب الطلبات المعلقة للمدراء
- إحصائيات شاملة
- طلبات الإجازة الطارئة والطويلة

### ✅ التحقق من صحة البيانات
- التحقق من صحة التواريخ
- التحقق من عدد الأيام
- التحقق من سبب الإجازة
- التحقق من نوع الإجازة

## التكامل مع نظام رصيد الإجازة

النظام يتكامل بشكل كامل مع نظام رصيد الإجازة الموجود:

1. *التحقق من الرصيد:* قبل إنشاء الطلب
2. *الخصم التلقائي:* عند الموافقة على الطلب
3. *استخدام نفس أنواع الإجازة:* ANNUAL, SICK, EMERGENCY, etc.
4. *نفس السنة المالية:* للتحقق من الرصيد

## API Endpoints الرئيسية

| الطريقة | المسار | الوصف |
|---------|--------|-------|
| POST | /add | إنشاء طلب إجازة جديد |
| PUT | /update/{id} | تحديث طلب إجازة |
| DELETE | /delete/{id} | حذف طلب إجازة |
| GET | /getall | جلب جميع الطلبات |
| GET | /getbyemployeeid/{id} | طلبات موظف معين |
| GET | /getpendingrequests | الطلبات المعلقة |
| POST | /approve | الموافقة على طلب |
| POST | /reject | رفض طلب |
| POST | /cancel/{id} | إلغاء طلب |

## ملاحظات مهمة

1. *الأمان:* يجب إضافة نظام مصادقة وتفويض
2. *الإشعارات:* يمكن إضافة نظام إشعارات للموظفين والمدراء
3. *التقارير:* يمكن إضافة تقارير متقدمة
4. *التواريخ:* النظام يدعم التواريخ في المستقبل فقط
5. *النسخ الاحتياطي:* تأكد من عمل نسخ احتياطي لقاعدة البيانات

## الخطوات التالية

1. *إضافة نظام مصادقة:* JWT أو Session-based
2. *إضافة نظام إشعارات:* Email أو Push notifications
3. *إضافة تقارير متقدمة:* PDF, Excel exports
4. *إضافة واجهة مستخدم:* React, Angular, أو Vue.js
5. *إضافة اختبارات:* Unit tests و Integration tests

## الدعم

للحصول على مساعدة إضافية أو للإبلاغ عن مشاكل، يرجى الرجوع إلى:
- LeaveRequestAPI.md - توثيق API مفصل
- APIDocumentation.md - توثيق API العام للمشروع