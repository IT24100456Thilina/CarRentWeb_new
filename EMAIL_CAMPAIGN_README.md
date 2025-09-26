# CarRent Email Campaign Management System

## Overview

The CarRent application now includes a comprehensive Admin-only Email Campaign Management system that allows administrators to create, manage, and send email campaigns to customers.

## Features

### 🔒 Access Control
- **Admin-only access**: Only users with admin role can access campaign features
- **Automatic redirection**: Non-admin users are redirected away from campaign pages
- **Session-based authentication**: Uses existing session management for role verification

### 📧 Email Campaign Flow

#### 1. Campaign Creation
- Navigate to **Campaigns** in the Admin Dashboard
- Click **"Create New Campaign"**
- Fill out the campaign form:
  - **Email Subject** (required)
  - **Target Segment** (All Customers, Active Customers, New Customers)
  - **Special Offer** (optional)
  - **Email Body** (required)

#### 2. Campaign Management
- **Draft Status**: New campaigns are saved as drafts
- **Edit**: Modify draft campaigns before sending
- **Send**: Send campaigns to selected customer segments
- **Delete**: Remove unwanted campaigns

#### 3. Email Sending
- **Real-time sending**: Uses JavaMail API for actual email delivery
- **Error handling**: Comprehensive error logging and admin notifications
- **Progress tracking**: Logs sent, failed, and queued emails
- **Batch processing**: Sends emails to all recipients in the selected segment

### 📊 Admin Dashboard Features

#### Campaign Overview
- View all campaigns with status indicators
- Track sent count and delivery dates
- Monitor campaign performance

#### Campaign Logs & Reports
- **Detailed logs**: Track every email sent, failed, or queued
- **Error reporting**: View specific error messages for failed deliveries
- **Recipient tracking**: See which emails were sent to whom
- **Timestamp tracking**: Monitor when emails were processed

#### Status Indicators
- **Draft**: Campaign created but not sent
- **Sent**: Campaign successfully delivered
- **Failed**: Campaign encountered errors during sending

## Technical Implementation

### Database Schema

#### Campaigns Table
```sql
CREATE TABLE Campaigns (
    campaignId INT IDENTITY(1,1) PRIMARY KEY,
    subject NVARCHAR(200) NOT NULL,
    body NVARCHAR(MAX) NOT NULL,
    offer NVARCHAR(500) NULL,
    segment NVARCHAR(50) NOT NULL DEFAULT 'all',
    status NVARCHAR(20) NOT NULL DEFAULT 'draft',
    createdDate DATETIME NOT NULL DEFAULT GETDATE(),
    sentDate DATETIME NULL,
    sentCount INT NOT NULL DEFAULT 0,
    adminId INT NOT NULL,
    FOREIGN KEY (adminId) REFERENCES Users(userId)
);
```

#### CampaignLogs Table
```sql
CREATE TABLE CampaignLogs (
    logId INT IDENTITY(1,1) PRIMARY KEY,
    campaignId INT NOT NULL,
    recipientEmail NVARCHAR(100) NOT NULL,
    status NVARCHAR(20) NOT NULL,
    sentDate DATETIME NOT NULL DEFAULT GETDATE(),
    errorMessage NVARCHAR(500) NULL,
    FOREIGN KEY (campaignId) REFERENCES Campaigns(campaignId)
);
```

### Email Configuration

#### Configuration File: `src/main/resources/email.properties`

```properties
# SMTP Server Settings
mail.smtp.host=smtp.gmail.com
mail.smtp.port=587
mail.smtp.auth=true
mail.smtp.starttls.enable=true
mail.smtp.ssl.trust=smtp.gmail.com

# Email Account Credentials
mail.username=your-email@gmail.com
mail.password=your-app-password

# Email Sender Information
mail.from.name=CarRent Admin
mail.from.address=your-email@gmail.com

# Email Templates
mail.subject.prefix=[CarRent]
mail.footer.text=Best regards,\nCarRent Team\n\n---\nThis email was sent to: {recipient}\nIf you no longer wish to receive promotional emails, please contact us.
```

