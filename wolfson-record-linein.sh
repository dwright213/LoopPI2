#!/bin/bash


### = translate comments to actual physical mixer language

### check this out: 
### http://blog.scphillips.com/posts/2013/01/sound-configuration-on-raspberry-pi-with-alsa/

# $1 added to support 1st line argument. i.e. "./Record_from_linein.sh -q" will stop all the control information being displayed on screen

#Record from onboard Line Input to AP
# +8dB input PGA gain

# amixer $1 -Dhw:audioinjectorpi cset name='IN3L Volume' 8
# amixer $1 -Dhw:audioinjectorpi cset name='IN3R Volume' 8

amixer $1 -Dhw:audioinjectorpi cset name='Capture Volume' 8,8


# better THD in normal mode vs lower noise floor in high performance
### less "Total Harmonic Distortion" 

# amixer $1 -Dhw:audioinjectorpi cset name='IN3 High Performance Switch' on
### a switch that sends both IN3 channels through high and low pass filters.
### so possibly "high performance" means "higher fidelity" here?
### to emulate this lets do the following:

### run our inputs througha high pass filter (to remove mud)
amixer $1 -Dhw:audioinjectorpi cset name='ADC High Pass Filter Switch' on

### and
amixer $1 -Dhw:audioinjectorpi cset name='Playback Deemphasis Switch' on
### run our playback through some active noise cancellation, to remove the 
### high frequency noise.


### Everything below here seems geared towards removing DC offset. Since the
### audioinjector does that by default, let's make double sure we're doing that. 
amixer $1 -Dhw:audioinjectorpi cset name='Store DC Offset Switch' off



# # Configure the input path for 0dB Gain,  HPF with a low cut off for DC removal
# amixer $1 -Dhw:audioinjectorpi cset name='IN3L Digital Volume' 128
# amixer $1 -Dhw:audioinjectorpi cset name='IN3R Digital Volume' 128





# amixer $1 -Dhw:audioinjectorpi cset name='LHPF1 Input 1' IN3L
# amixer $1 -Dhw:audioinjectorpi cset name='LHPF2 Input 1' IN3R
# amixer $1 -Dhw:audioinjectorpi cset name='LHPF1 Mode' High-pass
# amixer $1 -Dhw:audioinjectorpi cset name='LHPF2 Mode' High-pass
# amixer $1 -Dhw:audioinjectorpi cset name='LHPF1 Coefficients' 240,3
# amixer $1 -Dhw:audioinjectorpi cset name='LHPF2 Coefficients' 240,3
# # Configure the Audio Interface and volume 0dB
# amixer $1 -Dhw:audioinjectorpi cset name='AIF1TX1 Input 1' LHPF1
# amixer $1 -Dhw:audioinjectorpi cset name='AIF1TX1 Input 1 Volume' 32
# amixer $1 -Dhw:audioinjectorpi cset name='AIF1TX2 Input 1' LHPF2
# amixer $1 -Dhw:audioinjectorpi cset name='AIF1TX2 Input 1 Volume' 32


# The following command should be used to test
# arecord -Dhw:audioinjectorpi -r 44100 -c 2 -f S32_LE <file>

