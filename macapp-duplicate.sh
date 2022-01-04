appname=KakaoTalk
id=com.kakao.KakaoTalkMac
if [ -e $1 ] || [ -e $2 ]; then sleep 0; else appname=$1; id=$2; fi

echo app $appname
echo id $id
appnameDev="$appname"Dev
idDev="$id"Dev

cp -a /Applications/$appname.app /Applications/$appnameDev.app
mv /Applications/$appnameDev.app/contents/MacOS/$appname /Applications/$appnameDev.app/contents/MacOS/$appnameDev

#CFBundleExecutable을 새 name으로 
sed "N;s|\t<key>CFBundleExecutable</key>\n\t<string>$appname</string>|\t<key>CFBundleExecutable</key>\n\t<string>$appnameDev</string>|g" \
/Applications/$appnameDev.app/Contents/Info.plist > /Applications/$appnameDev.app/Contents/Info.plista

#CFBundleIdentifier을 새 id으로
sed "N;s|\t<key>CFBundleIdentifier</key>\n\t<string>$id</string>|\t<key>CFBundleIdentifier</key>\n\t<string>$idDev</string>|g" \
/Applications/$appnameDev.app/Contents/Info.plista > /Applications/$appnameDev.app/Contents/Info.plistb

#info.plist에 적용
cp -af /Applications/$appnameDev.app/Contents/Info.plistb /Applications/$appnameDev.app/Contents/Info.plist
rm -fr /Applications/$appnameDev.app/Contents/Info.plista /Applications/$appnameDev.app/Contents/Info.plistb

codesign --force --deep --sign - /Applications/$appnameDev.app
open /Applications/KaKaoTalkDev.app
