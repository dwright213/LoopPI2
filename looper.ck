class Loop {
  LiSa loop;

  float beatLength;
  float barLength;
  float bpm;
  
  fun void init(Gain input) {
    6::second => loop.duration;
    1 => loop.play;
    1 => loop.loop;
    1 => loop.loopRec;
    1 => loop.maxVoices;
    
    
    input => loop => dac;
  }

  fun void timenow() {
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
  loop[i].feedback(0);
}

while (true) {
  midiIn => now;

  while (midiIn.recv(msg)) {

    // loop record
    if (msg.data2 == 64) {
      msg.data2 - 64 => int id;
      
      // determine whether "msg.data3 == 127" is true. And if so, 
      // convert "true" to an integer and assign it to a variable
      // named "record" 
      msg.data3 == 127 => int record;

      <<< id, "record:", record >>>;
      loop[id].barLength::second => loop[id].loop.duration;
      <<< "loop duration:", loop[id].loop.duration >>>;

      loop[id].record(record);
      loop[id].loop.loopStart(0::second);
      loop[id].loop.loopEnd(loop[id].barLength::second);
      loop[id].loop.loopEnd(loop[id].barLength::second);

      <<< loop[id].beatLength>>>;
        

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
      <<< "data 1: ", msg.data1  >>>;
      <<< "data 2: ", msg.data2  >>>;
      <<< "data 3: ", msg.data3  >>>;
      <<< id, " volume:", volume >>>;

      loop[id].volume(volume);
    }

    // feedback
/*    else if (msg.data2 == 16) {
      msg.data2 - 16 => int id;
      msg.data3 $ float / 127.0 => float feedback;

      <<< id, " feedback:", feedback >>>;

      loop[id].feedback(feedback);
    }
*/
    // bpm info
    else if (msg.data2 == 16) {
      msg.data2 - 16 => int id;
      //msg.data3 / 60.0 => loop[id].beatLength;

      
      //get our bpm
      msg.data3 => loop[id].bpm;

      //set the number of seconds in a beat
      60 / loop[id].bpm => loop[id].beatLength;

      //in a 4/4 beat we multiply our beatLength by four to get 
      //our bar length. 
      loop[id].beatLength * 4 => loop[id].barLength; 

      //set the loopEnd time with all this new information
      //lets use 2 bars for simplicity's sake.
      loop[id].loop.loopEnd(loop[id].barLength::second);




      <<< msg.data3, " beatlength:", loop[id].beatLength >>>;
      <<< msg.data3, " barlength:", loop[id].barLength >>>;
      <<< msg.data3, " bpm:", loop[id].bpm >>>;

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
