#!/usr/bin/env python3

from argparse import ArgumentParser
import json


class ArgsParser(object):
    
    def __init__(self) -> None:
        super().__init__()
        self._parser = ArgumentParser()
        self._parser.add_argument("-i", "--input", required=True, type=str, help="Ldtk file with the entities to copy")
        self._parser.add_argument("-o", "--output", required=True, type=str, help="Target Ldtk file")
        self._args = self._parser.parse_args()

    @property
    def input(self):
        return self._args.input

    @property
    def output(self):
        return self._args.output


class EntityFinder(object):

    def __init__(self, input_file) -> None:
        super().__init__()
        self._input_file = input_file
        self._read()

    def _read(self):
        with open(self._input_file, 'r') as f:
            json_data = json.load(f)
            self._entities = json_data['defs']['entities']

    @property
    def entities(self):
        return self._entities


class EntityWriter(object):

    def __init__(self, output_file, entities) -> None:
        super().__init__()
        self._output_file = output_file
        self._entities = entities
        self._write_json()

    def _write_json(self):
        json_data = None
        with open(self._output_file, 'r') as f:
            json_data = json.load(f)
            json_data['defs']['entities'] = self._entities

        with open(self._output_file, 'w') as output:
            json.dump(json_data, output, indent=4)


def main():
    args = ArgsParser()
    entity_finder = EntityFinder(args.input)
    EntityWriter(args.output, entity_finder.entities)


if __name__ == '__main__':
    main()
