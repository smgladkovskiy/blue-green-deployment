#!/usr/bin/env bash

. ./colors.sh

fileFromExample() {
    fileName=$1
    replaceFile=false
    if [ -f ${fileName} ]; then
        warn "File \"$fileName\" already exist."
        read -p "Replace it? (y/n)" -n 1 -r
        echo ""

        if [[ $REPLY =~ ^[Yy]$ ]]
        then
            mv ${fileName} ${fileName}.bkp
            info "  Current \"$fileName\" moved to \"$fileName.bkp\"!"
            replaceFile=true
        fi
    else
        warn "File \"$fileName\" not exists."
        read -p "Create it? (y/n)" -n 1 -r
        echo ""

        if [[ $REPLY =~ ^[Yy]$ ]]
        then
            cp ${fileName}.example ${fileName}
            info "  New \"$fileName\" created from example!"
        fi
    fi

    if [ "$replaceFile" = true ] ; then
        cp ${fileName}.example ${fileName}
        success "  New \"$fileName\" created from example!"
    fi
}