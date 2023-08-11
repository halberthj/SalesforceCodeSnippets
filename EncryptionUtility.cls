public with sharing class EncryptionUtility {

    // Replace this with your actual private key
    private static final String PRIVATE_KEY = 'MIIJQwIBADAN...'; // Your private key goes here

    /**
     * Encrypts a string using AES256 encryption algorithm and the provided private key.
     * 
     * @param privateKeyBlob The private key in Blob format.
     * @param clearText The text to be encrypted.
     * @return The encrypted text in base64 encoding.
     */
    public static String encryptString(Blob privateKeyBlob, String clearText) {
        Blob data = Blob.valueOf(clearText);
        Blob encryptedData = Crypto.encryptWithManagedIV('AES256', privateKeyBlob, data);
        return EncodingUtil.base64Encode(encryptedData);
    }

    /**
     * Decrypts a previously encrypted string using AES256 encryption algorithm and the provided private key.
     * 
     * @param privateKeyBlob The private key in Blob format.
     * @param encryptedText The encrypted text in base64 encoding.
     * @return The decrypted text.
     */
    public static String decryptString(Blob privateKeyBlob, String encryptedText) {
        Blob encryptedData = EncodingUtil.base64Decode(encryptedText);
        Blob decryptedData = Crypto.decryptWithManagedIV('AES256', privateKeyBlob, encryptedData);
        return decryptedData.toString();
    }

    /**
     * Generates a digital signature using the provided private key.
     * 
     * @param privateKeyBlob The private key in Blob format.
     * @param dataToSign The data to be signed.
     * @return The digital signature.
     */
    public static Blob generateSignature(Blob privateKeyBlob, Blob dataToSign) {
        return Crypto.sign('RSA-SHA256', dataToSign, privateKeyBlob);
    }

    public static void exampleUsage() {
        String json = '{"identifier":"XM440010000011","firstName":"Bosco","lastName":"Mwanawasitte","nationality":"UG","residence":"UG","birthDate":"1986-01-27","clientType":"A5A","occupationCategory":"self_employed","bankProduct":"Transactional"}';
        Blob privateKeyBlob = EncodingUtil.base64Decode(PRIVATE_KEY);

        // Encrypt
        String encryptedText = encryptString(privateKeyBlob, json);
        System.debug('Encrypted Text: ' + encryptedText);

        // Decrypt
        String decryptedText = decryptString(privateKeyBlob, encryptedText);
        System.debug('Decrypted Text: ' + decryptedText);

        // Generate Signature
        Blob dataToSign = Blob.valueOf(json);
        Blob signature = generateSignature(privateKeyBlob, dataToSign);
        System.debug('Signature: ' + EncodingUtil.base64Encode(signature));
    }
}
