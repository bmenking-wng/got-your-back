cd src
pyinstaller --clean --noupx -F --distpath=gyb windows-gyb.spec
export gyb="gyb/gyb"
$gyb --version
export GYBVERSION=`$gyb --simple-version`
cp LICENSE gyb
GYB_ARCHIVE=gyb-$GYBVERSION-windows-$PLATFORM.zip
/c/Program\ Files/7-Zip/7z.exe a -tzip $GYB_ARCHIVE gyb -xr!.svn
mkdir gyb-64
cp -rf gyb/* gyb-64/;
/c/Program\ Files\ \(x86\)/WiX\ Toolset\ v3.11/bin/candle.exe -arch x86 gyb.wxs
/c/Program\ Files\ \(x86\)/WiX\ Toolset\ v3.11/bin/light.exe -ext /c/Program\ Files\ \(x86\)/WiX\ Toolset\ v3.11/bin/WixUIExtension.dll gyb.wixobj -o gyb-$GYBVERSION-windows-$PLATFORM.msi || true;
rm *.wixpdb
