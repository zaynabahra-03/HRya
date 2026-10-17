# HRMS (Human Resource Management System) - Software Requirements Specification (SRS)

## 1. Introduction

### 1.1 Purpose
This document provides a comprehensive specification for the HRMS (Human Resource Management System) project, which is a modern, voice-enabled human resource management solution designed for organizations to manage their workforce efficiently.

### 1.2 Scope
The HRMS system encompasses comprehensive human resource management functionalities including employee management, leave management, payroll processing, attendance tracking, policy management, and an innovative voice command system with bilingual support (Arabic and English).

### 1.3 Definitions
- **HRMS**: Human Resource Management System
- **TTS**: Text-to-Speech
- **STT**: Speech-to-Text
- **NLU**: Natural Language Understanding
- **API**: Application Programming Interface
- **JPA**: Java Persistence API
- **DTO**: Data Transfer Object

## 2. Overall Description

### 2.1 Product Perspective
The HRMS is a web-based application built using Spring Boot framework with a layered architecture that includes:
- **Frontend**: HTML/CSS/JavaScript interfaces
- **Backend**: Spring Boot REST API
- **Database**: H2 (development) / MySQL/PostgreSQL (production)
- **Security**: Spring Security with role-based access control
- **Voice System**: Advanced voice command processing with AI/ML capabilities

### 2.2 Product Functions

#### 2.2.1 Core HR Functions
1. **User Management**
   - Employee registration and profiles
   - Role-based access control
   - User authentication and authorization

2. **Leave Management**
   - Leave request submission
   - Leave approval workflow
   - Leave balance tracking
   - Leave reasons and types

3. **Attendance Management**
   - Attendance tracking
   - Working time management
   - Attendance reporting
   - Working type configurations

4. **Payroll Management**
   - Salary calculations
   - Payroll processing
   - Compensation management
   - Deduction handling

5. **Policy Management**
   - Company policies
   - Leave policies
   - Employment policies
   - Salary policies
   - Performance policies
   - Discipline policies

6. **Job Management**
   - Job positions
   - Job advertisements
   - Job seeker management
   - CV management

#### 2.2.2 Voice Command System
1. **Bilingual Support**
   - Arabic language processing
   - English language processing
   - Automatic language detection

2. **Voice Commands**
   - Leave requests via voice
   - Profile updates via voice
   - Payroll queries via voice
   - Attendance queries via voice
   - Policy queries via voice

3. **AI/ML Features**
   - Intent recognition
   - Context awareness
   - Sentiment analysis
   - Urgency detection
   - Confidence scoring

4. **Security Features**
   - Voice authentication
   - Command logging
   - Permission checking
   - Audit trails

### 2.3 User Classes and Characteristics
1. **Administrators**: Full system access, user management
2. **HR Managers**: Employee management, policy management
3. **Managers**: Team management, approval workflows
4. **Employees**: Self-service, personal information
5. **Job Seekers**: Job application, CV management

### 2.4 Operating Environment
- **Operating System**: Windows, Linux, macOS
- **Web Browser**: Chrome, Firefox, Safari, Edge
- **Java Version**: Java 11 or higher
- **Database**: H2 (dev), MySQL/PostgreSQL (prod)
- **Server**: Spring Boot embedded Tomcat

## 3. Specific Requirements

### 3.1 Functional Requirements

#### 3.1.1 User Authentication and Authorization
- **FR-001**: System shall authenticate users using email and password
- **FR-002**: System shall support role-based access control
- **FR-003**: System shall provide voice authentication option
- **FR-004**: System shall log all authentication attempts

#### 3.1.2 Employee Management
- **FR-005**: System shall allow creation of employee profiles
- **FR-006**: System shall support profile updates via voice commands
- **FR-007**: System shall maintain employee personal information
- **FR-008**: System shall track employee status (active/inactive)

