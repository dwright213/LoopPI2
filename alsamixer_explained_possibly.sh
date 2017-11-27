numid=1,iface=MIXER,name='Master Playback Volume'
## your master output fader. Takes two values

numid=2,iface=MIXER,name='Master Playback ZC Switch'
## a toggle switch for master output (off == muted)

numid=3,iface=MIXER,name='Capture Volume'
## gain faders for left and right line input channels. Takes two values.

numid=4,iface=MIXER,name='Line Capture Switch'
## switch to arm line inputs for recording

numid=5,iface=MIXER,name='Mic Boost Volume'
## toggle switch to gain the mic up.

numid=6,iface=MIXER,name='Mic Capture Switch'
## switch to arm the mic for recording.

numid=7,iface=MIXER,name='Sidetone Playback Volume'
## Sidetone is your own voice mixed back into the overall audio mix.
## When your favorite rapper is in the booth and says "YO TURN ME UP IN THE HEADPHONES",
## he's asking you to turn this up.

numid=8,iface=MIXER,name='ADC High Pass Filter Switch'
## turns on the high pass filter on our ADC. Probably used to make sound less muddy.
## Apparently not adjustable.

numid=9,iface=MIXER,name='Store DC Offset Switch'
## a toggle switch that keeps "DC offset", if there is any in the recording. 
## Usually we want this off.

numid=10,iface=MIXER,name='Playback Deemphasis Switch'
## a toggle switch to basically apply active noise cancellation to the playback channel(s).

numid=11,iface=MIXER,name='Output Mixer Line Bypass Switch'
## Basically a mute button for our line inputs(?)

numid=12,iface=MIXER,name='Output Mixer Mic Sidetone Switch'
## toggle mic on or off in output mix

numid=13,iface=MIXER,name='Output Mixer HiFi Playback Switch'
## same as numid=8 only this applies it to playback

numid=14,iface=MIXER,name='Input Mux'
## switches input mix channels, between "Line In" and "Mic"
