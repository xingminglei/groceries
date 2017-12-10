#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
Created on Fri Dec  8 14:25:20 2017

@author: Susana
"""

#Import packages pandas & mlxtend 
import pandas as pd
from mlxtend.frequent_patterns import apriori
from mlxtend.frequent_patterns import association_rules
import os

#Defining repository
os.chdir("/Users/Susana/Documents/GitHub/groceries")
print os.getcwd()
 
#Import data
df = pd.read_excel("groceries.xls")
df.head()

#Defining a basket
basket = (df[df[]])