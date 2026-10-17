-- بيانات تجريبية لنظام موافقة المدير على طلبات الإجازة

-- إضافة مدراء تجريبيين
INSERT INTO users (id, email, password, active, deleted, created_at) VALUES
(101, 'manager1@company.com', 'password123', true, false, NOW()),
(102, 'manager2@company.com', 'password123', true, false, NOW()),
(103, 'manager3@company.com', 'password123', true, false, NOW());

INSERT INTO company_staffs (user_id, first_name, last_name) VALUES
(101, 'أحمد', 'محمد'),
(102, 'فاطمة', 'علي'),
(103, 'محمد', 'حسن');

-- إضافة موظفين تجريبيين
INSERT INTO users (id, email, password, active, deleted, created_at) VALUES
(201, 'employee1@company.com', 'password123', true, false, NOW()),
(202, 'employee2@company.com', 'password123', true, false, NOW()),
(203, 'employee3@company.com', 'password123', true, false, NOW()),
(204, 'employee4@company.com', 'password123', true, false, NOW()),
(205, 'employee5@company.com', 'password123', true, false, NOW());

-- إضافة أرصدة إجازة للموظفين
INSERT INTO leave_balances (employee_id, leave_type, total_days, used_days, remaining_days, year, created_at, updated_at) VALUES
-- الموظف 201
(201, 'ANNUAL', 30, 5, 25, 2024, NOW(), NOW()),
(201, 'SICK', 10, 2, 8, 2024, NOW(), NOW()),
(201, 'EMERGENCY', 5, 0, 5, 2024, NOW(), NOW()),

-- الموظف 202
(202, 'ANNUAL', 30, 15, 15, 2024, NOW(), NOW()),
(202, 'SICK', 10, 3, 7, 2024, NOW(), NOW()),
(202, 'EMERGENCY', 5, 1, 4, 2024, NOW(), NOW()),

-- الموظف 203
(203, 'ANNUAL', 30, 0, 30, 2024, NOW(), NOW()),
(203, 'SICK', 10, 0, 10, 2024, NOW(), NOW()),
(203, 'EMERGENCY', 5, 0, 5, 2024, NOW(), NOW()),

-- الموظف 204
(204, 'ANNUAL', 30, 25, 5, 2024, NOW(), NOW()),
(204, 'SICK', 10, 8, 2, 2024, NOW(), NOW()),
(204, 'EMERGENCY', 5, 2, 3, 2024, NOW(), NOW()),

-- الموظف 205
(205, 'ANNUAL', 30, 10, 20, 2024, NOW(), NOW()),
(205, 'SICK', 10, 1, 9, 2024, NOW(), NOW()),
(205, 'EMERGENCY', 5, 0, 5, 2024, NOW(), NOW());

-- إضافة طلبات إجازة تجريبية
INSERT INTO leave_requests (employee_id, leave_type, start_date, end_date, requested_days, reason, additional_notes, status, approved_by, approval_date, rejection_reason, created_at, updated_at) VALUES
-- طلبات معلقة
(201, 'ANNUAL', '2024-02-15', '2024-02-20', 6, 'رحلة عائلية', 'سأكون متاحاً للاتصال في حالات الطوارئ', 'PENDING', NULL, NULL, NULL, NOW(), NOW()),
(202, 'SICK', '2024-02-10', '2024-02-12', 3, 'مرض شديد', 'لدي تقرير طبي', 'PENDING', NULL, NULL, NULL, NOW(), NOW()),
(203, 'EMERGENCY', '2024-02-08', '2024-02-08', 1, 'حالة طارئة عائلية', 'مطلوب عاجلاً', 'PENDING', NULL, NULL, NULL, NOW(), NOW()),

-- طلبات معتمدة
(204, 'ANNUAL', '2024-01-20', '2024-01-25', 6, 'إجازة سنوية', 'تم التخطيط مسبقاً', 'APPROVED', 101, NOW(), NULL, '2024-01-15 10:00:00', NOW()),
(205, 'SICK', '2024-01-18', '2024-01-19', 2, 'مرض خفيف', 'سأعود للعمل فور الشفاء', 'APPROVED', 102, NOW(), NULL, '2024-01-17 14:30:00', NOW()),
(201, 'EMERGENCY', '2024-01-12', '2024-01-12', 1, 'حالة طارئة', 'مطلوب عاجلاً', 'APPROVED', 103, NOW(), NULL, '2024-01-12 08:00:00', NOW()),

-- طلبات مرفوضة
(202, 'ANNUAL', '2024-01-30', '2024-02-10', 12, 'رحلة طويلة', 'رحلة سياحية', 'REJECTED', 101, NOW(), 'فترة طويلة جداً، يرجى تقليل المدة', '2024-01-25 11:20:00', NOW()),
(203, 'SICK', '2024-01-22', '2024-01-26', 5, 'مرض', 'بدون تقرير طبي', 'REJECTED', 102, NOW(), 'مطلوب تقرير طبي موثق', '2024-01-20 16:45:00', NOW()),

