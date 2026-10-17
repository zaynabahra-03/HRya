# نظام إدارة سياسات المنظمة (Organization Policy Management System)

## نظرة عامة
نظام إدارة سياسات المنظمة هو جزء من نظام إدارة الموارد البشرية (HRMS) الذي يتيح إدارة وتنظيم السياسات المختلفة في المؤسسة. يتضمن النظام خمسة أنواع رئيسية من السياسات:

### أنواع السياسات المدعومة:
1. **سياسات الإجازات (Leave Policies)** - سياسات الإجازات السنوية والمرضية
2. **سياسات التوظيف (Employment Policies)** - سياسات التوظيف والاختيار
3. **سياسات الرواتب (Salary Policies)** - سياسات الرواتب والمكافآت
4. **سياسات الأداء (Performance Policies)** - سياسات تقييم الأداء
5. **سياسات الانضباط (Discipline Policies)** - سياسات الانضباط والعقوبات

## المميزات الرئيسية

### 1. إدارة السياسات
- إنشاء سياسات جديدة
- تعديل السياسات الموجودة
- حذف السياسات
- تفعيل/إلغاء تفعيل السياسات
- الموافقة على السياسات
- انتهاء صلاحية السياسات

### 2. تتبع الإصدارات
- نظام إصدارات للسياسات
- تتبع التغييرات والتحديثات
- تاريخ الإنشاء والتعديل

### 3. إدارة الصلاحية
- تاريخ بدء السريان
- تاريخ انتهاء الصلاحية
- السياسات النشطة حالياً

### 4. البحث والتصفية
- البحث بالكلمات المفتاحية
- التصفية حسب نوع السياسة
- عرض السياسات النشطة فقط

## البنية التقنية

### الملفات المطلوبة:

#### 1. Policy.java - كيان السياسات
```java
@Entity
@Table(name = "policies")
public class Policy {
    private int id;
    private String title;
    private String description;
    private String policyType;
    private String content;
    private int version;
    private boolean isActive;
    private LocalDateTime effectiveDate;
    private LocalDateTime expiryDate;
    // ... المزيد من الحقول
}
```

#### 2. PolicyDao.java - وصول البيانات
```java
public interface PolicyDao extends JpaRepository<Policy, Integer> {
    List<Policy> findByPolicyType(String policyType);
    List<Policy> findByIsActiveTrue();
    List<Policy> findByKeyword(String keyword);
    // ... المزيد من الطرق
}
```

#### 3. PolicyService.java - منطق الأعمال
```java
public interface PolicyService {
    DataResult<List<Policy>> getAll();
    DataResult<Policy> getById(int id);
    Result add(PolicyDto policyDto);
    Result update(int id, PolicyDto policyDto);
    // ... المزيد من الطرق
}
```

#### 4. PolicyController.java - واجهة API
```java
@RestController
@RequestMapping("/api/policies")
public class PolicyController {
    @GetMapping("/getall")
    @PostMapping("/add")
    @PutMapping("/update/{id}")
    // ... المزيد من النقاط النهائية
}
```

#### 5. PolicyDto.java - نقل البيانات
```java
public class PolicyDto {
    private String title;
    private String description;
    private String policyType;
    private String content;
    private LocalDateTime effectiveDate;
    // ... المزيد من الحقول
}
```

## قاعدة البيانات

### جدول السياسات (policies)
```sql
CREATE TABLE policies (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    description VARCHAR(500) NOT NULL,
    policy_type VARCHAR(50) NOT NULL,
    content TEXT NOT NULL,
    version INTEGER NOT NULL DEFAULT 1,
    is_active BOOLEAN NOT NULL DEFAULT true,
    effective_date TIMESTAMP NOT NULL,
    expiry_date TIMESTAMP,
    created_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_date TIMESTAMP,
    created_by VARCHAR(100),
    approved_by VARCHAR(100),
    approval_date TIMESTAMP
);
```

### الفهارس (Indexes)
```sql
CREATE INDEX idx_policies_policy_type ON policies(policy_type);
CREATE INDEX idx_policies_is_active ON policies(is_active);
CREATE INDEX idx_policies_effective_date ON policies(effective_date);
CREATE INDEX idx_policies_title_type ON policies(title, policy_type);
```

### المشاهد (Views)
```sql
-- السياسات النشطة حالياً
CREATE VIEW currently_active_policies AS
SELECT * FROM policies 
WHERE is_active = true 
AND effective_date <= CURRENT_TIMESTAMP 
AND (expiry_date IS NULL OR expiry_date > CURRENT_TIMESTAMP);

-- إحصائيات السياسات حسب النوع
CREATE VIEW policies_by_type AS
SELECT policy_type, COUNT(*) as policy_count, 
       COUNT(CASE WHEN is_active = true THEN 1 END) as active_count
FROM policies 
GROUP BY policy_type;
```

