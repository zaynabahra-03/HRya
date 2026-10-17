# Policy Management API Documentation

## Overview
This API provides endpoints for managing organizational policies including leave policies, employment policies, salary policies, performance policies, and discipline policies.

## Base URL
```
http://localhost:8080/api/policies
```

## Endpoints

### 1. Get All Policies
**GET** `/getall`
- **Description**: Retrieve all policies
- **Response**: List of all policies
- **Example Response**:
```json
{
  "success": true,
  "message": "All policies listed successfully",
  "data": [
    {
      "id": 1,
      "title": "سياسة الإجازات السنوية",
      "description": "سياسة تحكم الإجازات السنوية للموظفين",
      "policyType": "LEAVE",
      "content": "1. يحق لكل موظف إجازة سنوية...",
      "version": 1,
      "isActive": true,
      "effectiveDate": "2024-01-01T00:00:00",
      "createdDate": "2024-01-01T00:00:00"
    }
  ]
}
```

### 2. Get Policy by ID
**GET** `/getbyid/{id}`
- **Description**: Retrieve a specific policy by ID
- **Parameters**: `id` (int) - Policy ID
- **Response**: Policy details

### 3. Get Policies by Type
**GET** `/getbytype/{policyType}`
- **Description**: Retrieve policies by type
- **Parameters**: `policyType` (String) - LEAVE, EMPLOYMENT, SALARY, PERFORMANCE, DISCIPLINE
- **Response**: List of policies of specified type

### 4. Get Active Policies
**GET** `/getactive`
- **Description**: Retrieve all active policies
- **Response**: List of active policies

### 5. Get Active Policies by Type
**GET** `/getactivebytype/{policyType}`
- **Description**: Retrieve active policies by type
- **Parameters**: `policyType` (String)
- **Response**: List of active policies of specified type

### 6. Search Policies
**GET** `/search?keyword={keyword}`
- **Description**: Search policies by keyword in title or description
- **Parameters**: `keyword` (String) - Search term
- **Response**: List of matching policies

### 7. Get Currently Active Policies
**GET** `/getcurrentlyactive`
- **Description**: Retrieve policies that are currently effective
- **Response**: List of currently active policies

### 8. Get Currently Active Policies by Type
**GET** `/getcurrentlyactivebytype/{policyType}`
- **Description**: Retrieve currently active policies by type
- **Parameters**: `policyType` (String)
- **Response**: List of currently active policies of specified type

### 9. Add New Policy
**POST** `/add`
- **Description**: Create a new policy
- **Request Body**:
```json
{
  "title": "سياسة جديدة",
  "description": "وصف السياسة",
  "policyType": "LEAVE",
  "content": "محتوى السياسة...",
  "effectiveDate": "2024-01-01T00:00:00",
  "createdBy": "admin"
}
```
- **Response**: Success/Error message

### 10. Update Policy
**PUT** `/update/{id}`
- **Description**: Update an existing policy
- **Parameters**: `id` (int) - Policy ID
- **Request Body**: Same as add policy
- **Response**: Success/Error message

### 11. Delete Policy
**DELETE** `/delete/{id}`
- **Description**: Delete a policy
- **Parameters**: `id` (int) - Policy ID
- **Response**: Success/Error message

### 12. Activate Policy
**PUT** `/activate/{id}`
- **Description**: Activate a policy
- **Parameters**: `id` (int) - Policy ID
- **Response**: Success/Error message

### 13. Deactivate Policy
**PUT** `/deactivate/{id}`
- **Description**: Deactivate a policy
- **Parameters**: `id` (int) - Policy ID
- **Response**: Success/Error message

### 14. Approve Policy
**PUT** `/approve/{id}?approvedBy={approvedBy}`
- **Description**: Approve a policy
- **Parameters**: 
  - `id` (int) - Policy ID
  - `approvedBy` (String) - Name of approver
- **Response**: Success/Error message

### 15. Expire Policy
**PUT** `/expire/{id}`
- **Description**: Expire a policy
- **Parameters**: `id` (int) - Policy ID
- **Response**: Success/Error message

## Specific Policy Type Endpoints

### 16. Get Leave Policies
**GET** `/leave-policies`
- **Description**: Retrieve all leave policies
- **Response**: List of leave policies

### 17. Get Employment Policies
**GET** `/employment-policies`
- **Description**: Retrieve all employment policies
- **Response**: List of employment policies

### 18. Get Salary Policies
**GET** `/salary-policies`
- **Description**: Retrieve all salary policies
- **Response**: List of salary policies

### 19. Get Performance Policies
**GET** `/performance-policies`
- **Description**: Retrieve all performance policies
- **Response**: List of performance policies

### 20. Get Discipline Policies
**GET** `/discipline-policies`
- **Description**: Retrieve all discipline policies
- **Response**: List of discipline policies

## Policy Types
- **LEAVE**: سياسات الإجازات
- **EMPLOYMENT**: سياسات التوظيف
- **SALARY**: سياسات الرواتب
- **PERFORMANCE**: سياسات الأداء
- **DISCIPLINE**: سياسات الانضباط

## Error Responses
```json
{
  "success": false,
  "message": "Error description"
}
```

## Success Responses
```json
{
  "success": true,
  "message": "Operation completed successfully",
  "data": "Result data (if applicable)"
}
```

## Usage Examples

### Create a Leave Policy
```bash
curl -X POST http://localhost:8080/api/policies/add \
  -H "Content-Type: application/json" \
  -d '{
    "title": "سياسة الإجازات المرضية",
    "description": "سياسة الإجازات المرضية للموظفين",
    "policyType": "LEAVE",
    "content": "1. يحق للموظف إجازة مرضية مدفوعة الأجر...",
    "effectiveDate": "2024-01-01T00:00:00",
    "createdBy": "admin"
  }'
```

### Get All Leave Policies
```bash
curl -X GET http://localhost:8080/api/policies/leave-policies
```

### Search Policies
```bash
curl -X GET "http://localhost:8080/api/policies/search?keyword=إجازة"
``` 