#### 3.1.3 Leave Management
- **FR-009**: System shall process leave requests
- **FR-010**: System shall support leave approval workflow
- **FR-011**: System shall track leave balances
- **FR-012**: System shall accept voice commands for leave requests
- **FR-013**: System shall support multiple leave types and reasons

#### 3.1.4 Attendance Management
- **FR-014**: System shall track employee attendance
- **FR-015**: System shall generate attendance reports
- **FR-016**: System shall support voice queries for attendance
- **FR-017**: System shall manage working time configurations

#### 3.1.5 Payroll Management
- **FR-018**: System shall calculate employee salaries
- **FR-019**: System shall process payroll
- **FR-020**: System shall support voice queries for payroll information
- **FR-021**: System shall handle deductions and allowances

#### 3.1.6 Policy Management
- **FR-022**: System shall maintain company policies
- **FR-023**: System shall support voice queries for policy information
- **FR-024**: System shall categorize policies by type
- **FR-025**: System shall provide policy search and retrieval

#### 3.1.7 Voice Command System
- **FR-026**: System shall recognize voice commands in Arabic
- **FR-027**: System shall recognize voice commands in English
- **FR-028**: System shall automatically detect input language
- **FR-029**: System shall process natural language intent
- **FR-030**: System shall provide voice responses
- **FR-031**: System shall maintain conversation context
- **FR-032**: System shall log all voice commands for security

### 3.2 Non-Functional Requirements

#### 3.2.1 Performance
- **NFR-001**: System shall respond to voice commands within 2 seconds
- **NFR-002**: System shall support concurrent users (minimum 100)
- **NFR-003**: System shall process database queries within 1 second

#### 3.2.2 Security
- **NFR-004**: System shall encrypt all passwords using BCrypt
- **NFR-005**: System shall log all security-related activities
- **NFR-006**: System shall implement session management
- **NFR-007**: System shall support HTTPS in production

#### 3.2.3 Usability
- **NFR-008**: System shall support both Arabic and English interfaces
- **NFR-009**: System shall provide intuitive voice command interface
- **NFR-010**: System shall offer responsive web design

#### 3.2.4 Reliability
- **NFR-011**: System shall maintain 99.9% uptime
- **NFR-012**: System shall provide data backup and recovery
- **NFR-013**: System shall handle system failures gracefully

#### 3.2.5 Scalability
- **NFR-014**: System shall support horizontal scaling
- **NFR-015**: System shall handle increasing data volumes
- **NFR-016**: System shall support multiple deployment environments

### 3.3 Technical Requirements

#### 3.3.1 Architecture
- **TR-001**: System shall use Spring Boot framework
- **TR-002**: System shall implement layered architecture (Controller-Service-DAO)
- **TR-003**: System shall use Spring Data JPA for data access
- **TR-004**: System shall implement RESTful API design

#### 3.3.2 Database
- **TR-005**: System shall use H2 database for development
- **TR-006**: System shall support MySQL/PostgreSQL for production
- **TR-007**: System shall implement proper database normalization
- **TR-008**: System shall support database migrations

#### 3.3.3 Voice Processing
- **TR-009**: System shall integrate with AWS Transcribe for STT
- **TR-010**: System shall implement custom NLU engine
- **TR-011**: System shall support real-time voice processing
- **TR-012**: System shall implement voice command caching

## 4. System Architecture

### 4.1 High-Level Architecture
```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Frontend      │    │   Backend       │    │   Database      │
│   (HTML/JS)     │◄──►│   (Spring Boot) │◄──►│   (H2/MySQL)    │
└─────────────────┘    └─────────────────┘    └─────────────────┘
                              │
                              ▼
                       ┌─────────────────┐
                       │   Voice System  │
                       │   (AI/ML/NLU)   │
                       └─────────────────┘
```

### 4.2 Layered Architecture
1. **Presentation Layer**: Controllers, DTOs
2. **Business Layer**: Services, Business Logic
3. **Data Access Layer**: DAOs, Repositories
4. **Entity Layer**: JPA Entities, Domain Models

