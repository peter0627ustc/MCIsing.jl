struct tori
    dim::Int
    size::Int
    volume::Int
    nnb::Int

    spin::Vector{Bool}
    bond::Vector{Bool}
    vs::Vector{Bool}
    Ld::Vector{Int}

    function tori(dim::Int, size::Int)
        volume = size^dim
        nnb = 2 * dim
        spin = zeros(Bool, volume)
        bond = zeros(Bool, 2 * volume)
        vs = zeros(Bool, volume)
        Ld = [size^(i-1) for i in 1:dim+1]
        return new(dim, size, volume, nnb, spin, bond, vs, Ld)
    end
end

function V2V(t::tori, b::Int, k::Int)
    d = t.dim
    ld = t.Ld
    L = t.size
    if b <= d
        bk = b
        j = k + ld[bk]
        xk = mod(k-1, ld[bk+1])
        xk = (xk) ÷ ld[bk]
        j = xk == L-1  ? j - ld[bk+1] : j
    else
        bk = t.nnb + 1 - b
        j = k - ld[bk]
        xk = mod(k-1, ld[bk+1])
        xk = (xk) ÷ ld[bk]
        j = xk == 0 ? j + ld[bk+1] : j
    end
    return j
end



