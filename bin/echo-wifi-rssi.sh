#!/usr/bin/env bash

while true; do
  /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport --getinfo \
    | grep CtlRSSI \
    | awk '{print $2}'
  sleep 0.5
done
