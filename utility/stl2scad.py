#!/usr/bin/python
# -*- coding: utf-8 -*-

""" STL to SCAD converter.

This code is based on Riham javascript code.
See http://www.thingiverse.com/thing:62666

Ascii STL file:

solid _40x10
    facet normal 0.000000e+000 0.000000e+000 1.000000e+000
        outer loop
            vertex 1.286803e+001 2.957990e+001 1.200000e+001
            vertex 1.173648e+001 2.984808e+001 1.200000e+001
            vertex 1.115715e+001 2.953001e+001 1.200000e+001
        endloop
    endfacet
    facet normal 0.000000e+000 0.000000e+000 1.000000e+000
        outer loop
            vertex 1.115715e+001 2.953001e+001 1.200000e+001
            vertex 1.173648e+001 2.984808e+001 1.200000e+001
            vertex 1.058145e+001 2.998308e+001 1.200000e+001
        endloop
    endfacet
    ...
ensolid

Binary STL file:

"""

import re
import sys
import struct
import os.path


def parseAscii(inputFile):
    """
    """
    inputFile.seek(0)
    inputStr = inputFile.read()

    modules = []

    solidName = None
    vertices = None
    triangles = None
    triangle = None

    for solidStr in re.findall(r"solid\s(.*?)endsolid", inputStr, re.S):
        solidName = re.match(r"^(.*)$", solidStr, re.M).group(0)
        print "Processing object %s..." % solidName
        vertices = []
        triangles = []
        for facetStr in re.findall(r"facet\s(.*?)endfacet", solidStr, re.S):
            for outerLoopStr in re.findall(r"outer\sloop(.*?)endloop", facetStr, re.S):
                triangle = []
                for vertexStr in re.findall(r"vertex\s(.*)$", outerLoopStr, re.M):
                    vertex = [float(coord) for coord in vertexStr.split()]
                    try:
                        triangle.append(vertices.index(vertex))
                    except ValueError:
                        vertices.append(str(vertex))
                        triangle.append(len(vertices) - 1)
            triangles.append(str(triangle))
        modules.append((solidName, vertices, triangles))

        return modules


def parseBinary(inputFile, solidName="stl2scad"):
    """
    """

    # Skip header
    inputFile.seek(80)

    nbTriangles = struct.unpack("<I", inputFile.read(4))[0]
    print "found %d triangles" % nbTriangles

    modules = []
    vertices = []
    triangles = []

    triangle = None

    # Iterate over triangles
    for i in range(nbTriangles):
        triangle = []

        # Skip normal vector (3x uint32)
        inputFile.seek(3*4, 1)

        # Iterate over vertices
        for j in range(3):
            vertex = struct.unpack("<fff", inputFile.read(3*4))
            #print repr(s), repr(vertex)
            try:
                triangle.append(vertices.index(vertex))
            except ValueError:
                vertices.append(str(list(vertex)))
                triangle.append(len(vertices) - 1)

        triangles.append(str(triangle))

        # Skip byte count
        inputFile.seek(2, 1)

    modules.append((solidName, vertices, triangles))

    return modules


def convert(outputFile, modules):
    """
    """
    for solidName, vertices, triangles in modules:
        points_ = ",\n\t\t\t".join(vertices)
        triangles_ = ",\n\t\t\t".join(triangles)
        module = "module %s() {\n\tpolyhedron(\n\t\tpoints=[\n\t\t\t%s\n\t\t],\n\t\ttriangles=[\n\t\t\t%s\n\t\t]\n\t);\n}\n\n\n%s();\n" % (solidName, points_, triangles_, solidName)
        outputFile.write(module)

    outputFile.close()


def main():
    inputFileName = sys.argv[1]
    inputFile = file(inputFileName)

    # Check if ascii or binary
    if inputFile.read(5) == "solid":
        print "ascii file"
        modules = parseAscii(inputFile)
    else:
        print "binary file"
        modules = parseBinary(inputFile)

    outputFileName = "%s%s%s" % (os.path.splitext(inputFileName)[0], os.path.extsep, "scad")
    outputFile = file(outputFileName, "w")
    convert(outputFile, modules)

    print "%s saved" % outputFileName


if __name__ == "__main__":
    main()
