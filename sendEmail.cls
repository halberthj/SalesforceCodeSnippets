String userEmail = 'hjhimanshu4@gmail.com';

        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {userEmail};
        mail.setToAddresses(toAddresses);
        mail.setSubject('Generated Private ');
        mail.setHtmlBody('<Html><body>Hi User,<br/>Signature for the encryption'+EncodingUtil.base64Encode(signature)+' <br/> </Body></Html>');
        // mail.setHtmlBody('<Html><body></Body></Html>');

        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });

