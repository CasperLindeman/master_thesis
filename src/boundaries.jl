struct Boundary
    road_id::Int
    inflow::Function
end

@inline function boundary_flux(b::Boundary, t::Float64)
    return b.inflow(t)
end
