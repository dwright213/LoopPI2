#!/usr/bin/env bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
pushd $DIR

./wolfson-record-linein.sh
./wolfson-output-lineout.sh

DAC=$(./find-device.sh "audioinjectorpi")
ADC=$(./find-device.sh "audioinjectorpi")
MIDI=$(./find-device.sh "padKONTROL")

$CHUCK --dac:$DAC --adc:$ADC --in:1 --out:2 looper.ck
