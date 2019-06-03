
for i in fftSignal noisyFftSignal clearedFftSignal
do
    gnuplot -e    "set terminal png size 1200,800;    set xlabel 'Frequency';    set ylabel 'Intensity';     set grid;    set output '../res/plot_$i.png';    plot '../res/$i.txt' with lines";
    done
for i in sumSignal cosSignal noisySignal clearedSignal
do
    gnuplot -e    "set terminal png size 1200,800;    set xlabel 'Time';    set ylabel 'Value';     set grid;    set output '../res/plot_$i.png';    plot '../res/$i.txt' with lines";
done