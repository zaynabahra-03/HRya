-- إنشاء جدول طلبات الإجازة
CREATE TABLE leave_requests (
    id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT NOT NULL,
    leave_type VARCHAR(50) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    requested_days INT NOT NULL,
    reason VARCHAR(500) NOT NULL,
    additional_notes TEXT,
    status VARCHAR(20) NOT NULL DEFAULT 'PENDING',
    approved_by INT,
    approval_date DATETIME,
    rejection_reason VARCHAR(500),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    -- فهارس لتحسين الأداء
    INDEX idx_employee_id (employee_id),
    INDEX idx_status (status),
    INDEX idx_leave_type (leave_type),
    INDEX idx_start_date (start_date),
    INDEX idx_end_date (end_date),
    INDEX idx_approved_by (approved_by),
    INDEX idx_created_at (created_at),
    
    -- فهارس مركبة
    INDEX idx_employee_status (employee_id, status),
    INDEX idx_employee_type (employee_id, leave_type),
    INDEX idx_date_range (start_date, end_date),
    
    -- قيود التحقق
    CHECK (requested_days > 0 AND requested_days <= 365),
    CHECK (start_date <= end_date),
    CHECK (status IN ('PENDING', 'APPROVED', 'REJECTED', 'CANCELLED')),
    CHECK (leave_type IN ('ANNUAL', 'SICK', 'EMERGENCY', 'MATERNITY', 'PATERNITY', 'UNPAID'))
);

-- إضافة قيود المفاتيح الأجنبية (إذا كان لديك جدول موظفين)
-- ALTER TABLE leave_requests ADD CONSTRAINT fk_leave_requests_employee 
--     FOREIGN KEY (employee_id) REFERENCES employees(id) ON DELETE CASCADE;

-- ALTER TABLE leave_requests ADD CONSTRAINT fk_leave_requests_approved_by 
--     FOREIGN KEY (approved_by) REFERENCES employees(id) ON DELETE SET NULL;

-- إدراج بيانات تجريبية
INSERT INTO leave_requests (employee_id, leave_type, start_date, end_date, requested_days, reason, additional_notes, status) VALUES
(1, 'ANNUAL', '2024-01-15', '2024-01-17', 3, 'إجازة سنوية للراحة', 'سأكون متاحاً للاتصال في حالات الطوارئ', 'PENDING'),
(2, 'SICK', '2024-01-20', '2024-01-20', 1, 'مرض مفاجئ', 'لدي تقرير طبي', 'APPROVED'),
(3, 'EMERGENCY', '2024-01-25', '2024-01-25', 1, 'حالة طارئة عائلية', 'مطلوب عاجلاً', 'PENDING'),
(1, 'ANNUAL', '2024-02-10', '2024-02-14', 5, 'إجازة سنوية للسفر', 'سأكون خارج المدينة', 'PENDING'),
(4, 'MATERNITY', '2024-03-01', '2024-05-01', 62, 'إجازة أمومة', 'متوقع ولادة في مارس', 'APPROVED');

-- إنشاء View لطلبات الإجازة مع معلومات إضافية
CREATE VIEW leave_requests_view AS
SELECT 
    lr.id,
    lr.employee_id,
    lr.leave_type,
    lr.start_date,
    lr.end_date,
    lr.requested_days,
    lr.reason,
    lr.additional_notes,
    lr.status,
    lr.approved_by,
    lr.approval_date,
    lr.rejection_reason,
    lr.created_at,
    lr.updated_at,
    -- حساب الأيام الفعلية
    DATEDIFF(lr.end_date, lr.start_date) + 1 as actual_days,
    -- حساب الأيام المتبقية حتى بداية الإجازة
    DATEDIFF(lr.start_date, CURDATE()) as days_until_start,
    -- التحقق من كون الإجازة في الماضي
    CASE WHEN lr.end_date < CURDATE() THEN 'PAST' 
         WHEN lr.start_date <= CURDATE() AND lr.end_date >= CURDATE() THEN 'CURRENT'
         ELSE 'FUTURE' END as time_status
FROM leave_requests lr;

-- إنشاء View لإحصائيات طلبات الإجازة
CREATE VIEW leave_request_statistics AS
SELECT 
    employee_id,
    leave_type,
    COUNT(*) as total_requests,
    SUM(CASE WHEN status = 'PENDING' THEN 1 ELSE 0 END) as pending_requests,
    SUM(CASE WHEN status = 'APPROVED' THEN 1 ELSE 0 END) as approved_requests,
    SUM(CASE WHEN status = 'REJECTED' THEN 1 ELSE 0 END) as rejected_requests,
    SUM(CASE WHEN status = 'CANCELLED' THEN 1 ELSE 0 END) as cancelled_requests,
    SUM(CASE WHEN status = 'APPROVED' THEN requested_days ELSE 0 END) as total_approved_days,
    AVG(requested_days) as average_requested_days,
    MAX(created_at) as last_request_date
FROM leave_requests 
GROUP BY employee_id, leave_type;

-- إنشاء View للطلبات المعلقة مع معلومات إضافية
CREATE VIEW pending_leave_requests AS
SELECT 
    lr.*,
    DATEDIFF(lr.start_date, CURDATE()) as days_until_start,
    CASE 
        WHEN DATEDIFF(lr.start_date, CURDATE()) <= 7 THEN 'URGENT'
        WHEN DATEDIFF(lr.start_date, CURDATE()) <= 14 THEN 'SOON'
        ELSE 'NORMAL'
    END as priority_level
FROM leave_requests lr
WHERE lr.status = 'PENDING'
ORDER BY lr.created_at ASC;

-- إنشاء View للطلبات المتداخلة
CREATE VIEW overlapping_leave_requests AS
SELECT 
    lr1.id as request1_id,
    lr1.employee_id,
    lr1.start_date as request1_start,
    lr1.end_date as request1_end,
    lr2.id as request2_id,
    lr2.start_date as request2_start,
    lr2.end_date as request2_end,
    lr1.leave_type,
    lr1.status as request1_status,
    lr2.status as request2_status
FROM leave_requests lr1
JOIN leave_requests lr2 ON lr1.employee_id = lr2.employee_id 
    AND lr1.id != lr2.id
    AND lr1.status IN ('PENDING', 'APPROVED')
    AND lr2.status IN ('PENDING', 'APPROVED')
    AND (
        (lr1.start_date <= lr2.end_date AND lr1.end_date >= lr2.start_date) OR
        (lr2.start_date <= lr1.end_date AND lr2.end_date >= lr1.start_date)
    )
WHERE lr1.id < lr2.id;

-- جدول الإشعارات الذكي
CREATE TABLE notifications (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    type VARCHAR(50) NOT NULL,
    message VARCHAR(255) NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    -- يمكنك إضافة FOREIGN KEY إذا كان عندك جدول users
);