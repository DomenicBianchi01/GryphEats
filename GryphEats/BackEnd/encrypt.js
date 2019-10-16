// TO Be FINISHED IN UPCOMING MERGE REQUESTS

import jscu from 'js-crypto-utils';


// source: https://forum.safedev.org/t/uint8array-buffer-string-conversion-in-javascript/1040
function stringToArray(bufferString)
{
	let uint8Array = new TextEncoder("utf-8").encode(bufferString);
	return uint8Array;
}

// source: https://www.npmjs.com/package/js-crypto-utils
function encryptString(rawstring)
{

	rawstring = 'test123';
	const msg = new Uint8Array(32);

	msg = stringToArray(rawstring);

	for(let i = 0; i < 32; i++) msg[i] = 0xFF & i;

	const remotePublicKey = {...}; // destination's publicKey in jscu.Key object
	const remotePrivateKey = {...}; // destination's privateKey in jscu.Key object

	jscu.pkc.generateKey(  // key generation
	  'EC', // ECDSA or ECDH key pair
	  {namedCurve: 'P-256'} // or 'P-384', 'P-521', 'P-256K'
	).then( async (keyPair) => { // get a key pair in jscu.Key object
	  ////////////////////////////
	  // encryption at my side
	  ////////////////////////////
	  const optionsEncryption = {
	    privateKey: keyPair.privateKey, // for ECDH, my private key
	    hash: 'SHA-256', // for HKDF
	    encrypt: 'AES-GCM', // for encryption of message, if message is a key, 'AES-KW' can be used as well.
	    keyLength: 32, // key length of AES
	    info: '' // for HKDF
	  };
	  const encrypted = await jscu.pkc.encrypt(msg, remotePublicKey, optionsEncryption);
}
