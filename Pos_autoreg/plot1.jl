using Gadfly
using DataFrames
using RDatasets

filename = "posAutoData.csv";
frameOfData = readtable(filename)

N_PLOTS = size(frameOfData, 2) / 2

for n = 1 : N_PLOTS
    myPlot = plot(frameOfData[2:end, 2*n-1:2*n], color = "variable", Geom.line)
end
draw(SVG("posAuto.svg", 12inch, 6inch), myPlot)
