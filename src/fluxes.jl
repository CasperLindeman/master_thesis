@inline flux(rho::Float64) = rho * (1.0 - rho)

@inline dflux(rho::Float64) = 1.0 - 2.0 * rho

@inline function godunov_flux(rho_L::Float64, rho_R::Float64)
    if rho_L <= rho_R
        return min(flux(rho_L), flux(rho_R))
    else
        return max(flux(rho_L), flux(rho_R))
    end
end

@inline demand(rho::Float64) = flux(rho)
@inline supply(rho::Float64) = flux(rho)

@inline maxwavespeed(rho::Float64) = abs(dflux(rho))