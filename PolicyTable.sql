-- Create policies table
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

-- Create indexes for better performance
CREATE INDEX idx_policies_policy_type ON policies(policy_type);
CREATE INDEX idx_policies_is_active ON policies(is_active);
CREATE INDEX idx_policies_effective_date ON policies(effective_date);
CREATE INDEX idx_policies_title_type ON policies(title, policy_type);

-- Insert sample policies for different types
INSERT INTO policies (title, description, policy_type, content, effective_date, created_by) VALUES
('سياسة الإجازات السنوية', 'سياسة تحكم الإجازات السنوية للموظفين', 'LEAVE', 
'1. يحق لكل موظف إجازة سنوية مدفوعة الأجر لمدة 21 يوم عمل.
2. يجب تقديم طلب الإجازة قبل أسبوعين على الأقل.
3. لا يمكن أخذ أكثر من 10 أيام إجازة متتالية.
4. الإجازات غير المستخدمة تحمل للعام التالي بحد أقصى 7 أيام.
5. يتم دفع بدل الإجازة عند انتهاء الخدمة.', 
CURRENT_TIMESTAMP, 'admin'),

('سياسة التوظيف', 'سياسة توظيف الموظفين الجدد', 'EMPLOYMENT',
'1. يجب أن يكون المتقدم حاصلاً على المؤهل العلمي المطلوب.
2. يتم إجراء مقابلة شخصية مع المتقدمين المؤهلين.
3. يتم التحقق من المراجع السابقة.
4. يجب إكمال فترة تجريبية لمدة 3 أشهر.
5. يتم توقيع عقد عمل رسمي بعد نجاح الفترة التجريبية.',
CURRENT_TIMESTAMP, 'admin'),

('سياسة الرواتب والمكافآت', 'سياسة تحديد الرواتب والمكافآت', 'SALARY',
'1. يتم تحديد الراتب الأساسي حسب المؤهل والخبرة.
2. يتم صرف الراتب في آخر يوم عمل من الشهر.
3. يحق للموظف الحصول على بدل سكن وبدل نقل.
4. يتم منح مكافأة سنوية تعادل راتب شهر واحد.
5. يتم مراجعة الرواتب سنوياً حسب الأداء والتضخم.',
CURRENT_TIMESTAMP, 'admin'),

('سياسة تقييم الأداء', 'سياسة تقييم أداء الموظفين', 'PERFORMANCE',
'1. يتم تقييم أداء الموظفين كل 6 أشهر.
2. يتم استخدام نموذج تقييم موحد.
3. يتم إجراء مقابلة تقييم مع المدير المباشر.
4. يتم تحديد نقاط القوة والتحسين.
5. يتم ربط التقييم بالترقيات والزيادات.',
CURRENT_TIMESTAMP, 'admin'),

('سياسة الانضباط والعقوبات', 'سياسة معالجة المخالفات والعقوبات', 'DISCIPLINE',
'1. يتم تطبيق نظام تحذيرات تدريجي.
2. التحذير الأول: تنبيه شفهي.
3. التحذير الثاني: تنبيه كتابي.
4. التحذير الثالث: إنذار نهائي.
5. التحذير الرابع: إنهاء الخدمة.
6. يتم توثيق جميع التحذيرات في ملف الموظف.',
CURRENT_TIMESTAMP, 'admin');

-- Create view for currently active policies
CREATE VIEW currently_active_policies AS
SELECT * FROM policies 
WHERE is_active = true 
AND effective_date <= CURRENT_TIMESTAMP 
AND (expiry_date IS NULL OR expiry_date > CURRENT_TIMESTAMP);

-- Create view for policies by type
CREATE VIEW policies_by_type AS
SELECT policy_type, COUNT(*) as policy_count, 
       COUNT(CASE WHEN is_active = true THEN 1 END) as active_count
FROM policies 
GROUP BY policy_type; 