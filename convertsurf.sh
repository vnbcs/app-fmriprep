#!/bin/bash

surf=fmripout/freesurfer/sub-TTTEMPSUB/surf

mris_convert $surf/lh.pial surface/left_pial.surf.gii
mris_convert $surf/rh.pial surface/right_pial.surf.gii

mris_convert $surf/lh.white surface/left_white.surf.gii
mris_convert $surf/rh.white surface/right_white.surf.gii

mris_convert $surf/lh.inflated surface/left_inflated.surf.gii
mris_convert $surf/rh.inflated surface/right_inflated.surf.gii

