class Loop {
  LiSa loop;

  fun void init(Gain input) {
    5::second => loop.duration;
    1 => loop.play;
    1 => loop.loop;
    1 => loop.loopRec;
    1 => loop.maxVoices;
    
    int 10 => beatLength;
    input => loop => dac;
  }

  fun void timenow(int avar) {
    <<< avar >>>;
    <<< now >>>;
  }

  fun void record(int status) {
    if (status) { loop.playPos() => loop.recPos; }

    status => loop.record;
  }

  fun void clear() {
    loop.clear();
  }

  fun void volume(float value) {
    (0, value) => loop.voiceGain;
  }

  fun void feedback(float value) {
    value => loop.feedback;
  }
}

// default to MIDI 1, overwrite from STDIN
// midi2 works better with padkontrol -dan
2 => int midiDevice;
if (me.args()) {
  me.arg(0) => Std.atoi => midiDevice;
}

MidiIn midiIn;
MidiMsg msg;

if (!midiIn.open(midiDevice)) {
  <<< "couldn't open midi device ", midiDevice >>>;
  me.exit();
}

Gain inputGain, passThrough;

adc => inputGain;
1   => int loopsCount;

adc => passThrough => dac;

1.0 => inputGain.gain;
1.0 => passThrough.gain;

Loop loop[loopsCount];

for (0 => int i; i < loopsCount; i++) {
  loop[i].init(inputGain);
  loop[i].feedback(1.0);
}

while (true) {
  midiIn => now;

  while (midiIn.recv(msg)) {

    // loop record
    if (msg.data2 == 64) {
      msg.data2 - 64 => int id;
      msg.data3 == 127 => int record;
      loop[id].timenow(21);
      <<< id, "record:", record >>>;
      loop[id].record(record);
        

    }

    // clear
    else if (msg.data2 == 32) {
      msg.data2 - 32 => int id;

      <<< id, " clear" >>>;

      loop[id].clear();
    }




//volume levels
    // main volume
    else if (msg.data2 == 0) {
      msg.data2 => int id;
      msg.data3 $ float / 127.0 => float volume;

      <<< id, " volume:", volume >>>;

      loop[id].volume(volume);
    }

    // feedback
    else if (msg.data2 == 16) {
      msg.data2 - 16 => int id;
      msg.data3 $ float / 127.0 => float feedback;

      <<< id, " feedback:", feedback >>>;

      loop[id].feedback(feedback);
    }

    // input
    else if (msg.data2 == 10) {
      msg.data3 $ float / 127.0 => float vol;

      <<< "input vol: ", vol >>>;

      vol => inputGain.gain;
    }

    // passthrough
    else if (msg.data2 == 73) {
      msg.data3 $ float / 127.0 => float vol;

      <<< "passthrough vol: ", vol >>>;

      vol => passThrough.gain;
    }
  }
}
