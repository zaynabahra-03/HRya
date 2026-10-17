# إعداد AWS لتحويل الكلام إلى نص (بديل عن Google)

## المتطلبات
- حساب AWS
- صلاحيات IAM مناسبة لاستخدام Amazon Transcribe وS3

## 1) إنشاء مستخدم/دور IAM
- أنشئ مستخدم IAM مخصص للتطبيق أو استخدم دور خدمة (يفضل على EC2/ECS/Lambda)
- اربط سياسة أقل صلاحية ممكنة. مثال مبسط (عدّل أسماء البكِت):

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "transcribe:StartTranscriptionJob",
        "transcribe:GetTranscriptionJob"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": ["s3:GetObject", "s3:PutObject", "s3:ListBucket"],
      "Resource": [
        "arn:aws:s3:::your-input-bucket",
        "arn:aws:s3:::your-input-bucket/*",
        "arn:aws:s3:::your-output-bucket",
        "arn:aws:s3:::your-output-bucket/*"
      ]
    }
  ]
}
```

## 2) إنشاء S3 Bucket
- Bucket للملفات الصوتية (input)
- Bucket اختياري لمخرجات Transcribe (output)
- اختر Region واحدة (مثال: us-east-1)

## 3) ضبط المفاتيح والبيئة
اختر أحد الخيارات:
- متغيرات بيئة (مستحسن في التطوير):
  - Windows PowerShell:
    ```powershell
    setx AWS_ACCESS_KEY_ID "YOUR_KEY_ID"
    setx AWS_SECRET_ACCESS_KEY "YOUR_SECRET"
    setx AWS_REGION "us-east-1"
    ```
    أعد فتح الطرفية بعد التنفيذ.
- أو `~/.aws/credentials` و `~/.aws/config` (AWS CLI):
  - credentials:
    ```
    [default]
    aws_access_key_id=YOUR_KEY_ID
    aws_secret_access_key=YOUR_SECRET
    ```
  - config:
    ```
    [default]
    region=us-east-1
    ```
- أو عبر `application.properties` داخل المشروع (بدون الأسرار في Git):
  - انظر القالب في `src/main/resources/application.properties`.

## 4) الاعتماديات (Dependencies)
- موجودة بالفعل في `pom.xml`:
  - `software.amazon.awssdk:transcribe`
  - `software.amazon.awssdk:s3`

## 5) الكود الموجود
- الخدمة جاهزة: `SpeechToTextManager` تستخدم Amazon Transcribe.
- التوقيع:
  - `transcribeFromS3("s3://bucket/key/audio.mp3", "en-US")`

## 6) اختبار سريع
1. ارفع ملفك الصوتي إلى S3.
2. شغّل التطبيق.
3. استدعِ الخدمة (أو سنضيف Endpoint):
   - مثال S3 URI: `s3://your-input-bucket/folder/audio.mp3`
   - لغة: `en-US` أو `ar-SA` حسب الحاجة.

## 7) تنظيف ملفات Google
- `GOOGLE_CLOUD_SETUP.md` و `credentials-template.json` غير مستخدمة الآن.
- يمكن حذفها أو تركها توضيحاً تاريخياً.

## 8) إضافة Endpoint (اختياري)
- يمكننا إضافة Controller بسيط لقبول `mediaS3Uri` و`languageCode` وإرجاع النص.
- أخبرني إن رغبت وسأضيفه مباشرة. 