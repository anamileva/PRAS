function SystemInputStateDistribution(
    dt_idx::Int,
    system::SystemModel{N,L,T,P,E},
    region_distrs::AbstractVector{CapacityDistribution},
    region_samplers::AbstractVector{CapacitySampler},
    interface_distrs::AbstractVector{CapacityDistribution},
    interface_samplers::AbstractVector{CapacitySampler},
    copperplate::Bool=false) where {N,L,T,P,E}

    dt_idxs = [dt_idx]
    vg = view(system.vg, :, dt_idxs)
    load = view(system.load, :, dt_idxs)

    if copperplate
        vg = vec(sum(vg, dims=1))
        load = vec(sum(load, dims=1))
        result = SystemInputStateDistribution{L,T,P,E}(
            region_distrs[1], region_samplers[1], vg, load)
    else
        result = SystemInputStateDistribution{L,T,P,E}(
            system.regions, region_distrs, region_samplers, vg,
            system.interfaces, interface_distrs, interface_samplers, load)
    end

    return result

end
