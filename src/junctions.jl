module Junctions

export Junction, compute_junction_fluxes

using ..Roads: Road
using ..Fluxes: demand, supply

struct Junction
    incoming::Vector{Int}
    outgoing::Vector{Int}
end

function compute_junction_fluxes(
    j::Junction,
    roads::Vector{Road}
)
    D = [demand(roads[i].rho[end]) for i in j.incoming]
    S = [supply(roads[i].rho[1])  for i in j.outgoing]

    total_flux = min(sum(D), sum(S))

    fin  = total_flux / length(j.incoming)
    fout = total_flux / length(j.outgoing)

    return fin .* ones(length(j.incoming)),
           fout .* ones(length(j.outgoing))
end

end # module Junctions
