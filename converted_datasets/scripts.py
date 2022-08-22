
import os, codecs

import sys
reload(sys)
sys.setdefaultencoding('utf8')

files = [os.path.join(dp, f) for dp, dn, filenames in os.walk('./') for f in filenames if os.path.splitext(f)[1] == '.txt']
for f in files:
    nFile = f[:f.find('.txt')] + '_utf' + f[f.find('.txt'):]
    open(nFile, 'w').write(" ".join([str(ord(c)) for c in  open(f, 'r').read().decode("utf-8")]))
    print "[SUCCESS]", nFile
