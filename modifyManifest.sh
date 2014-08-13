#!/usr/bin/python
import re
from subprocess import check_output

version = check_output("git rev-list HEAD --count", shell=True)

version = int(version)

versionCodeString = 'android:versionCode="' + str(version) + '"'
versionNameString = 'android:versionName="0.' +  str(version) + '"'

f = open('android/AndroidManifest.xml', 'r+')
text = f.read()

newText = re.sub(r'android:versionName="[0-9.]*"', versionNameString, text)
newText = re.sub(r'android:versionCode="[0-9.]*"', versionCodeString, newText)

f.seek(0)
f.write(newText)
f.truncate()
f.close()