### 4.3 Voice System Architecture
1. **Voice Input**: Speech-to-Text conversion
2. **Intent Recognition**: Natural Language Understanding
3. **Command Processing**: Business logic execution
4. **Response Generation**: Text-to-Speech conversion

## 5. Database Design

### 5.1 Core Entities
- **User**: Employee information and authentication
- **LeaveRequest**: Leave application details
- **Attendance**: Employee attendance records
- **Payroll**: Salary and compensation data
- **Policy**: Company policy information
- **VoiceCommandLog**: Voice command audit trail

### 5.2 Key Relationships
- User → LeaveRequest (One-to-Many)
- User → Attendance (One-to-Many)
- User → Payroll (One-to-Many)
- Policy → PolicyType (Many-to-One)

## 6. API Design

### 6.1 REST Endpoints
- **Authentication**: `/api/auth/*`
- **Users**: `/api/users/*`
- **Leave**: `/api/leave/*`
- **Attendance**: `/api/attendance/*`
- **Payroll**: `/api/payroll/*`
- **Policy**: `/api/policy/*`
- **Voice**: `/api/voice/*`

### 6.2 Voice API Endpoints
- **Voice Commands**: `/api/voice/command`
- **Voice Security**: `/api/voice/security/*`
- **TTS**: `/api/voice/tts`
- **STT**: `/api/voice/stt`

## 7. Security Requirements

### 7.1 Authentication
- Password-based authentication
- Voice-based authentication
- Session management
- JWT token support

### 7.2 Authorization
- Role-based access control
- Permission-based access control
- Voice command permission checking

### 7.3 Audit and Logging
- Voice command logging
- Authentication logging
- Security event logging
- Data access logging

## 8. Testing Requirements

### 8.1 Unit Testing
- Service layer testing
- Repository layer testing
- Utility class testing

### 8.2 Integration Testing
- API endpoint testing
- Database integration testing
- Voice system integration testing

### 8.3 Voice System Testing
- Arabic language processing
- English language processing
- Intent recognition accuracy
- Response generation quality

## 9. Deployment Requirements

### 9.1 Development Environment
- Java 11+
- Maven 3.6+
- H2 Database
- Spring Boot DevTools

### 9.2 Production Environment
- Java 11+
- MySQL/PostgreSQL
- HTTPS support
- Load balancing capability

### 9.3 AWS Integration
- S3 for file storage
- Transcribe for speech recognition
- CloudWatch for monitoring
- RDS for database

## 10. Maintenance and Support

### 10.1 System Monitoring
- Application performance monitoring
- Database performance monitoring
- Voice system accuracy monitoring
- Security event monitoring

### 10.2 Backup and Recovery
- Database backup strategies
- File backup strategies
- Disaster recovery procedures
- Data retention policies

### 10.3 Updates and Maintenance
- Regular security updates
- Feature enhancements
- Bug fixes and patches
- Performance optimizations

## 11. Future Enhancements

### 11.1 AI/ML Improvements
- Enhanced intent recognition
- Predictive analytics
- Sentiment analysis
- User behavior analysis

### 11.2 Mobile Support
- Mobile application development
- Push notifications
- Offline capabilities
- Mobile voice commands

### 11.3 Integration Capabilities
- Third-party HR systems
- Payroll service providers
- Time tracking systems
- Communication platforms

## 12. Conclusion

This HRMS system represents a comprehensive solution for modern human resource management, featuring innovative voice command capabilities that make the system more accessible and user-friendly. The system's bilingual support, advanced security features, and scalable architecture make it suitable for organizations of various sizes and requirements.

The voice command system, with its AI/ML capabilities, sets this HRMS apart from traditional systems, providing a natural and intuitive way for users to interact with the system while maintaining high security standards and comprehensive audit trails.
