#!/usr/bin/env python3

from typing import Dict
from PIL import Image
from argparse import ArgumentParser


class ArgsParser(object):
    def __init__(self) -> None:
        super().__init__()
        self._parser = ArgumentParser()
        self._parser.add_argument("-i", "--input", required=True, type=str, help="PNG files to extract the tileset")
        self._parser.add_argument("-o", "--output", required=True, type=str, help="PNG output file")
        self._args = self._parser.parse_args()

    @property
    def input(self):
        return [file.strip() for file in self._args.input.split(',')]

    @property
    def output(self):
        return self._args.output


class TilesetExtractor(object):
    def __init__(self, input_files) -> None:
        self._input_files = input_files
        self._read_images()

    def _read_images(self):
        pictures: Dict = {}
        for f in self._input_files:
            try:
                img = Image.open(f)
                pictures.update(f, img)
            except:
                print("The file {} doesn't exist".format(f))
        if len(pictures) == 0:
            raise Exception("File not found")
        else:
            print("Ok")


def main():
    args_parser = ArgsParser()
    tileset_extractor = TilesetExtractor(args_parser.input)

if __name__ == '__main__':
    main()
