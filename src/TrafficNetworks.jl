module TrafficNetworks

# Core physics
include("fluxes.jl")
using .Fluxes

# Model components
include("roads.jl")
using .Roads: Road, make_road, cfl_dt, update_road!

include("junctions.jl")
using .Junctions: Junction, compute_junction_fluxes

include("boundaries.jl")
using .Boundaries: Boundary, boundary_flux

# High-level network
include("road_network.jl")
using .RoadNetworks: RoadNetwork

# Numerical solver
include("solver.jl")
using .Solvers: simulate!

# Utilities
include("utils.jl")
using .Utils: clamp01

export
    Road,
    Junction,
    Boundary,
    RoadNetwork,
    simulate!,
    make_road,
    clamp01

end
