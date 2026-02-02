module Utils

export clamp01

@inline clamp01(x::Float64) = min(max(x, 0.0), 1.0)

end # module Utils
