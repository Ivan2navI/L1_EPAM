#!/bin/bash 

#case "$OSTYPE" in
#  solaris*) echo "SOLARIS" ;;
#  darwin*)  echo "OSX" ;; 
#  linux*)   echo "LINUX" ;;
#  bsd*)     echo "BSD" ;;
#  msys*)    echo "WINDOWS" ;;
#  cygwin*)  echo "ALSO WINDOWS" ;;
#  *)        echo "unknown: $OSTYPE" ;;
#esac

RELISE=`( lsb_release -ds || cat /etc/*release || uname -om ) 2>/dev/null | head -n1`

echo "OS Version =>" $RELISE


case "$RELISE" in
  Ubuntu* | Debian*) echo "UBUNTU or DEBIAN" ;;
  *)        echo "unknown: $RELISE" ;;
esac


case "$RELISE" in
  Ubuntu*) echo "UBUNTU" ;;
  Debian*)  echo "DEBIAN" ;; 
  *)        echo "unknown OS: $RELISE" ;;
esac
