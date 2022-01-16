#!/usr/bin/env python3

from argparse import ArgumentParser
from PIL import Image

MINIMUN_JSON = '''{"__header__":{"app":"LDtk","appAuthor":"Sebastien 'deepnight' Benard","appVersion":"0.9.3","doc":"https://ldtk.io/json","fileType":"LDtk Project JSON","schema":"https://ldtk.io/files/JSON_SCHEMA.json","url":"https://ldtk.io"},"backupLimit":10,"backupOnSave":false,"bgColor":"#40465B","defaultGridSize":TILE_SIZE,"defaultLevelBgColor":"#696A79","defaultLevelHeight":256,"defaultLevelWidth":256,"defaultPivotX":0,"defaultPivotY":0,"defs":{"entities":[],"enums":[],"externalEnums":[],"layers":[{"__type":"IntGrid","autoRuleGroups":AUTO_RULE_GROUPS,"autoSourceLayerDefUid":null,"autoTilesetDefUid":1,"displayOpacity":1,"excludedTags":[],"gridSize":TILE_SIZE,"identifier":"IntGrid","intGridValues":[{"color":"GRID_COLOR","identifier":"GRID_NAME","value":1}],"pxOffsetX":0,"pxOffsetY":0,"requiredTags":[],"tilePivotX":0,"tilePivotY":0,"tilesetDefUid":null,"type":"IntGrid","uid":2}],"levelFields":[],"tilesets":[{"__cHei":5,"__cWid":11,"cachedPixelData":{"averageColors":"fa96fba7fa96f885f996fb97fba7f996fa96fca80000fca7feb8fca7f996fb97fda8fdb8fba7fca8fca70000fa96fba7fa96f885fba7fdb8fda8fb97fca8fca7fba7f885f996f885f784f996fba7fb97f996fa96fca7fca70000000000000000fa96fca8fca8fa96fb9700000000","opaqueTiles":"1111111111011111111110111111111111111111111100001111100"},"customData":[],"enumTags":[],"identifier":"TILESET_NAME","padding":0,"pxHei":TILESET_HEIGHT,"pxWid":TILESET_WIDTH,"relPath":"TILESET_PATH","savedSelections":[],"spacing":0,"tagsSourceEnumUid":null,"tileGridSize":TILE_SIZE,"uid":1}]},"exportTiled":false,"externalLevels":false,"flags":["DiscardPreCsvIntGrid"],"imageExportMode":"None","jsonVersion":"0.9.3","levelNamePattern":"Level_%idx","levels":[{"__bgColor":"#696A79","__bgPos":null,"__neighbours":[],"bgColor":null,"bgPivotX":0.5,"bgPivotY":0.5,"bgPos":null,"bgRelPath":null,"externalRelPath":null,"fieldInstances":[],"identifier":"Level_0","layerInstances":[{"__cHei":TILE_SIZE,"__cWid":TILE_SIZE,"__gridSize":TILE_SIZE,"__identifier":"IntGrid","__opacity":1,"__pxTotalOffsetX":0,"__pxTotalOffsetY":0,"__tilesetDefUid":1,"__tilesetRelPath":"TILESET_PATH","__type":"IntGrid","autoLayerTiles":[],"entityInstances":[],"gridTiles":[],"intGridCsv":[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],"layerDefUid":2,"levelId":0,"optionalRules":[],"overrideTilesetUid":null,"pxOffsetX":0,"pxOffsetY":0,"seed":7087527,"visible":true}],"pxHei":256,"pxWid":256,"uid":0,"useAutoIdentifier":true,"worldX":0,"worldY":0}],"minifyJson":true,"nextUid":3,"pngFilePattern":null,"worldGridHeight":256,"worldGridWidth":256,"worldLayout":"Free"}'''
AUTO_RULE_GROUPS = '''[{"uid":1,"name":"GROUP_NAME","active":true,"collapsed":false,"isOptional":false,"rules":[{"uid":89,"active":true,"size":3,"tileIds":[36],"chance":1,"breakOnMatch":true,"pattern":[0,-1,0,-1,1,-1,0,-1,0],"flipX":false,"flipY":false,"xModulo":1,"yModulo":1,"checker":"None","tileMode":"Single","pivotX":0,"pivotY":0,"outOfBoundsValue":null,"perlinActive":false,"perlinSeed":7260421,"perlinScale":0.2,"perlinOctaves":2},{"uid":104,"active":true,"size":3,"tileIds":[52],"chance":1,"breakOnMatch":true,"pattern":[-1,1,-1,1,1,1,-1,1,-1],"flipX":false,"flipY":false,"xModulo":1,"yModulo":1,"checker":"None","tileMode":"Single","pivotX":0,"pivotY":0,"outOfBoundsValue":null,"perlinActive":false,"perlinSeed":8520870,"perlinScale":0.2,"perlinOctaves":2},{"uid":53,"active":true,"size":3,"tileIds":[4],"chance":1,"breakOnMatch":true,"pattern":[0,-1,0,-1,1,1,0,1,-1],"flipX":false,"flipY":false,"xModulo":1,"yModulo":1,"checker":"None","tileMode":"Single","pivotX":0,"pivotY":0,"outOfBoundsValue":null,"perlinActive":false,"perlinSeed":1030457,"perlinScale":0.2,"perlinOctaves":2},{"uid":94,"active":true,"size":3,"tileIds":[40],"chance":1,"breakOnMatch":true,"pattern":[-1,1,0,1,1,-1,0,-1,0],"flipX":false,"flipY":false,"xModulo":1,"yModulo":1,"checker":"None","tileMode":"Single","pivotX":0,"pivotY":0,"outOfBoundsValue":null,"perlinActive":false,"perlinSeed":7670585,"perlinScale":0.2,"perlinOctaves":2},{"uid":90,"active":true,"size":3,"tileIds":[37],"chance":1,"breakOnMatch":true,"pattern":[0,1,-1,-1,1,1,0,-1,0],"flipX":false,"flipY":false,"xModulo":1,"yModulo":1,"checker":"None","tileMode":"Single","pivotX":0,"pivotY":0,"outOfBoundsValue":null,"perlinActive":false,"perlinSeed":8271837,"perlinScale":0.2,"perlinOctaves":2},{"uid":57,"active":true,"size":3,"tileIds":[7],"chance":1,"breakOnMatch":true,"pattern":[0,-1,0,1,1,-1,-1,1,0],"flipX":false,"flipY":false,"xModulo":1,"yModulo":1,"checker":"None","tileMode":"Single","pivotX":0,"pivotY":0,"outOfBoundsValue":null,"perlinActive":false,"perlinSeed":1966249,"perlinScale":0.2,"perlinOctaves":2},{"uid":95,"active":true,"size":3,"tileIds":[41],"chance":1,"breakOnMatch":true,"pattern":[-1,1,-1,1,1,1,0,-1,0],"flipX":false,"flipY":false,"xModulo":1,"yModulo":1,"checker":"None","tileMode":"Single","pivotX":0,"pivotY":0,"outOfBoundsValue":null,"perlinActive":false,"perlinSeed":7665661,"perlinScale":0.2,"perlinOctaves":2},{"uid":98,"active":true,"size":3,"tileIds":[48],"chance":1,"breakOnMatch":true,"pattern":[0,1,-1,-1,1,1,0,1,-1],"flipX":false,"flipY":false,"xModulo":1,"yModulo":1,"checker":"None","tileMode":"Single","pivotX":0,"pivotY":0,"outOfBoundsValue":null,"perlinActive":false,"perlinSeed":1646797,"perlinScale":0.2,"perlinOctaves":2},{"uid":101,"active":true,"size":3,"tileIds":[51],"chance":1,"breakOnMatch":true,"pattern":[-1,1,0,1,1,-1,-1,1,0],"flipX":false,"flipY":false,"xModulo":1,"yModulo":1,"checker":"None","tileMode":"Single","pivotX":0,"pivotY":0,"outOfBoundsValue":null,"perlinActive":false,"perlinSeed":2918584,"perlinScale":0.2,"perlinOctaves":2},{"uid":58,"active":true,"size":3,"tileIds":[8],"chance":1,"breakOnMatch":true,"pattern":[0,-1,0,1,1,1,-1,1,-1],"flipX":false,"flipY":false,"xModulo":1,"yModulo":1,"checker":"None","tileMode":"Single","pivotX":0,"pivotY":0,"outOfBoundsValue":null,"perlinActive":false,"perlinSeed":8509931,"perlinScale":0.2,"perlinOctaves":2},{"uid":96,"active":true,"size":3,"tileIds":[42],"chance":1,"breakOnMatch":true,"pattern":[-1,1,1,1,1,1,-1,1,-1],"flipX":false,"flipY":false,"xModulo":1,"yModulo":1,"checker":"None","tileMode":"Single","pivotX":0,"pivotY":0,"outOfBoundsValue":null,"perlinActive":false,"perlinSeed":3249859,"perlinScale":0.2,"perlinOctaves":2},{"uid":97,"active":true,"size":3,"tileIds":[43],"chance":1,"breakOnMatch":true,"pattern":[1,1,-1,1,1,1,-1,1,-1],"flipX":false,"flipY":false,"xModulo":1,"yModulo":1,"checker":"None","tileMode":"Single","pivotX":0,"pivotY":0,"outOfBoundsValue":null,"perlinActive":false,"perlinSeed":4875734,"perlinScale":0.2,"perlinOctaves":2},{"uid":83,"active":true,"size":3,"tileIds":[31],"chance":1,"breakOnMatch":true,"pattern":[-1,1,-1,1,1,1,-1,1,1],"flipX":false,"flipY":false,"xModulo":1,"yModulo":1,"checker":"None","tileMode":"Single","pivotX":0,"pivotY":0,"outOfBoundsValue":null,"perlinActive":false,"perlinSeed":4099377,"perlinScale":0.2,"perlinOctaves":2},{"uid":84,"active":true,"size":3,"tileIds":[32],"chance":1,"breakOnMatch":true,"pattern":[-1,1,-1,1,1,1,1,1,-1],"flipX":false,"flipY":false,"xModulo":1,"yModulo":1,"checker":"None","tileMode":"Single","pivotX":0,"pivotY":0,"outOfBoundsValue":null,"perlinActive":false,"perlinSeed":5814836,"perlinScale":0.2,"perlinOctaves":2},{"uid":91,"active":true,"size":3,"tileIds":[38],"chance":1,"breakOnMatch":true,"pattern":[0,1,-1,0,1,1,0,-1,0],"flipX":false,"flipY":false,"xModulo":1,"yModulo":1,"checker":"None","tileMode":"Single","pivotX":0,"pivotY":0,"outOfBoundsValue":null,"perlinActive":false,"perlinSeed":7951,"perlinScale":0.2,"perlinOctaves":2},{"uid":92,"active":true,"size":3,"tileIds":[39],"chance":1,"breakOnMatch":true,"pattern":[-1,1,0,1,1,0,0,-1,0],"flipX":false,"flipY":false,"xModulo":1,"yModulo":1,"checker":"None","tileMode":"Single","pivotX":0,"pivotY":0,"outOfBoundsValue":null,"perlinActive":false,"perlinSeed":343252,"perlinScale":0.2,"perlinOctaves":2},{"uid":78,"active":true,"size":3,"tileIds":[26],"chance":1,"breakOnMatch":true,"pattern":[0,1,-1,-1,1,1,0,0,0],"flipX":false,"flipY":false,"xModulo":1,"yModulo":1,"checker":"None","tileMode":"Single","pivotX":0,"pivotY":0,"outOfBoundsValue":null,"perlinActive":false,"perlinSeed":3153832,"perlinScale":0.2,"perlinOctaves":2},{"uid":81,"active":true,"size":3,"tileIds":[29],"chance":1,"breakOnMatch":true,"pattern":[-1,1,0,1,1,-1,0,0,0],"flipX":false,"flipY":false,"xModulo":1,"yModulo":1,"checker":"None","tileMode":"Single","pivotX":0,"pivotY":0,"outOfBoundsValue":null,"perlinActive":false,"perlinSeed":5712964,"perlinScale":0.2,"perlinOctaves":2},{"uid":64,"active":true,"size":3,"tileIds":[15],"chance":1,"breakOnMatch":true,"pattern":[0,0,0,-1,1,1,0,1,-1],"flipX":false,"flipY":false,"xModulo":1,"yModulo":1,"checker":"None","tileMode":"Single","pivotX":0,"pivotY":0,"outOfBoundsValue":null,"perlinActive":false,"perlinSeed":9377113,"perlinScale":0.2,"perlinOctaves":2},{"uid":69,"active":true,"size":3,"tileIds":[18],"chance":1,"breakOnMatch":true,"pattern":[0,0,0,1,1,-1,-1,1,0],"flipX":false,"flipY":false,"xModulo":1,"yModulo":1,"checker":"None","tileMode":"Single","pivotX":0,"pivotY":0,"outOfBoundsValue":null,"perlinActive":false,"perlinSeed":8040682,"perlinScale":0.2,"perlinOctaves":2},{"uid":55,"active":true,"size":3,"tileIds":[6],"chance":1,"breakOnMatch":true,"pattern":[0,-1,0,1,1,0,-1,1,0],"flipX":false,"flipY":false,"xModulo":1,"yModulo":1,"checker":"None","tileMode":"Single","pivotX":0,"pivotY":0,"outOfBoundsValue":null,"perlinActive":false,"perlinSeed":1782263,"perlinScale":0.2,"perlinOctaves":2},{"uid":54,"active":true,"size":3,"tileIds":[5],"chance":1,"breakOnMatch":true,"pattern":[0,-1,0,0,1,1,0,1,-1],"flipX":false,"flipY":false,"xModulo":1,"yModulo":1,"checker":"None","tileMode":"Single","pivotX":0,"pivotY":0,"outOfBoundsValue":null,"perlinActive":false,"perlinSeed":2919738,"perlinScale":0.2,"perlinOctaves":2},{"uid":77,"active":true,"size":3,"tileIds":[25],"chance":1,"breakOnMatch":true,"pattern":[0,0,0,-1,1,-1,0,-1,0],"flipX":false,"flipY":false,"xModulo":1,"yModulo":1,"checker":"None","tileMode":"Single","pivotX":0,"pivotY":0,"outOfBoundsValue":null,"perlinActive":false,"perlinSeed":2075169,"perlinScale":0.2,"perlinOctaves":2},{"uid":88,"active":true,"size":3,"tileIds":[35],"chance":1,"breakOnMatch":true,"pattern":[0,-1,0,0,1,-1,0,-1,0],"flipX":false,"flipY":false,"xModulo":1,"yModulo":1,"checker":"None","tileMode":"Single","pivotX":0,"pivotY":0,"outOfBoundsValue":null,"perlinActive":false,"perlinSeed":1274370,"perlinScale":0.2,"perlinOctaves":2},{"uid":86,"active":true,"size":3,"tileIds":[33],"chance":1,"breakOnMatch":true,"pattern":[0,-1,0,-1,1,0,0,-1,0],"flipX":false,"flipY":false,"xModulo":1,"yModulo":1,"checker":"None","tileMode":"Single","pivotX":0,"pivotY":0,"outOfBoundsValue":null,"perlinActive":false,"perlinSeed":4789418,"perlinScale":0.2,"perlinOctaves":2},{"uid":52,"active":true,"size":3,"tileIds":[3],"chance":1,"breakOnMatch":true,"pattern":[0,-1,0,-1,1,-1,0,0,0],"flipX":false,"flipY":false,"xModulo":1,"yModulo":1,"checker":"None","tileMode":"Single","pivotX":0,"pivotY":0,"outOfBoundsValue":null,"perlinActive":false,"perlinSeed":9561397,"perlinScale":0.2,"perlinOctaves":2},{"uid":73,"active":true,"size":3,"tileIds":[22],"chance":1,"breakOnMatch":true,"pattern":[0,0,0,-1,1,0,0,-1,0],"flipX":false,"flipY":false,"xModulo":1,"yModulo":1,"checker":"None","tileMode":"Single","pivotX":0,"pivotY":0,"outOfBoundsValue":null,"perlinActive":false,"perlinSeed":8100948,"perlinScale":0.2,"perlinOctaves":2},{"uid":75,"active":true,"size":3,"tileIds":[24],"chance":1,"breakOnMatch":true,"pattern":[0,0,0,0,1,-1,0,-1,0],"flipX":false,"flipY":false,"xModulo":1,"yModulo":1,"checker":"None","tileMode":"Single","pivotX":0,"pivotY":0,"outOfBoundsValue":null,"perlinActive":false,"perlinSeed":7509902,"perlinScale":0.2,"perlinOctaves":2},{"uid":51,"active":true,"size":3,"tileIds":[2],"chance":1,"breakOnMatch":true,"pattern":[0,-1,0,0,1,-1,0,0,0],"flipX":false,"flipY":false,"xModulo":1,"yModulo":1,"checker":"None","tileMode":"Single","pivotX":0,"pivotY":0,"outOfBoundsValue":null,"perlinActive":false,"perlinSeed":4124496,"perlinScale":0.2,"perlinOctaves":2},{"uid":49,"active":true,"size":3,"tileIds":[0],"chance":1,"breakOnMatch":true,"pattern":[0,-1,0,-1,1,0,0,0,0],"flipX":false,"flipY":false,"xModulo":1,"yModulo":1,"checker":"None","tileMode":"Single","pivotX":0,"pivotY":0,"outOfBoundsValue":null,"perlinActive":false,"perlinSeed":6587448,"perlinScale":0.2,"perlinOctaves":2},{"uid":87,"active":true,"size":3,"tileIds":[34],"chance":1,"breakOnMatch":true,"pattern":[0,-1,0,0,1,0,0,-1,0],"flipX":false,"flipY":false,"xModulo":1,"yModulo":1,"checker":"None","tileMode":"Single","pivotX":0,"pivotY":0,"outOfBoundsValue":null,"perlinActive":false,"perlinSeed":2369389,"perlinScale":0.2,"perlinOctaves":2},{"uid":63,"active":true,"size":3,"tileIds":[14],"chance":1,"breakOnMatch":true,"pattern":[0,0,0,-1,1,-1,0,0,0],"flipX":false,"flipY":false,"xModulo":1,"yModulo":1,"checker":"None","tileMode":"Single","pivotX":0,"pivotY":0,"outOfBoundsValue":null,"perlinActive":false,"perlinSeed":9949943,"perlinScale":0.2,"perlinOctaves":2},{"uid":74,"active":true,"size":3,"tileIds":[23],"chance":1,"breakOnMatch":true,"pattern":[0,0,0,0,1,0,0,-1,0],"flipX":false,"flipY":false,"xModulo":1,"yModulo":1,"checker":"None","tileMode":"Single","pivotX":0,"pivotY":0,"outOfBoundsValue":null,"perlinActive":false,"perlinSeed":5078222,"perlinScale":0.2,"perlinOctaves":2},{"uid":62,"active":true,"size":3,"tileIds":[13],"chance":1,"breakOnMatch":true,"pattern":[0,0,0,0,1,-1,0,0,0],"flipX":false,"flipY":false,"xModulo":1,"yModulo":1,"checker":"None","tileMode":"Single","pivotX":0,"pivotY":0,"outOfBoundsValue":null,"perlinActive":false,"perlinSeed":3191372,"perlinScale":0.2,"perlinOctaves":2},{"uid":60,"active":true,"size":3,"tileIds":[11],"chance":1,"breakOnMatch":true,"pattern":[0,0,0,-1,1,0,0,0,0],"flipX":false,"flipY":false,"xModulo":1,"yModulo":1,"checker":"None","tileMode":"Single","pivotX":0,"pivotY":0,"outOfBoundsValue":null,"perlinActive":false,"perlinSeed":5612516,"perlinScale":0.2,"perlinOctaves":2},{"uid":50,"active":true,"size":3,"tileIds":[1],"chance":1,"breakOnMatch":true,"pattern":[0,-1,0,0,1,0,0,0,0],"flipX":false,"flipY":false,"xModulo":1,"yModulo":1,"checker":"None","tileMode":"Single","pivotX":0,"pivotY":0,"outOfBoundsValue":null,"perlinActive":false,"perlinSeed":6915117,"perlinScale":0.2,"perlinOctaves":2},{"uid":100,"active":true,"size":3,"tileIds":[50],"chance":1,"breakOnMatch":true,"pattern":[-1,0,0,0,1,0,-1,0,0],"flipX":false,"flipY":false,"xModulo":1,"yModulo":1,"checker":"None","tileMode":"Single","pivotX":0,"pivotY":0,"outOfBoundsValue":null,"perlinActive":false,"perlinSeed":3512157,"perlinScale":0.2,"perlinOctaves":2},{"uid":99,"active":true,"size":3,"tileIds":[49],"chance":1,"breakOnMatch":true,"pattern":[0,0,-1,0,1,0,0,0,-1],"flipX":false,"flipY":false,"xModulo":1,"yModulo":1,"checker":"None","tileMode":"Single","pivotX":0,"pivotY":0,"outOfBoundsValue":null,"perlinActive":false,"perlinSeed":6895923,"perlinScale":0.2,"perlinOctaves":2},{"uid":82,"active":true,"size":3,"tileIds":[30],"chance":1,"breakOnMatch":true,"pattern":[-1,0,-1,0,1,0,0,0,0],"flipX":false,"flipY":false,"xModulo":1,"yModulo":1,"checker":"None","tileMode":"Single","pivotX":0,"pivotY":0,"outOfBoundsValue":null,"perlinActive":false,"perlinSeed":3411144,"perlinScale":0.2,"perlinOctaves":2},{"uid":70,"active":true,"size":3,"tileIds":[19],"chance":1,"breakOnMatch":true,"pattern":[0,0,0,0,1,0,-1,0,-1],"flipX":false,"flipY":false,"xModulo":1,"yModulo":1,"checker":"None","tileMode":"Single","pivotX":0,"pivotY":0,"outOfBoundsValue":null,"perlinActive":false,"perlinSeed":9465047,"perlinScale":0.2,"perlinOctaves":2},{"uid":71,"active":true,"size":3,"tileIds":[20],"chance":1,"breakOnMatch":true,"pattern":[-1,0,0,0,1,0,0,0,-1],"flipX":false,"flipY":false,"xModulo":1,"yModulo":1,"checker":"None","tileMode":"Single","pivotX":0,"pivotY":0,"outOfBoundsValue":null,"perlinActive":false,"perlinSeed":8998596,"perlinScale":0.2,"perlinOctaves":2},{"uid":59,"active":true,"size":3,"tileIds":[9],"chance":1,"breakOnMatch":true,"pattern":[0,0,-1,0,1,0,-1,0,0],"flipX":false,"flipY":false,"xModulo":1,"yModulo":1,"checker":"None","tileMode":"Single","pivotX":0,"pivotY":0,"outOfBoundsValue":null,"perlinActive":false,"perlinSeed":232519,"perlinScale":0.2,"perlinOctaves":2},{"uid":80,"active":true,"size":3,"tileIds":[28],"chance":1,"breakOnMatch":true,"pattern":[-1,0,0,0,1,0,0,0,0],"flipX":false,"flipY":false,"xModulo":1,"yModulo":1,"checker":"None","tileMode":"Single","pivotX":0,"pivotY":0,"outOfBoundsValue":null,"perlinActive":false,"perlinSeed":7073800,"perlinScale":0.2,"perlinOctaves":2},{"uid":79,"active":true,"size":3,"tileIds":[27],"chance":1,"breakOnMatch":true,"pattern":[0,0,-1,0,1,0,0,0,0],"flipX":false,"flipY":false,"xModulo":1,"yModulo":1,"checker":"None","tileMode":"Single","pivotX":0,"pivotY":0,"outOfBoundsValue":null,"perlinActive":false,"perlinSeed":7118661,"perlinScale":0.2,"perlinOctaves":2},{"uid":68,"active":true,"size":3,"tileIds":[17],"chance":1,"breakOnMatch":true,"pattern":[0,0,0,0,1,0,-1,0,0],"flipX":false,"flipY":false,"xModulo":1,"yModulo":1,"checker":"None","tileMode":"Single","pivotX":0,"pivotY":0,"outOfBoundsValue":null,"perlinActive":false,"perlinSeed":967269,"perlinScale":0.2,"perlinOctaves":2},{"uid":67,"active":true,"size":3,"tileIds":[16],"chance":1,"breakOnMatch":true,"pattern":[0,0,0,0,1,0,0,0,-1],"flipX":false,"flipY":false,"xModulo":1,"yModulo":1,"checker":"None","tileMode":"Single","pivotX":0,"pivotY":0,"outOfBoundsValue":null,"perlinActive":false,"perlinSeed":5379124,"perlinScale":0.2,"perlinOctaves":2},{"uid":61,"active":true,"size":1,"tileIds":[12],"chance":1,"breakOnMatch":false,"pattern":[1],"flipX":false,"flipY":false,"xModulo":1,"yModulo":1,"checker":"None","tileMode":"Single","pivotX":0,"pivotY":0,"outOfBoundsValue":null,"perlinActive":false,"perlinSeed":3234339,"perlinScale":0.2,"perlinOctaves":2}]}]'''
GROUP_NAME = "dirt"
GRID_NAME = "walls"
GRID_COLOR = "#FFFFFF"
TILE_SIZE = 16
TILESET_WIDTH = 16
TILESET_HEIGHT = 16
TILESET_NAME = "tileset"


