module Solvers

export simulate!

using ..RoadNetworks: RoadNetwork
using ..Roads: cfl_dt, update_road!
using ..Boundaries: boundary_flux
using ..Junctions: compute_junction_fluxes

function simulate!(net::RoadNetwork)
    t = 0.0

    roads = net.roads
    junctions = net.junctions
    boundaries = net.boundaries

    nroads = length(roads)

    while t < net.T
        dt = minimum(cfl_dt(r, net.CFL) for r in roads)

        left_flux  = zeros(nroads)
        right_flux = zeros(nroads)

        for b in boundaries
            left_flux[b.road_id] = boundary_flux(b, t)
        end

        for j in junctions
            fin, fout = compute_junction_fluxes(j, roads)

            for (k, rid) in enumerate(j.incoming)
                right_flux[rid] = fin[k]
            end
            for (k, rid) in enumerate(j.outgoing)
                left_flux[rid] = fout[k]
            end
        end

        for i in 1:nroads
            update_road!(roads[i], dt, left_flux[i], right_flux[i])
        end

        t += dt
    end

    return nothing
end

end # module Solvers
