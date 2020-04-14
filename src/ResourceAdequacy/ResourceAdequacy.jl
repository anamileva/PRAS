@reexport module ResourceAdequacy

using MinCostFlows
using ..PRASBase

import Base: -, broadcastable
import Base.Threads: nthreads, @spawn
import Dates: DateTime, Period
import Decimals: Decimal
import Distributions: DiscreteNonParametric, probs, support
import OnlineStatsBase: EqualWeight, fit!, Mean, value, Variance
import OnlineStats: Series
import Printf: @sprintf
import Random: AbstractRNG, GLOBAL_RNG, MersenneTwister, rand
import StatsBase: stderror
import TimeZones: ZonedDateTime

export

    assess,

    # Metrics
    ReliabilityMetric, LOLP, LOLE, EUE,
    ExpectedInterfaceFlow, ExpectedInterfaceUtilization,
    val, stderror,

    # Simulation specifications
    Classic, Modern,

    # Result specifications
    Minimal, Temporal, SpatioTemporal, Network


abstract type ReliabilityMetric end
abstract type SimulationSpec end
abstract type ResultSpec end
abstract type ResultAccumulator{R<:ResultSpec} end
abstract type Result{
    N, # Number of timesteps simulated
    L, # Length of each simulation timestep
    T <: Period, # Units of each simulation timestep
    SS <: SimulationSpec # Type of simulation that produced the result
} end

MeanVariance = Series{
    Number, Tuple{Mean{Float64, EqualWeight}, Variance{Float64, EqualWeight}}
}

include("metrics/metrics.jl")
include("results/results.jl")
include("simulations/simulations.jl")
include("utils.jl")

end
