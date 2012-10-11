#! /bin/sh
clear
DIR=$1
cd $DIR
echo `pwd`
echo "DIR is "$DIR
PORT=2100
XMFHOME=$DIR
LIB=$XMFHOME
EVALUATOR=$XMFHOME/Images/eval.img
HEAPSIZE=10000
STACKSIZE=50
FREEHEAP=20
MAXJAVAHEAP=-Xmx150m
MAXJAVASTACKSIZE=-Xss2m
VERSION=2.0
XOSFILENAME=Boot/Makefile.o
EVALFILENAME=Boot/BootEval.o
XMFIMAGE=$XMFHOME/Images/xmf.img
SERVERIMAGE=$XMFHOME/Images/server.img
MOSAICFILENAME=Boot/Mosaic/Boot.o
EVALUATORIMAGE=$XMFHOME/Images/eval.img
SERVERFILENAME=Boot/Server/Boot.o
MOSAICMAKEFILENAME=Boot/Makefile.o
XMFFILENAME=Boot/Boot.o


#works
echo "xos.img, derived from xos.bat"
java $MAXJAVAHEAP $MAXJAVASTACKSIZE -cp $LIB XOS.OperatingSystem -port $PORT -image $EVALUATORIMAGE -heapSize $HEAPSIZE -freeHeap $FREEHEAP -stackSize $STACKSIZE -arg filename:$XOSFILENAME -arg user:"$USERNAME" -arg home:"$XMFHOME" -arg license:license.lic -arg projects:"$XMFPROJECTS" -arg doc:"$XMFDOC" -arg version:"$VERSION"
echo "Done xos"
#works
echo "xmf.img, derived from makexmf.bat"
java -cp $LIB XOS.OperatingSystem -port $PORT -initFile $XMFHOME/Boot/Boot.o -heapSize $HEAPSIZE -arg home:$XMFHOME
echo "Done xmf"
#works
echo "eval.img"
java -cp $LIB XOS.OperatingSystem -port $PORT -image $XMFIMAGE -heapSize $HEAPSIZE -arg user:"$USERNAME" -arg home:$XMFHOME -arg license:license.lic -arg filename:$EVALFILENAME
echo "Done eval"
#works
echo "server.img, derived from makexmfs.bat"
java $MAXJAVAHEAP $MAXJAVASTACKSIZE -cp $LIB XOS.OperatingSystem -port $PORT -image $EVALUATORIMAGE -heapSize $HEAPSIZE -freeHeap $FREEHEAP -stackSize $STACKSIZE -arg filename:$SERVERFILENAME -arg user:"$USERNAME" -arg home:"$XMFHOME" -arg license:license.lic -arg projects:"$XMFPROJECTS" -arg doc:"$XMFDOC" -arg version:"$VERSION"
echo "Done server"
#wont work
echo "Makefile mosaic.img"
java $MAXJAVAHEAP -cp $LIB XOS.OperatingSystem -port $PORT -image $SERVERIMAGE -heapSize $HEAPSIZE -freeHeap $FREEHEAP -stackSize $STACKSIZE -arg filename:$MOSAICMAKEFILENAME -arg user:"$USERNAME" -arg home:"$XMFHOME" -arg license:license.lic -arg projects:"$XMFPROJECTS" -arg doc:"$XMFDOC" -arg version:"$VERSION"
echo "Done makefile mosaic"
#works
echo "Compile mosaic.img"
java $MAXJAVAHEAP -cp $LIB XOS.OperatingSystem -port $PORT -image $SERVERIMAGE -heapSize $HEAPSIZE -freeHeap $FREEHEAP -stackSize $STACKSIZE -arg filename:$MOSAICFILENAME -arg user:"$USERNAME" -arg home:"$XMFHOME" -arg license:license.lic -arg projects:"$XMFPROJECTS" -arg doc:"$XMFDOC" -arg version:"$VERSION"
echo "Done mosaic"
