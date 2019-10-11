#Rabi Roshan
#Vignere Cipher	

def encrypt(text,s):
	result = ""
	
	keyarr = []
	for i in range (len(text)):
		keyarr.append(int((ord(s[i % len(s)]) - 96)))
		
	for i in range (len(text)):
		char = text[i]
		if(char.isupper()):
			result += chr((ord(char) + keyarr[i] - 65) % 26 + 65)
		if(char.islower()):
			result += chr((ord(char) + keyarr[i] -97) % 26 + 97)
	return result

text = raw_input("Enter the message to be encrypted:")
s = raw_input("Enter the key for the Vigenere cipher:")
result = encrypt(text,s)
print("The encoded message is:" + result)