class ArgsParser(object):
    
    def __init__(self) -> None:
        super().__init__()
        self._parser = ArgumentParser()
        self._parser.add_argument("-t", "--tileset", required=True, type=str, help="Tilesetter image with the tileset")
        self._parser.add_argument("-i", "--inputldtk", required=False, type=str, help="Ldtk file")
        self._parser.add_argument("-tn", "--tilesetname", required=False, type=str, default=TILESET_NAME, help="Tileset name")
        self._parser.add_argument("-gn", "--gridname", required=False, type=str, default=GRID_NAME, help="Grid values name")
        self._parser.add_argument("-gc", "--gridcolor", required=False, type=str, default=GRID_COLOR, help="Grid values color")
        self._parser.add_argument("-grn", "--groupname", required=False, type=str, default=GROUP_NAME, help="Group name")
        self._args = self._parser.parse_args()

    @property
    def tileset(self):
        return self._args.tileset

    @property
    def tileset_name(self):
        return self._args.tilesetname

    @property
    def grid_name(self):
        return self._args.gridname

    @property
    def grid_color(self):
        return self._args.gridcolor

    @property
    def group_name(self):
        return self._args.groupname

    @property
    def input_ldtk(self):
        return self._args.inputldtk


class TilesetReader(object):

    def __init__(self, picture_file) -> None:
        super().__init__()
        self._img_size = -1, -1
        self._tile_size = -1, -1
        self._picture_file = picture_file
        self._read_picture()

    def _read_picture(self):
        self._img = Image.open(self._picture_file)
        self._img_size = self._img.width, self._img.height
        self._tile_size = self._img.width // 11, self._img.height // 5

    @property
    def img_size(self):
        return self._img_size

    @property
    def tile_size(self):
        return self._tile_size


