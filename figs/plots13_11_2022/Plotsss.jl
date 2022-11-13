using Plots, CSV, DataFrames
using StatsPlots
theme(:ggplot2)

nonstiff_benchmark = CSV.read("data/nonstiff_benchmark.csv", DataFrame, header=1)
stiff_benchmark = CSV.read("data/stiff_benchmark.csv", DataFrame, header=1)
harmonic_benchmark = CSV.read("data/harmonic_benchmark.csv", DataFrame, header=1)
random_params_benchmark = CSV.read("data/random_params_benchmark.csv", DataFrame, header=1)

M_SIR = CSV.read(joinpath(matlab_dir, "BenchSIR.csv"), DataFrame, header=0)
M_LV = CSV.read(joinpath(matlab_dir, "BenchLV.csv"), DataFrame, header=0)

J_LV_E1 = CSV.read(joinpath(julia_dir, "LV_E1.csv"), DataFrame, header=1)
J_LV_E2 = CSV.read(joinpath(julia_dir, "LV_E2.csv"), DataFrame, header=1)
J_LV_T1 = CSV.read(joinpath(julia_dir, "LV_T1.csv"), DataFrame, header=1)
J_LV_T2 = CSV.read(joinpath(julia_dir, "LV_T2.csv"), DataFrame, header=1)
DynLV = CSV.read(joinpath(julia_dir, "DynLV.csv"), DataFrame, header=1)

J_SIR_E1 = CSV.read(joinpath(julia_dir, "SIR_E1.csv"), DataFrame, header=1)
J_SIR_E2 = CSV.read(joinpath(julia_dir, "SIR_E2.csv"), DataFrame, header=1)
J_SIR_T1 = CSV.read(joinpath(julia_dir, "SIR_T1.csv"), DataFrame, header=1)
J_SIR_T2 = CSV.read(joinpath(julia_dir, "SIR_T2.csv"), DataFrame, header=1)
# J_SIR_E3 = CSV.read(joinpath(julia_dir,"SIR_E3.csv"), DataFrame, header = 1)
J_SIR_E4 = CSV.read(joinpath(julia_dir, "SIR_E4.csv"), DataFrame, header=1)
# J_SIR_T3 = CSV.read(joinpath(julia_dir,"SIR_T3.csv"), DataFrame, header = 1)
J_SIR_T4 = CSV.read(joinpath(julia_dir, "SIR_T4.csv"), DataFrame, header=1)
J_SIR_E5 = CSV.read(joinpath(julia_dir, "SIR_E5.csv"), DataFrame, header=1)
J_SIR_E6 = CSV.read(joinpath(julia_dir, "SIR_E6.csv"), DataFrame, header=1)
J_SIR_T5 = CSV.read(joinpath(julia_dir, "SIR_T5.csv"), DataFrame, header=1)
J_SIR_T6 = CSV.read(joinpath(julia_dir, "SIR_T6.csv"), DataFrame, header=1)
J_SIR_E7 = CSV.read(joinpath(julia_dir, "SIR_E7.csv"), DataFrame, header=1)
J_SIR_E8 = CSV.read(joinpath(julia_dir, "SIR_E8.csv"), DataFrame, header=1)
J_SIR_E9 = CSV.read(joinpath(julia_dir, "SIR_E9.csv"), DataFrame, header=1)
J_SIR_T7 = CSV.read(joinpath(julia_dir, "SIR_T7.csv"), DataFrame, header=1)
J_SIR_T8 = CSV.read(joinpath(julia_dir, "SIR_T8.csv"), DataFrame, header=1)
J_SIR_T9 = CSV.read(joinpath(julia_dir, "SIR_T9.csv"), DataFrame, header=1)

## plot Examples

p1 = Nothing

for (plot_idx, method) in enumerate(unique(nonstiff_benchmark.Method))
    method_subset = filter(:Method => x -> x == method, nonstiff_benchmark)
    if plot_idx == 1
        p1 = plot(method_subset.ExecutionTime,
            method_subset.Error,
            scale=:log,
            label=method,
            markersize=3,
            shape=:circle,
            title="(a)",
            titleloc=:left,
            titlefont=font(10),
            xlabel="Execution time (sc, Log)",
            ylabel="Error: 2-norm (Log)",
            legendposition=:bottomleft)
    else
        plot!(method_subset.ExecutionTime,
            method_subset.Error,
            label=method,
            markersize=3,
            shape=:circle)
    end
    display(p1)
end

p2 = Nothing

for (plot_idx, method) in enumerate(unique(stiff_benchmark.Method))
    method_subset = filter(:Method => x -> x == method, stiff_benchmark)
    if plot_idx == 1
        p2 = plot(method_subset.ExecutionTime,
            method_subset.Error,
            scale=:log,
            label=method,
            markersize=3,
            shape=:circle,
            title="(b)",
            titleloc=:left,
            titlefont=font(10),
            xlabel="Execution time (sc, Log)",
            ylabel="Error: 2-norm (Log)",
            legendposition=:best)
    else
        plot!(method_subset.ExecutionTime,
            method_subset.Error,
            label=method,
            markersize=3,
            shape=:circle)
    end
    display(p2)
end

p3 = Nothing

for (plot_idx, method) in enumerate(unique(harmonic_benchmark.Method))
    method_subset = filter(:Method => x -> x == method, harmonic_benchmark)
    if plot_idx == 1
        p3 = plot(method_subset.ExecutionTime,
                  method_subset.Error,
                  scale=:log,
                  label=method,
                  markersize=3,
                  shape=:circle,
                  title="(c)",
                  titleloc=:left,
                  titlefont=font(10),
                  xlabel="Execution time (sc, Log)",
                  ylabel="Error: 2-norm (Log)",
                  legendposition=:bottomleft)
    else
        plot!(method_subset.ExecutionTime,
              method_subset.Error,
              label=method,
              markersize=3,
              shape=:circle)
    end
    display(p3)
