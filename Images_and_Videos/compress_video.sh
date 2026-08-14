ffmpeg -i spotmicro_sim_to_sim.webm -vf "fps=23" -c:v libvpx-vp9 -b:v 0 -crf 30 -row-mt 1 -threads 4 -c:a libopus -b:a 48k spotmicro_sim_to_sim_cmp.webm

