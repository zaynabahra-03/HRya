# API توثيق نظام طلب الإجازة

## نظرة عامة
نظام طلب الإجازة يتيح للموظفين تقديم طلبات إجازة وإدارتها من قبل المدراء. النظام يتكامل مع نظام رصيد الإجازة للتحقق من توفر الأيام المطلوبة.

## Base URL

http://localhost:8080/api/leaverequests


## أنواع الإجازة المدعومة
- ANNUAL - إجازة سنوية
- SICK - إجازة مرضية
- EMERGENCY - إجازة طارئة
- MATERNITY - إجازة أمومة
- PATERNITY - إجازة أبوة
- UNPAID - إجازة بدون راتب

## حالات طلب الإجازة
- PENDING - معلق (افتراضي)
- APPROVED - معتمد
- REJECTED - مرفوض
- CANCELLED - ملغي

---

## 1. إضافة طلب إجازة جديد

### POST /add

*الوصف:* إنشاء طلب إجازة جديد

*Request Body:*
json
{
  "employeeId": 1,
  "leaveType": "ANNUAL",
  "startDate": "2024-02-15",
  "endDate": "2024-02-17",
  "requestedDays": 3,
  "reason": "إجازة سنوية للراحة",
  "additionalNotes": "سأكون متاحاً للاتصال في حالات الطوارئ"
}


*Response (Success - 200):*
json
{
  "success": true,
  "message": "تم إرسال طلب الإجازة بنجاح"
}


*Response (Error - 400):*
json
{
  "success": false,
  "message": "رصيد الإجازة غير كافي"
}


---

## 2. تحديث طلب إجازة

### PUT /update/{id}

*الوصف:* تحديث طلب إجازة موجود (فقط إذا كان معلق)

*Request Body:* نفس هيكل إضافة طلب جديد

*Response (Success - 200):*
json
{
  "success": true,
  "message": "تم تحديث طلب الإجازة بنجاح"
}


---

## 3. حذف طلب إجازة

### DELETE /delete/{id}

*الوصف:* حذف طلب إجازة (فقط إذا كان معلق)

*Response (Success - 200):*
json
{
  "success": true,
  "message": "تم حذف طلب الإجازة بنجاح"
}


---

## 4. الحصول على جميع طلبات الإجازة

### GET /getall

*الوصف:* جلب جميع طلبات الإجازة

*Response (Success - 200):*
json
{
  "success": true,
  "message": "جميع طلبات الإجازة تم جلبها بنجاح",
  "data": [
    {
      "id": 1,
      "employeeId": 1,
      "leaveType": "ANNUAL",
      "startDate": "2024-02-15",
      "endDate": "2024-02-17",
      "requestedDays": 3,
      "reason": "إجازة سنوية للراحة",
      "additionalNotes": "سأكون متاحاً للاتصال في حالات الطوارئ",
      "status": "PENDING",
      "approvedBy": null,
      "approvalDate": null,
      "rejectionReason": null,
      "createdAt": "2024-01-10T10:30:00",
      "updatedAt": "2024-01-10T10:30:00"
    }
  ]
}


---

## 5. الحصول على طلب إجازة بواسطة ID

### GET /getbyid/{id}

*الوصف:* جلب طلب إجازة محدد

*Response (Success - 200):*
json
{
  "success": true,
  "message": "طلب الإجازة تم جلبه بنجاح",
  "data": {
    "id": 1,
    "employeeId": 1,
    "leaveType": "ANNUAL",
    "startDate": "2024-02-15",
    "endDate": "2024-02-17",
    "requestedDays": 3,
    "reason": "إجازة سنوية للراحة",
    "status": "PENDING"
  }
}


---

## 6. الحصول على طلبات إجازة موظف معين

### GET /getbyemployeeid/{employeeId}

*الوصف:* جلب جميع طلبات إجازة موظف محدد

*Response (Success - 200):*
json
{
  "success": true,
  "message": "طلبات إجازة الموظف تم جلبها بنجاح",
  "data": [
    {
      "id": 1,
      "employeeId": 1,
      "leaveType": "ANNUAL",
      "startDate": "2024-02-15",
      "endDate": "2024-02-17",
      "requestedDays": 3,
      "reason": "إجازة سنوية للراحة",
      "status": "PENDING"
    }
  ]
}


---

## 7. الحصول على طلبات إجازة بحالة معينة

### GET /getbystatus/{status}

*الوصف:* جلب طلبات إجازة بحالة محددة (PENDING, APPROVED, REJECTED, CANCELLED)

*Response (Success - 200):*
json
{
  "success": true,
  "message": "طلبات الإجازة بالحالة المحددة تم جلبها بنجاح",
  "data": [
    {
      "id": 1,
      "employeeId": 1,
      "leaveType": "ANNUAL",
      "status": "PENDING"
    }
  ]
}


---

## 8. الحصول على طلبات إجازة موظف معين بحالة معينة

### GET /getbyemployeeidandstatus?employeeId=1&status=PENDING

*الوصف:* جلب طلبات إجازة موظف محدد بحالة محددة

---

## 9. الحصول على طلبات إجازة في فترة زمنية

### GET /getbydaterange?startDate=2024-02-01&endDate=2024-02-28

*الوصف:* جلب طلبات إجازة في فترة زمنية محددة

---

## 10. الحصول على طلبات إجازة معلقة

### GET /getpendingrequests

*الوصف:* جلب جميع طلبات الإجازة المعلقة (للمدراء)

