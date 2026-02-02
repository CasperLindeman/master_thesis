module TrafficNetworks

# Core physics
include("fluxes.jl")

# Model components
include("roads.jl")
include("junctions.jl")
include("boundaries.jl")

# Numerical solver
include("solver.jl")

# High-level network
include("network.jl")

# Utilities
include("utils.jl")

export
    Road,
    Junction,
    RoadNetwork,
    simulate!

end
