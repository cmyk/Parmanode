import os
#from functions import *

file_path = './english.txt'

with open (file_path, 'r') as file:
    seedlist = file.readlines()

print(seedlist[0]) # abandon
print(seedlist[2047]) #zoo

index = 5
print(bin(index)[2:].zfill(11)) #convert to binary, remove prefix, THEN fill to 11 digits (string object)
x = (bin(index)[2:].zfill(11)) 
y = int(x)


def get_binary_seed(decimal_array):
    result = []
    for i in decimal_array:
        result.append(bin(i)[2:].zfill(11))
    print(result)
    
    binseed=''
    for i in result:
        binseed=binseed+i
    
    
    print(binseed)
    return binseed



########################################################################################
# da = []
# da.append(0)
# da.append(2047)

decimal_array = [1,2,3,4,50]
# binary_array = [b'00000000001', b'002']

# print( b'01' + b'01')

# def binary_string_to_int(binary):
#     int(binary)

# print("xxxx")

# b1=int('111000',2)
# for i in range(7):
#     b1+=1
# #    print(bin(b1)[2:])
#     b3=b1.to_bytes(1, 'big')
# #    print(hash256(b3))

########################################################################################

def get_seed_checksum(bin_seed):
    binteger=int(bin_seed,2)
    x=binteger.to_bytes(32, 'big')
#    return hash256(x)

########################################################################################

bin_seed = get_binary_seed(decimal_array)

print('get seed checksum ...')
print(get_seed_checksum(bin_seed))






########################################################################################
# Target practice...

## smooth pizza depart ritual area rare circle call eyebrow surge illegal spoon track beach style trim describe also tiny special lunch zoo zoo arrow
## Bip32 root...
## zpub6traWY6WYEkYrCVByapqUQ3wcJgN18SYjAGPfYpwbTeXHis7QXJKKtQ7fmVmpJX5mqmzMpadEKo7aPDwpXobwvvGHTqNdrd5xwBSoZt9Ayc
## address 0
## bc1q0d686dt96h0yevzz9r7ga9juf27lls9tcm5nj9
## binary seed random...
## 
# 11001100111101001011010011101011010111010100000010110101011001000000101001001001000000110101000101011011010010011100010001101001010011100110100 00010011011110101111101110100010100111011100000001110101110001001111010000111100001010011111111111111111111111000
# 01100101

# change to...

## smooth pizza depart ritual area rare circle call eyebrow surge illegal spoon track beach style trim describe also tiny special lunch abandon abandon antenna 

########################################################################################