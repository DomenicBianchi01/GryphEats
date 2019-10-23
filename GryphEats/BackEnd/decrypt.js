//source https://www.npmjs.com/package/js-crypto-utils

function decrypt(encrypted)
{

	const optionsDecryption = {
	    publicKey: keyPair.publicKey, // for ECDH, my public key
	    hash: 'SHA-256', // for HKDF
	    encrypt: 'AES-GCM', // for encryption of message. 'AES-KW' can be used as well
	    keyLength: 32, // key length of AES
	    info: '', // for HKDF
	    salt: encrypted.salt, // for HKDF
	    iv: encrypted.iv // for AES
	  };
	  const decrypted = await jscu.pkc.decrypt(encrypted.data, remotePrivateKey, optionsDecryption);
	  // now you get decrypted message
	return decrypted;
}