*Response (Success - 200):*
json
{
  "success": true,
  "message": "طلبات الإجازة المعلقة تم جلبها بنجاح",
  "data": [
    {
      "id": 1,
      "employeeId": 1,
      "leaveType": "ANNUAL",
      "startDate": "2024-02-15",
      "endDate": "2024-02-17",
      "requestedDays": 3,
      "reason": "إجازة سنوية للراحة",
      "status": "PENDING",
      "createdAt": "2024-01-10T10:30:00"
    }
  ]
}


---

## 11. الموافقة على طلب إجازة

### POST /approve

*الوصف:* الموافقة على طلب إجازة (للمدراء)

*Request Body:*
json
{
  "leaveRequestId": 1,
  "approvedBy": 5,
  "status": "APPROVED"
}


*Response (Success - 200):*
json
{
  "success": true,
  "message": "تم الموافقة على طلب الإجازة بنجاح"
}


---

## 12. رفض طلب إجازة

### POST /reject

*الوصف:* رفض طلب إجازة (للمدراء)

*Request Body:*
json
{
  "leaveRequestId": 1,
  "approvedBy": 5,
  "status": "REJECTED",
  "rejectionReason": "لا يوجد رصيد إجازة كافي"
}


*Response (Success - 200):*
json
{
  "success": true,
  "message": "تم رفض طلب الإجازة بنجاح"
}


---

## 13. إلغاء طلب إجازة

### POST /cancel/{leaveRequestId}?employeeId=1

*الوصف:* إلغاء طلب إجازة (للموظف صاحب الطلب)

*Response (Success - 200):*
json
{
  "success": true,
  "message": "تم إلغاء طلب الإجازة بنجاح"
}


---

## 14. التحقق من تداخل طلبات الإجازة

### GET /checkoverlapping?employeeId=1&startDate=2024-02-15&endDate=2024-02-17

*الوصف:* التحقق من وجود طلبات إجازة متداخلة مع الفترة المحددة

*Response (Success - 200):*
json
{
  "success": true,
  "message": "تم التحقق من تداخل طلبات الإجازة",
  "data": false
}


---

## 15. الحصول على إجمالي أيام الإجازة المعتمدة

### GET /gettotalapproveddays?employeeId=1&year=2024

*الوصف:* حساب إجمالي أيام الإجازة المعتمدة لموظف معين في سنة معينة

*Response (Success - 200):*
json
{
  "success": true,
  "message": "إجمالي أيام الإجازة المعتمدة تم حسابه بنجاح",
  "data": 15
}


---

## 16. الحصول على طلبات إجازة طويلة

### GET /getlongleaverequests

*الوصف:* جلب طلبات الإجازة التي تزيد عن 5 أيام

---

## 17. الحصول على طلبات إجازة طارئة

### GET /getemergencyleaverequests

*الوصف:* جلب جميع طلبات الإجازة الطارئة

---

## 18. الحصول على طلبات إجازة الشهر الحالي

### GET /getcurrentmonthrequests

*الوصف:* جلب طلبات الإجازة في الشهر الحالي

---

## 19. الحصول على طلبات إجازة الشهر القادم

### GET /getnextmonthrequests

*الوصف:* جلب طلبات الإجازة في الشهر القادم

---

## 20. التحقق من توفر رصيد إجازة كافي

### GET /checksufficientbalance?employeeId=1&leaveType=ANNUAL&days=5&year=2024

*الوصف:* التحقق من توفر رصيد إجازة كافي للموظف

*Response (Success - 200):*
json
{
  "success": true,
  "message": "تم التحقق من رصيد الإجازة",
  "data": true
}


---

## 21. الحصول على إحصائيات طلبات الإجازة

### GET /getstatistics/{year}

*الوصف:* جلب إحصائيات شاملة لطلبات الإجازة في سنة معينة

*Response (Success - 200):*
json
{
  "success": true,
  "message": "إحصائيات طلبات الإجازة تم جلبها بنجاح",
  "data": {
    "totalRequests": 50,
    "pendingRequests": 10,
    "approvedRequests": 30,
    "rejectedRequests": 5,
    "cancelledRequests": 5,
    "emergencyRequests": 3,
    "longRequests": 8
  }
}


---

## أمثلة استخدام

### مثال 1: إنشاء طلب إجازة سنوية
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


### مثال 2: الموافقة على طلب إجازة
bash
curl -X POST http://localhost:8080/api/leaverequests/approve \
  -H "Content-Type: application/json" \
  -d '{
    "leaveRequestId": 1,
    "approvedBy": 5,
    "status": "APPROVED"
  }'


### مثال 3: جلب طلبات إجازة موظف معين
bash
curl -X GET http://localhost:8080/api/leaverequests/getbyemployeeid/1


### مثال 4: جلب الطلبات المعلقة
bash
curl -X GET http://localhost:8080/api/leaverequests/getpendingrequests


---

## رموز الخطأ الشائعة

| الكود | المعنى |
|-------|--------|
| 400 | بيانات غير صحيحة أو رصيد غير كافي |
| 404 | طلب الإجازة غير موجود |
| 500 | خطأ في الخادم |

## ملاحظات مهمة

1. *التحقق من الرصيد:* النظام يتحقق تلقائياً من توفر رصيد إجازة كافي قبل الموافقة
2. *منع التداخل:* لا يمكن إنشاء طلبات إجازة متداخلة لنفس الموظف
3. *التحديث والحذف:* يمكن فقط تحديث أو حذف الطلبات المعلقة
4. *الخصم التلقائي:* عند الموافقة على الطلب، يتم خصم الأيام تلقائياً من رصيد الإجازة
5. *التواريخ:* يجب أن تكون تواريخ الإجازة في المستقبل أو اليوم الحالي