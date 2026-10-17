-- Voice Command Logs Table
-- جدول سجلات الأوامر الصوتية للأمان والتدقيق

CREATE TABLE IF NOT EXISTS voice_command_logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    command VARCHAR(1000) NOT NULL,
    result VARCHAR(1000),
    timestamp DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ip_address VARCHAR(45),
    user_agent VARCHAR(500),
    session_id VARCHAR(100),
    command_type VARCHAR(100),
    authentication_method VARCHAR(50),
    success BOOLEAN NOT NULL DEFAULT FALSE,
    error_message VARCHAR(500),
    processing_time_ms BIGINT,
    confidence_score DOUBLE,
    language VARCHAR(10),
    
    INDEX idx_user_id (user_id),
    INDEX idx_timestamp (timestamp),
    INDEX idx_command_type (command_type),
    INDEX idx_success (success),
    INDEX idx_authentication_method (authentication_method),
    INDEX idx_session_id (session_id)
);

-- Insert sample data for testing
-- إدخال بيانات تجريبية للاختبار
INSERT INTO voice_command_logs (
    user_id, command, result, timestamp, ip_address, 
    command_type, authentication_method, success, 
    processing_time_ms, confidence_score, language
) VALUES 
(1, 'أريد إجازة غداً', 'LEAVE_REQUEST', NOW(), '127.0.0.1', 
 'LEAVE_REQUEST', 'PASSWORD', TRUE, 150, 0.95, 'ar'),
 
(1, 'I want to know my salary', 'PAYROLL_QUERY', NOW(), '127.0.0.1', 
 'PAYROLL_QUERY', 'VOICE', TRUE, 120, 0.92, 'en'),
 
(2, 'أريد تحديث بياناتي', 'PROFILE_UPDATE', NOW(), '127.0.0.1', 
 'PROFILE_UPDATE', 'PASSWORD', TRUE, 180, 0.88, 'ar'),
 
(3, 'Show me attendance report', 'ATTENDANCE_QUERY', NOW(), '127.0.0.1', 
 'ATTENDANCE_QUERY', 'PASSWORD', FALSE, 200, 0.75, 'en');

-- Create view for security monitoring
-- إنشاء عرض لمراقبة الأمان
CREATE OR REPLACE VIEW voice_security_monitoring AS
SELECT 
    user_id,
    command_type,
    authentication_method,
    success,
    COUNT(*) as command_count,
    AVG(processing_time_ms) as avg_processing_time,
    AVG(confidence_score) as avg_confidence,
    MIN(timestamp) as first_command,
    MAX(timestamp) as last_command
FROM voice_command_logs
GROUP BY user_id, command_type, authentication_method, success;

-- Create view for failed commands analysis
-- إنشاء عرض لتحليل الأوامر الفاشلة
CREATE OR REPLACE VIEW failed_voice_commands AS
SELECT 
    user_id,
    command,
    error_message,
    timestamp,
    ip_address,
    authentication_method
FROM voice_command_logs
WHERE success = FALSE
ORDER BY timestamp DESC;
