struct RoadNetwork
    roads::Vector{Road}
    junctions::Vector{Junction}
    boundaries::Vector{Boundary}
    T::Float64
    CFL::Float64
end
