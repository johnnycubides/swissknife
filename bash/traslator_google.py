#!/usr/bin/env python3
#-*- coding: utf-8 -*

import sys

def corregir(text):
    parrapho = ""
    lines = text.split("\n")
    for i in lines:
        f = i[len(i)-1]
        if f == '-':
            parrapho += i.rstrip('-')
        elif f== '.':
            parrapho += i + '\n'
        else:
            parrapho += i + ' '
    print(parrapho)

corregir(sys.argv[1])