class PlaceholderReplacer(object):
    def __init__(self, arguments, tileset_reader) -> None:
        super().__init__()
        self._arguments = arguments
        self._tileset_reader = tileset_reader
        self._output = self._replace()

    def _replace(self):
        output_str = MINIMUN_JSON
        output_str = output_str.replace("GRID_NAME", self._arguments.grid_name)
        output_str = output_str.replace("GRID_COLOR", self._arguments.grid_color)
        output_str = output_str.replace("TILE_SIZE", str(self._tileset_reader.tile_size[0]))
        output_str = output_str.replace("TILESET_WIDTH", str(self._tileset_reader.img_size[0]))
        output_str = output_str.replace("TILESET_HEIGHT", str(self._tileset_reader.img_size[1]))
        output_str = output_str.replace("TILESET_NAME", self._arguments.tileset_name)
        output_str = output_str.replace("TILESET_PATH", "./" + self._arguments.tileset)
        output_str = output_str.replace("AUTO_RULE_GROUPS", AUTO_RULE_GROUPS)
        output_str = output_str.replace("GROUP_NAME", self._arguments.group_name)
        return output_str

    @property
    def output(self):
        return self._output


class JsonWriter(object):

    def __init__(self, filename, arguments, tileset_reader) -> None:
        super().__init__()
        placeholder_replacer = PlaceholderReplacer(arguments, tileset_reader)
        self._json_string = placeholder_replacer.output
        self._filename = filename
        self._write()

    def _write(self):
        with open(self._filename, "w") as f:
            f.write(self._json_string)
            

def main():
    arguments = ArgsParser()
    tileset_reader = TilesetReader(arguments.tileset)
    
    if arguments.input_ldtk is None:
        # Create a new LDtk file
        JsonWriter("output.ldtk", arguments, tileset_reader)
    else:
        # Append autorules layer to existing file
        pass


if __name__ == '__main__':
    main()
