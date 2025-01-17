#!/bin/bash

if [ $# -lt 1 ]; then
  echo "Usage: $0 target.exe [buildopts]"
  echo "Check the README for possible targets."
  exit 1
fi

target=$1
shift 1

if [ "$target" = "fdoom.exe" ]; then
  buildopts="-dMODE_Y"
  
elif [ "$target" = "fdoomcga.exe" ]; then
  buildopts="-dMODE_CGA"

elif [ "$target" = "fdoomega.exe" ]; then
  buildopts="-dMODE_EGA"

elif [ "$target" = "fdoombwc.exe" ]; then
  buildopts="-dMODE_CGA_BW"

elif [ "$target" = "fdoomhgc.exe" ]; then
  buildopts="-dMODE_HERC"

elif [ "$target" = "fdoomt1.exe" ]; then
  buildopts="-dMODE_T4025"

elif [ "$target" = "fdoomt12.exe" ]; then
  buildopts="-dMODE_T4050"

elif [ "$target" = "fdoomt25.exe" ]; then
  buildopts="-dMODE_T8025"

elif [ "$target" = "fdoomt43.exe" ]; then
  buildopts="-dMODE_T8043"

elif [ "$target" = "fdoomt50.exe" ]; then
  buildopts="-dMODE_T8050"

elif [ "$target" = "fdoomvbr.exe" ]; then
  buildopts="-dMODE_VBE2"

elif [ "$target" = "fdoomvbd.exe" ]; then
  buildopts="-dMODE_VBE2_DIRECT"

elif [ "$target" = "fdoompcp.exe" ]; then
  buildopts="-dMODE_PCP"

elif [ "$target" = "fdoom400.exe" ]; then
  buildopts="-dMODE_SIGMA"

elif [ "$target" = "fdoomcvb.exe" ]; then
  buildopts="-dMODE_CVB"

elif [ "$target" = "fdoomc16.exe" ]; then
  buildopts="-dMODE_CGA16"

elif [ "$target" = "fdoom512.exe" ]; then
  buildopts="-dMODE_CGA512"

elif [ "$target" = "fdoomcah.exe" ]; then
  buildopts="-dMODE_CGA_AFH"

elif [ "$target" = "fdoom13h.exe" ]; then
  buildopts="-dMODE_13H"

elif [ "$target" = "fdoommda.exe" ]; then
  buildopts="-dMODE_MDA"

elif [ "$target" = "clean" ]; then
  cd FASTDOOM
  wmake clean
  cd ..
  exit 0

else
  echo "Unknown target executable '$target' specified."
  exit 1

fi

cd FASTDOOM
wmake fdoom.exe EXTERNOPT="$buildopts $@"
yes | cp -rf fdoom.exe "../${target^^}"
cd ..
echo "RIP AND TEAR"
exit 0