## API Endpoints

### العمليات الأساسية
- `GET /api/policies/getall` - عرض جميع السياسات
- `GET /api/policies/getbyid/{id}` - عرض سياسة محددة
- `POST /api/policies/add` - إضافة سياسة جديدة
- `PUT /api/policies/update/{id}` - تحديث سياسة
- `DELETE /api/policies/delete/{id}` - حذف سياسة

### العمليات المتقدمة
- `GET /api/policies/getbytype/{policyType}` - عرض سياسات حسب النوع
- `GET /api/policies/getactive` - عرض السياسات النشطة
- `GET /api/policies/search?keyword={keyword}` - البحث في السياسات
- `PUT /api/policies/activate/{id}` - تفعيل سياسة
- `PUT /api/policies/deactivate/{id}` - إلغاء تفعيل سياسة
- `PUT /api/policies/approve/{id}?approvedBy={approvedBy}` - الموافقة على سياسة

### نقاط النهاية الخاصة
- `GET /api/policies/leave-policies` - سياسات الإجازات
- `GET /api/policies/employment-policies` - سياسات التوظيف
- `GET /api/policies/salary-policies` - سياسات الرواتب
- `GET /api/policies/performance-policies` - سياسات الأداء
- `GET /api/policies/discipline-policies` - سياسات الانضباط

## أمثلة الاستخدام

### إنشاء سياسة إجازات جديدة
```json
POST /api/policies/add
{
  "title": "سياسة الإجازات المرضية",
  "description": "سياسة الإجازات المرضية للموظفين",
  "policyType": "LEAVE",
  "content": "1. يحق للموظف إجازة مرضية مدفوعة الأجر لمدة 30 يوم...",
  "effectiveDate": "2024-01-01T00:00:00",
  "createdBy": "admin"
}
```

### البحث في السياسات
```bash
GET /api/policies/search?keyword=إجازة
```

### عرض سياسات الإجازات النشطة
```bash
GET /api/policies/getactivebytype/LEAVE
```

## قواعد الأعمال (Business Rules)

### 1. التحقق من صحة البيانات
- يجب أن يكون عنوان السياسة فريداً لكل نوع
- تاريخ بدء السريان لا يمكن أن يكون في الماضي
- يجب أن يكون المحتوى غير فارغ

### 2. إدارة الإصدارات
- عند تحديث السياسة، يتم زيادة رقم الإصدار تلقائياً
- يتم الاحتفاظ بتاريخ التعديل

### 3. إدارة الصلاحية
- السياسات النشطة فقط هي التي تكون سارية المفعول
- يمكن تحديد تاريخ انتهاء الصلاحية اختيارياً

### 4. الموافقة على السياسات
- يمكن تحديد من قام بالموافقة على السياسة
- يتم تسجيل تاريخ الموافقة

## الأمان والصلاحيات

### التحقق من الصلاحيات
- يجب التحقق من صلاحيات المستخدم قبل العمليات الحساسة
- تسجيل من قام بإنشاء أو تعديل السياسة

### التحقق من صحة البيانات
- التحقق من صحة البيانات المدخلة
- منع إدخال بيانات غير صحيحة

## التطوير المستقبلي

### الميزات المقترحة
1. **نظام الإشعارات** - إشعار الموظفين بالتغييرات في السياسات
2. **نظام الموافقات المتعدد** - موافقة متعددة المستويات
3. **نظام النسخ الاحتياطي** - نسخ احتياطي للسياسات
4. **نظام التقارير** - تقارير مفصلة عن السياسات
5. **واجهة مستخدم** - واجهة مستخدم رسومية لإدارة السياسات

### التحسينات التقنية
1. **التخزين المؤقت** - تحسين الأداء باستخدام التخزين المؤقت
2. **البحث المتقدم** - بحث متقدم مع فلاتر متعددة
3. **API Documentation** - توثيق تفصيلي للـ API
4. **Unit Tests** - اختبارات وحدة شاملة

## الدعم والمساعدة

### التوثيق
- [PolicyAPI.md](PolicyAPI.md) - توثيق تفصيلي للـ API
- [PolicyTable.sql](PolicyTable.sql) - ملف إنشاء قاعدة البيانات

### الاتصال
للمساعدة والدعم التقني، يرجى التواصل مع فريق التطوير.

---

**ملاحظة**: هذا النظام جزء من نظام إدارة الموارد البشرية الشامل (HRMS) ويتم تطويره باستخدام Spring Boot و Java. 