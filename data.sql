-- جدول الأسباب
CREATE TABLE leave_reasons (
    id INT PRIMARY KEY AUTO_INCREMENT,
    reason VARCHAR(255) NOT NULL
);

INSERT INTO leave_reasons (reason) VALUES
('إجازة سنوية'),
('إجازة طارئة'),
('إجازة مرضية'),
('إجازة بدون راتب'),
('إجازة أمومة'),
('إجازة أبوة');

-- جدول حالات الطلب
CREATE TABLE leave_request_statuses (
    id INT PRIMARY KEY AUTO_INCREMENT,
    status VARCHAR(50) NOT NULL
);

INSERT INTO leave_request_statuses (status) VALUES
('PENDING'),
('APPROVED'),
('REJECTED'),
('CANCELLED');