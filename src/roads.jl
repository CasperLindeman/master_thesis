module Roads

export Road, make_road, cfl_dt, update_road!

using ..Fluxes: maxwavespeed, godunov_flux

struct Road
    id::Int
    dx::Float64
    rho::Vector{Float64}
end

function make_road(id::Int, L::Float64, N::Int, rho_0::Function)
    dx = L / N
    x = range(dx/2, L - dx/2, length=N)
    rho = [rho_0(xi) for xi in x]
    return Road(id, dx, rho)
end

function cfl_dt(road::Road, CFL::Float64)
    vmax = maximum(maxwavespeed.(road.rho))
    return CFL * road.dx / max(vmax, 1e-12)
end

function update_road!(
    road::Road,
    dt::Float64,
    left_flux::Float64,
    right_flux::Float64
)
    rho = road.rho
    N = length(rho)
    dx = road.dx

    F = similar(rho, N + 1)

    F[1] = left_flux
    @inbounds for i in 2:N
        F[i] = godunov_flux(rho[i-1], rho[i])
    end
    F[N+1] = right_flux

    @inbounds for i in 1:N
        rho[i] -= dt/dx * (F[i+1] - F[i])
    end

    return nothing
end

end # module Roads