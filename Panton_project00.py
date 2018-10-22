"""
CS 3800 Fall 2018 Project 00
Alton J. Panton
"""

"""
Reads in the file into a list and removes the white space and makes it lower case
"""
file = [line.strip().lower() for line in open("words.txt", 'r')]
"""
filters out all non 7 letter words
"""
file = [word for word in file if (7 == len(word))]
"""
List of prime numbers used for hash function
"""
prime = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101, 103, 107,
         109, 113, 127, 131, 137, 139, 149, 151, 157, 163, 167, 173, 179, 181, 191, 193, 197, 199, 211, 223, 227, 229,
         233, 239, 241, 251, 257, 263, 269, 271, 277, 281, 283, 293, 307, 311, 313, 317, 331, 337, 347, 349, 353, 359,
         367, 373, 379, 383, 389, 397, 401, 409, 419, 421, 431, 433, 439, 443, 449, 457, 461, 463, 467, 479, 487, 491,
         499, 503, 509, 521, 523, 541]


def hash_function(word):
    """
    Function that takes a string and returns the hash value.
    :rtype: int
    """
    my_hash = 31
    for i in range(0, len(word)):
        my_hash = my_hash * prime[ord('a') - ord(word[i])]
    return my_hash


"""
test
If you mode the hashed value of the list of input strings by each hashed word in the dictionary file and get a result
 of 0. then that word is a subset of the list of input words. 
"""
print(hash_function("alton"))
print(hash_function("notla"))
print(hash_function("alton") % hash_function("ton"))
print(hash_function("alton") % hash_function("notla"))


def find_words(letters):
    """
   CONTRACT: find-words : letters -> String
   PURPOSE: Returns a string of comma delimited dictionary words 7
   letters long and in alphabetical order that can be composed of
   characters in letters. (anagrams of letters) There is no trailing
   comma after the last word in the returned string.
   Each letter in letters may only be used once per match, e.g.
   (find-words '("zymomin" "am")) could return "mammoni, zymomin"
   because "mammoni" is composed of letters in letters including the
   three 'm' characters in letters, and "zymomin" is similarly composed of
   letters in letters. However, "mammomi" could not be
   returned because "mammomi" requires four 'm' characters and
   only three are available in letters.
   CODE:
   """
    s = hash_function("".join(letters))
    return ", ".join(sorted(set([word2 for word2 in file if (s % hash_function(word2) == 0)])))


#test
print(find_words(["zymomin", "omixa"]))
print(find_words(["zer-oommmtre'ymomin", "omixa"]))