import json
import argparse

if __name__ == '__main__':

	parser = argparse.ArgumentParser()
	parser.add_argument('-f1', nargs='?',  const=1, default='',
	                    help='First .json file')  
	parser.add_argument('-f2', nargs='?',  const=1, default='',
	                    help='Second .json file')   
	parser.add_argument('-id_in', nargs='?',  const=1, default='',
	                    help='Datatype id')      
	parser.add_argument('-out', nargs='?',  const=1, default='',
	                    help='Output file')                 
	args = parser.parse_args()

with open(args.f1) as f1:
    config1 = json.load(f1)
    for input in config1["_inputs"]:
        if input["id"] == args.id_in:
             meta = input["meta"]

with open(args.f2) as f2:
    config2 = json.load(f2)
    for key in config2:
        if config2[key] != "null":   #task could be set to null!
            meta[key] = config2[key] 
            print(meta[key])

with open(args.out, 'w') as outfile:
     json.dump(meta, outfile)