-- طلبات ملغاة
(204, 'ANNUAL', '2024-02-01', '2024-02-03', 3, 'إجازة قصيرة', 'تم إلغاؤها', 'CANCELLED', NULL, NULL, NULL, '2024-01-28 09:15:00', NOW()),

-- طلبات إجازة طويلة
(205, 'ANNUAL', '2024-03-01', '2024-03-15', 15, 'رحلة خارجية', 'رحلة عائلية طويلة', 'PENDING', NULL, NULL, NULL, NOW(), NOW()),
(201, 'MATERNITY', '2024-04-01', '2024-07-01', 92, 'إجازة أمومة', 'حمل متقدم', 'PENDING', NULL, NULL, NULL, NOW(), NOW()),

-- طلبات إجازة طارئة
(202, 'EMERGENCY', '2024-02-05', '2024-02-05', 1, 'حالة طارئة عائلية', 'مطلوب عاجلاً جداً', 'PENDING', NULL, NULL, NULL, NOW(), NOW()),
(203, 'EMERGENCY', '2024-02-06', '2024-02-07', 2, 'حالة صحية طارئة', 'مطلوب فحص طبي عاجل', 'PENDING', NULL, NULL, NULL, NOW(), NOW());

-- إضافة طلبات إجازة إضافية للاختبار
INSERT INTO leave_requests (employee_id, leave_type, start_date, end_date, requested_days, reason, additional_notes, status, approved_by, approval_date, rejection_reason, created_at, updated_at) VALUES
-- طلبات متنوعة
(201, 'PATERNITY', '2024-03-10', '2024-03-20', 11, 'إجازة أبوة', 'مولود جديد', 'PENDING', NULL, NULL, NULL, NOW(), NOW()),
(202, 'UNPAID', '2024-02-25', '2024-02-28', 4, 'أمور شخصية', 'أمور عائلية مهمة', 'PENDING', NULL, NULL, NULL, NOW(), NOW()),
(203, 'ANNUAL', '2024-02-18', '2024-02-22', 5, 'راحة واستجمام', 'مطلوب راحة من العمل', 'PENDING', NULL, NULL, NULL, NOW(), NOW()),
(204, 'SICK', '2024-02-12', '2024-02-14', 3, 'مرض', 'لدي تقرير طبي', 'PENDING', NULL, NULL, NULL, NOW(), NOW()),
(205, 'EMERGENCY', '2024-02-09', '2024-02-09', 1, 'حالة طارئة', 'مطلوب عاجلاً', 'PENDING', NULL, NULL, NULL, NOW(), NOW());

-- إضافة طلبات إجازة معتمدة سابقاً
INSERT INTO leave_requests (employee_id, leave_type, start_date, end_date, requested_days, reason, additional_notes, status, approved_by, approval_date, rejection_reason, created_at, updated_at) VALUES
(201, 'ANNUAL', '2024-01-05', '2024-01-10', 6, 'إجازة سنوية', 'تم التخطيط مسبقاً', 'APPROVED', 101, '2024-01-03 10:00:00', NULL, '2024-01-01 09:00:00', '2024-01-03 10:00:00'),
(202, 'SICK', '2024-01-08', '2024-01-09', 2, 'مرض', 'لدي تقرير طبي', 'APPROVED', 102, '2024-01-07 14:30:00', NULL, '2024-01-06 11:00:00', '2024-01-07 14:30:00'),
(203, 'EMERGENCY', '2024-01-15', '2024-01-15', 1, 'حالة طارئة', 'مطلوب عاجلاً', 'APPROVED', 103, '2024-01-15 08:00:00', NULL, '2024-01-15 07:30:00', '2024-01-15 08:00:00'),
(204, 'ANNUAL', '2024-01-12', '2024-01-15', 4, 'إجازة قصيرة', 'أمور عائلية', 'APPROVED', 101, '2024-01-10 16:00:00', NULL, '2024-01-08 13:00:00', '2024-01-10 16:00:00'),
(205, 'SICK', '2024-01-20', '2024-01-22', 3, 'مرض', 'لدي تقرير طبي', 'APPROVED', 102, '2024-01-19 12:00:00', NULL, '2024-01-18 10:00:00', '2024-01-19 12:00:00');

-- إضافة طلبات إجازة مرفوضة سابقاً
INSERT INTO leave_requests (employee_id, leave_type, start_date, end_date, requested_days, reason, additional_notes, status, approved_by, approval_date, rejection_reason, created_at, updated_at) VALUES
(201, 'ANNUAL', '2024-01-25', '2024-02-05', 12, 'رحلة طويلة', 'رحلة سياحية', 'REJECTED', 101, '2024-01-23 11:20:00', 'فترة طويلة جداً، يرجى تقليل المدة', '2024-01-20 09:00:00', '2024-01-23 11:20:00'),
(202, 'SICK', '2024-01-28', '2024-02-02', 6, 'مرض', 'بدون تقرير طبي', 'REJECTED', 102, '2024-01-26 16:45:00', 'مطلوب تقرير طبي موثق', '2024-01-25 14:00:00', '2024-01-26 16:45:00'),
(203, 'EMERGENCY', '2024-01-30', '2024-02-01', 3, 'حالة طارئة', 'غير عاجلة', 'REJECTED', 103, '2024-01-29 10:30:00', 'الحالة غير عاجلة، يمكن تأجيلها', '2024-01-28 15:00:00', '2024-01-29 10:30:00');