end

l1 = @layout [[grid(2, 1)] b{0.5w}]
Plt1D = plot(p1, p3, p2,
             layout = l1)
savefig(Plt1D, "Plt1D.svg")
savefig(Plt1D, "Plt1D.png")

plot(J_SIR_T1[:, 1], J_SIR_E1[:, 1], xscale=:log, yscale=:log,
    legend_position=:bottomleft,
    label="J-PC", shape=:circle, thickness_scaling=1, framestyle=:box)
plot!(J_SIR_T2[:, 1], J_SIR_E2[:, 1], label="J-NR", shape=:rect)
plot!(M_SIR[:, 1], M_SIR[:, 5], label="M-PI-EX", shape=:rtriangle)
plot!(M_SIR[:, 3], M_SIR[:, 7], label="M-PI-IM1", shape=:diamond)
plot!(M_SIR[:, 2], M_SIR[:, 6], label="M-PI-PC", shape=:circle)
plot!(M_SIR[:, 4], M_SIR[:, 8], label="M-PI-IM2", shape=:rect, legend=:false)
plot!(J_SIR_T5[:, 1], J_SIR_E5[:, 1], xscale=:log, yscale=:log, label="J-NonLinearAlg", shape=:star5)
plot!(J_SIR_T9[:, 1], J_SIR_E9[:, 1], label="J-PECE", shape=:circle)
plot!(J_SIR_T4[:, 1], J_SIR_E4[:, 1], label="J-PI-EX", shape=:hexagon)
plot!(J_SIR_T6[:, 1], J_SIR_E6[:, 1], label="J-FLMMBDF", shape=:utriangle)
plot!(J_SIR_T7[:, 1], J_SIR_E7[:, 1], label="J-FLMMNewtonG", shape=:dtriangle)
p4 = plot!(J_SIR_T8[:, 1], J_SIR_E8[:, 1], label="J-FLMMTrap", shape=:pentagon,
    ylabel="Error: 2-norm (Log)", xlabel="Execution time (sc, Log)", legendfontsize=6,
    legendposition=:outerbottomright, title="(a)", titleloc=:left, titlefont=font(10))


plot(J_LV_T1[:, 1], J_LV_E1[:, 1], xscale=:log, yscale=:log,
    legend_position=:bottomleft,
    label="J-PC", shape=:circle, thickness_scaling=1, framestyle=:box)
plot!(J_LV_T2[:, 1], J_LV_E2[:, 1], label="J-NR", shape=:rect)
plot!(M_LV[:, 1], M_LV[:, 5], label="M-PI-EX", shape=:rtriangle)
plot!(M_LV[:, 3], M_LV[:, 7], label="M-PI-IM1", shape=:diamond)
plot!(M_LV[:, 2], M_LV[:, 6], label="M-PI-PC", shape=:circle)
p5 = plot!(M_LV[:, 4], M_LV[:, 8], label="M-PI-IM2", shape=:rect,
    ylabel="Error: 2-norm (Log)", xlabel="Execution time (sc, Log)",
    title="(b)", titleloc=:left, titlefont=font(10), legend=:false)

p6 = plot(DynLV[:, 1], Matrix(DynLV[:, 2:4]), xlabel="Time", ylabel="Abundance of species",
    thickness_scaling=1, framestyle=:box, labels=["X1" "X2" "X3"],
    title="(c)", titleloc=:left, titlefont=font(10))

# P=plot(p1, p2, layout = (2, 1),legend_position= (.6,.7) , size = (500, 500))
# P=plot(p1, p2, p3, layout = (2,2) , size = (1000, 1000))

l2 = @layout [b{0.6h}; grid(1, 2)]
# plot(p1, p2, p3,p4, layout = grid(3, 2, widths=[.14 ,0.4, 4,.4]) )
PltMD = plot(p4, p5, p6, layout=l2, size=(600, 500))


#### plot randoms

for (plot_idx, method) in enumerate(unique(random_params_benchmark.Method))
    method_subset = filter(:Method => x -> x == method, random_params_benchmark)
    if plot_idx == 1
        p7 = scatter(method_subset.ExecutionTime,
            method_subset.Error,
            scale=:log,
            label=method,
            markersize=3,
            title="(a)",
            xlabel="Execution time (sc, Log)",
            ylabel="Error: 2-norm (Log)",
            legendposition=:bottomleft)
    else
        scatter!(method_subset.ExecutionTime,
            method_subset.Error,
            label=method,
            markersize=3)
    end
    display(p7)
end

p8 = @df random_params_benchmark boxplot(:Method, :Error,
    yscale=:log,
    ylabel="Error: 2-norm (Log)",
    c=:black,
    fillcolor=:white,
    legend=false,
    title="(b)",
    titleloc=:left,
    titlefont=font(10))

p9 = @df random_params_benchmark boxplot(:Method, :ExecutionTime,
    yscale=:log,
    ylabel="Execution time (sc, Log)",
    c=:black,
    fillcolor=:white,
    legend=false,
    title="(c)",
    titleloc=:left,
    titlefont=font(10))

l3 = @layout [b{0.5w} grid(2, 1)]
PltRnd = plot(p7, p8, p9,
              layout = l3,
              size = (800, 500))
savefig(PltRnd, "PltRnd.png")
savefig(PltRnd, "PltRnd.svg")

savefig(PltMD, "PltMD.svg")
savefig(PltMD, "PltMD.png")