#### Supported Email Providers

1. **Gmail**:
   - Host: `smtp.gmail.com`
   - Port: `587`
   - Use App Passwords (not regular password)

2. **Outlook/Hotmail**:
   - Host: `smtp-mail.outlook.com`
   - Port: `587`

3. **Yahoo**:
   - Host: `smtp.mail.yahoo.com`
   - Port: `587`

4. **Custom SMTP**: Update configuration accordingly

### Dependencies

Add to `pom.xml`:
```xml
<dependency>
    <groupId>com.sun.mail</groupId>
    <artifactId>jakarta.mail</artifactId>
    <version>2.0.1</version>
</dependency>
```

## Setup Instructions

### 1. Configure Email Settings

1. Edit `src/main/resources/email.properties`
2. Update SMTP settings for your email provider
3. Set your email credentials
4. Customize sender information and templates

### 2. Gmail Setup (Example)

1. Enable 2-Factor Authentication on your Google account
2. Generate an App Password:
   - Go to Google Account settings
   - Security → 2-Step Verification → App passwords
   - Generate password for "Mail"
3. Use your Gmail address as `mail.username`
4. Use the App Password as `mail.password`

### 3. Database Setup

Ensure the following tables exist in your CarRentalDB:
- `Campaigns`
- `CampaignLogs`

Run the SQL scripts from `database/CarRentalDB.sql` if not already created.

## Usage Guide

### Creating a Campaign

1. Log in as an admin
2. Navigate to **Campaigns** in the admin sidebar
3. Click **"Create Campaign"**
4. Fill in:
   - Subject line (keep it engaging)
   - Select target segment
   - Add special offer details (optional)
   - Write compelling email content
5. Click **"Save Campaign"**

### Sending a Campaign

1. From the campaigns list, find your draft campaign
2. Click **"Send"** button
3. Confirm sending
4. Monitor progress through campaign logs

### Monitoring Results

1. Click **"Logs"** button on any campaign
2. View detailed delivery reports
3. Check for failed deliveries and error messages
4. Track overall campaign performance

## Customer Segments

### All Customers
- Targets all registered users with `role = 'customer'`

### Active Customers
- Users who have confirmed or completed bookings
- SQL: `JOIN Bookings WHERE status IN ('Confirmed', 'Completed')`

### New Customers (30 days)
- Users registered within the last 30 days
- SQL: `DATEDIFF(day, createdDate, GETDATE()) <= 30`

## Error Handling

### Email Server Issues
- Automatic detection of SMTP connection failures
- Campaign status set to "failed"
- Detailed error logging
- Admin notifications

### Individual Email Failures
- Per-recipient error tracking
- Continues sending to remaining recipients
- Comprehensive error messages in logs

### Configuration Errors
- Fallback to default settings if properties file missing
- Graceful degradation with warning messages

## Security Considerations

- Email credentials stored in properties file (consider encryption for production)
- Admin-only access enforced at controller level
- Session validation on all campaign operations
- SQL injection prevention using prepared statements

## Troubleshooting

### Common Issues

1. **"Email server is currently unavailable"**
   - Check SMTP settings in `email.properties`
   - Verify email credentials
   - Check network connectivity

2. **"No recipients found for this segment"**
   - Ensure customers exist in the database
   - Check segment selection logic
   - Verify user roles are set correctly

3. **"Campaign not found"**
   - Verify campaign exists in database
   - Check campaign ID parameters

### Debug Mode

Enable detailed logging by adding to your application properties:
```
logging.level.com.example.carrentweb.Boundary.CampaignController=DEBUG
```

## Future Enhancements

- Email template system
- Scheduled campaign sending
- A/B testing for subject lines
- Campaign analytics dashboard
- Unsubscribe functionality
- HTML email support
- Attachment support

## Support

For technical support or questions about the Email Campaign Management system, please contact the development team.