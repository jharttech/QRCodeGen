import qrcode
import datetime

#!/usr/local/bin/python

f = open("jhart_shell_logo.txt", "r")
text = f.read()
print text
f.close()

# Take Input
answer = raw_input("What url would you like to QR?: \n")
print("You entered " + answer)

x = datetime.datetime.now()
y = x.strftime('%Y-%m-%d')

# Generate QR code
img = qrcode.make(answer)

# Save as file
img.save(y+"_QRCode.png", "PNG")
