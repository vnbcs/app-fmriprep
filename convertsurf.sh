#!/bin/bash

surf=fmripout/freesurfer/sub-TTTEMPSUB/surf

mris_convert $surf/lh.pial surface/L.pial.surf.gii
mris_convert $surf/rh.pial surface/R.pial.surf.gii

mris_convert $surf/lh.white surface/L.white.surf.gii
mris_convert $surf/rh.white surface/R.white.surf.gii

mris_convert $surf/lh.inflated surface/L.inflated.surf.gii
mris_convert $surf/rh.inflated surface/R.inflated.surf.gii

