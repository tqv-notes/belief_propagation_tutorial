function compute_pixel_to_factors(edges_to_pixels, im)
    
    pixels_to_edges = zeros( size(edges_to_pixels) )
    h_sum = dropdims( sum(edges_to_pixels, dims = 1), dims = 1 )
    h_sum = h_sum + im
    
    for idx in 1:size(edges_to_pixels)[1]
        mu_to_px = edges_to_pixels[idx, :, :]
        px_to_mu = pixels_to_edges[idx, :, :]
        px_to_mu[:] = h_sum - mu_to_px
    end
    
    return pixels_to_edges, h_sum
    
end