#!/bin/bash

surf=fmripout/freesurfer/sub-TTTEMPSUB/surf

mris_convert $surf/lh.pial surface_left/pial.surf.gii
mris_convert $surf/rh.pial surface_right/pial.surf.gii

mris_convert $surf/lh.white surface_left/white.surf.gii
mris_convert $surf/rh.white surface_right/white.surf.gii

mris_convert $surf/lh.inflated surface_left/inflated.surf.gii
mris_convert $surf/rh.inflated surface_right/inflated.surf.gii

