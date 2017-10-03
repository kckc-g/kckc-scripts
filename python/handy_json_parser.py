#!/usr/bin/env python


from __future__ import print_function

import argparse
import json
import sys

class Bunch(dict):
    def __init__(self, input_dict):
        dict.__init__(self, **input_dict)
        self.__dict__ = self
    def __str__(self):
        return json.dumps(self, separators=(',', ': '), indent=True)
    def __repr__(self):
        return self.__str__()


def main(argv, action=None):
    parser = argparse.ArgumentParser()

    parser.add_argument('-f', '--file',         help='Input JSON filename')
    parser.add_argument('-s', '--json-string',  help='Input JSON string')
    parser.add_argument('-o', '--output-file',  help='Output JSON filename, optional')

    args = parser.parse_args()

    if not args.file and not args.json_string or args.file and args.json_string:
        print('[ERROR] specify one of input file (-f) or json string (-s), only one, not both')
        sys.exit(1)

    if args.file:
        with open(args.file) as f:
            decoded = json.load(f, object_hook=Bunch)
    else:
        decoded = json.loads(args.json_string, object_hook=Bunch)


    if action is not None and callable(action):
        if isinstance(decoded, list):
            decoded = [action(d) for d in decoded]
        else:
            decoded = action(decoded)

    if args.output_file:
        with open(args.output_file, 'wb') as f:
            json.dump(decoded, f, separators=(',', ': '), indent=True)
    else:
        print(json.dumps(decoded, separators=(',', ': '), indent=True))

if __name__ == '__main__':
    
    ####### YOUR STUFF #######

    def my_function(item):
        # e.g. item.a.b.c = 10
        return item

    ######################

    main(sys.argv, my_function)
