#!/bin/bash

# The frequency of Middle C (C4) in Hz
root_frequency=261.63

# An array of interval names
intervals=("minor_second" "major_second" "minor_third" "major_third" "perfect_fourth" "tritone" "perfect_fifth" "minor_sixth" "major_sixth" "minor_seventh" "major_seventh" "octave")

# Generate a tone for each interval
for i in {1..12}
do
  # Calculate the frequency for this interval
  frequency=$(echo "scale=2; e( l($root_frequency) + l(2)*(1/12)*$i )" | bc -l)

  # Generate a 2-second tone for the root note
  sox -n -r 44100 -c 2 root_note.mp3 synth 2 sin $root_frequency

  # Generate a 0.5-second period of silence
  sox -n -r 44100 -c 2 silence.mp3 trim 0.0 0.5

  # Generate a 2-second tone for the interval note
  sox -n -r 44100 -c 2 interval_note.mp3 synth 2 sin $frequency

  # Generate a series of beeps to indicate the number of half-steps in the interval
  for j in $(seq 1 $i)
  do
    sox -n -r 44100 -c 2 beep.mp3 synth 0.1 sin 880
    sox -n -r 44100 -c 2 pause.mp3 trim 0.0 0.2
    if [ $j -eq 1 ]; then
      cp beep.mp3 beeps.mp3
    else
      sox beeps.mp3 beep.mp3 pause.mp3 beeps_new.mp3
      mv beeps_new.mp3 beeps.mp3
    fi
  done

  # Combine the tones, silence, and beeps into one file
  sox root_note.mp3 silence.mp3 interval_note.mp3 silence.mp3 beeps.mp3 "${intervals[$((i-1))]}.mp3"
done

# Remove the temporary files
rm root_note.mp3 silence.mp3 interval_note.mp3 beep.mp3 pause.mp3 beeps.mp3

