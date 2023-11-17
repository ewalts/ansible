#!/usr/bin/python3
#######################################################################################################
###> New x python -> scripts/crypt_this.py  -> Initial creation user => eric => 2023-11-16_18:31:32 ###
#######################################################################################################
import sys
import crypt
def my_crypt(plaintext):
    hash = crypt.crypt("plaintext", crypt.METHOD_SHA256)
    return hash

print (my_crypt(sys.argv[1:]))