-- إضافة طلبات إجازة ملغاة
INSERT INTO leave_requests (employee_id, leave_type, start_date, end_date, requested_days, reason, additional_notes, status, approved_by, approval_date, rejection_reason, created_at, updated_at) VALUES
(204, 'ANNUAL', '2024-01-18', '2024-01-20', 3, 'إجازة قصيرة', 'تم إلغاؤها', 'CANCELLED', NULL, NULL, NULL, '2024-01-15 11:00:00', '2024-01-16 14:00:00'),
(205, 'SICK', '2024-01-22', '2024-01-23', 2, 'مرض', 'تم إلغاؤها', 'CANCELLED', NULL, NULL, NULL, '2024-01-20 16:00:00', '2024-01-21 09:00:00');

-- إضافة طلبات إجازة للشهر القادم
INSERT INTO leave_requests (employee_id, leave_type, start_date, end_date, requested_days, reason, additional_notes, status, approved_by, approval_date, rejection_reason, created_at, updated_at) VALUES
(201, 'ANNUAL', '2024-03-05', '2024-03-10', 6, 'رحلة عائلية', 'مخطط مسبقاً', 'PENDING', NULL, NULL, NULL, NOW(), NOW()),
(202, 'SICK', '2024-03-12', '2024-03-14', 3, 'موعد طبي', 'موعد طبي مهم', 'PENDING', NULL, NULL, NULL, NOW(), NOW()),
(203, 'EMERGENCY', '2024-03-08', '2024-03-08', 1, 'حالة طارئة', 'مطلوب عاجلاً', 'PENDING', NULL, NULL, NULL, NOW(), NOW()),
(204, 'ANNUAL', '2024-03-20', '2024-03-25', 6, 'إجازة سنوية', 'راحة واستجمام', 'PENDING', NULL, NULL, NULL, NOW(), NOW()),
(205, 'PATERNITY', '2024-03-15', '2024-03-25', 11, 'إجازة أبوة', 'مولود جديد', 'PENDING', NULL, NULL, NULL, NOW(), NOW());

-- إضافة طلبات إجازة للشهر الحالي
INSERT INTO leave_requests (employee_id, leave_type, start_date, end_date, requested_days, reason, additional_notes, status, approved_by, approval_date, rejection_reason, created_at, updated_at) VALUES
(201, 'ANNUAL', '2024-02-25', '2024-02-28', 4, 'إجازة قصيرة', 'أمور عائلية', 'PENDING', NULL, NULL, NULL, NOW(), NOW()),
(202, 'SICK', '2024-02-20', '2024-02-21', 2, 'مرض', 'لدي تقرير طبي', 'PENDING', NULL, NULL, NULL, NOW(), NOW()),
(203, 'EMERGENCY', '2024-02-22', '2024-02-22', 1, 'حالة طارئة', 'مطلوب عاجلاً', 'PENDING', NULL, NULL, NULL, NOW(), NOW()),
(204, 'ANNUAL', '2024-02-28', '2024-03-02', 5, 'رحلة عائلية', 'مخطط مسبقاً', 'PENDING', NULL, NULL, NULL, NOW(), NOW()),
(205, 'SICK', '2024-02-24', '2024-02-26', 3, 'مرض', 'لدي تقرير طبي', 'PENDING', NULL, NULL, NULL, NOW(), NOW());

-- عرض البيانات المضافة
SELECT 'تم إضافة البيانات التجريبية بنجاح' AS message;

-- عرض إحصائيات سريعة
SELECT 
    'إجمالي الطلبات' AS statistic,
    COUNT(*) AS count
FROM leave_requests
UNION ALL
SELECT 
    'الطلبات المعلقة',
    COUNT(*)
FROM leave_requests
WHERE status = 'PENDING'
UNION ALL
SELECT 
    'الطلبات المعتمدة',
    COUNT(*)
FROM leave_requests
WHERE status = 'APPROVED'
UNION ALL
SELECT 
    'الطلبات المرفوضة',
    COUNT(*)
FROM leave_requests
WHERE status = 'REJECTED'
UNION ALL
SELECT 
    'الطلبات الملغاة',
    COUNT(*)
FROM leave_requests
WHERE status = 'CANCELLED';

-- عرض الطلبات المعلقة
SELECT 
    lr.id,
    lr.employee_id,
    lr.leave_type,
    lr.start_date,
    lr.end_date,
    lr.requested_days,
    lr.reason,
    lr.status,
    lr.created_at
FROM leave_requests lr
WHERE lr.status = 'PENDING'
ORDER BY lr.created_at ASC;