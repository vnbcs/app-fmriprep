#!/usr/bin/env python3

import json
import pandas as pd
import matplotlib.colors
import numpy as np

def create_parc_json():

    labels_df = pd.read_csv('labels.tsv',sep='\t')
    unique_labels = [ f for f in np.unique(labels_df.index.tolist()) ]

    labels = []
    for i in unique_labels:
        tmp = {}
        tmp_data = labels_df.loc[labels_df['index'] == int(i)]
        if len(tmp_data) == 0:
            color_rgb = np.random.random_integers(0, 255, 3)
            tmp['name'] = 'removed/unused/nonsense label'
            tmp['label'] = str(i)
            tmp['voxel_value'] = int(i)
        else:
            tmp['name'] = str(tmp_data['name'].values[0])
            tmp['label'] = str(i)
            tmp['voxel_value'] = int(i)
            color_hex = tmp_data['color'].values[0]
            color_rgb = [int(256*f) for f in list(matplotlib.colors.to_rgb(color_hex)) ]

        tmp['r'] = int(color_rgb[0])
        tmp['g'] = int(color_rgb[1])
        tmp['b'] = int(color_rgb[2])
        labels.append(tmp)

    with open('./parcellation/label.json','w') as labels_f:
        json.dump(labels,labels_f,indent=4)

if __name__ == '__main__':
    create_parc_json()
