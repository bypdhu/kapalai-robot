#!/usr/bin/env python
#-*- coding:utf-8 -*-
"""
This is for user and environment variables.
@editor: bianbian, 
@email : bianyunpeng@ehousechina.com, 
"""

import sys
reload(sys)
sys.setdefaultencoding("utf-8")

import os
import getpass


_FILEPATH = os.path.split(os.path.abspath(__file__))[0]
CURRENT_USER = getpass.getuser()

##################################################################

			# Kapalai-robot: ESS

##################################################################



#####################  用户通用(UserGeneral)  #####################
ESS_Version = '2.0.0'

CaptureImages_Path = unicode(os.path.realpath(os.path.join(_FILEPATH,"..","Results","CaptureImages")))
Resources_Path = unicode(os.path.realpath(os.path.join(_FILEPATH,"..","Resources")))
Scripts_Path = unicode(os.path.realpath(os.path.join(_FILEPATH,"..","Scripts")))
Results_Path = unicode(os.path.realpath(os.path.join(_FILEPATH,"..","Results")))
Variabls_Path = unicode(os.path.realpath(_FILEPATH))

