#!/usr/bin/python
import re
import sys

versionCodeString = 'android:versionCode="' + str(sys.argv[1]) + '"'
versionNameString = 'android:versionName="' +  str(sys.argv[2]) + '"'

f = open('android/AndroidManifest.xml', 'r+')
text = f.read()

newText = re.sub(r'android:versionName="[0-9.]*"', versionNameString, text)
newText = re.sub(r'android:versionCode="[0-9.]*"', versionCodeString, newText)

f.seek(0)
f.write(newText)
f.truncate()
f.close()

