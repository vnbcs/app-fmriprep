#!/bin/bash

surf=$1
echo "converting surfaces to .gii in $surf"

mris_convert $surf/lh.pial surface-vertices/left/pial.gii
mris_convert $surf/rh.pial surface-vertices/right/pial.gii

mris_convert $surf/lh.white surface-vertices/left/white.gii
mris_convert $surf/rh.white surface-vertices/right/white.gii

mris_convert $surf/lh.inflated surface-vertices/left/inflated.gii
mris_convert $surf/rh.inflated surface-vertices/right/inflated.gii

