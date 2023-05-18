#!/bin/sh

while true; do
    ADDRESS="$(lsusb | perl -nE 'if (/^Bus (\d+) Device (\d+):.*USB2IIC_CTP_CONTROL/) { say "$1:$2"; exit 1; }')" \
    || usbhid-dump \
        --stream-timeout=0 \
        --entity=stream \
        --address="$ADDRESS" 2>/dev/null \
    | perl -nE '
        sub DE {
            $_[7] == 48 ? " $_[1] ".($_[3]+$_[4]*256)." ".($_[5]+$_[6]*256)."\n" : ();
        }
        if (/^[\d:]+:STREAM \s* ([\d\.]+)$/) {
            say ":$1";
            @data=();
        } elsif (/^( [\dA-F]{2})+$/i) {
            @a = map {hex} split / /, $_;
            shift @a;
            push @data, @a;
        } elsif (/^$/) {
            say join "", map {DE(@data[$_*8 .. $_*8+7])} (0..5);
        }
        BEGIN {
            say "*connect";
        }
        END {
            say ":".(time()+1);
            say DE((0)x7,48);
            say "*disconnect";
        }
    '
    sleep 2
done

