function BP_mrf(im, J; n_steps = 10)
    
    thJ = tanh(J/2.0)
    n_edges = 2 * length(size(im))
    
    expand_shape = (n_edges, size(im)...)
    edges_to_pixels = zeros(expand_shape)
    pixels_to_edges = zeros(expand_shape)
    
    h_sum = []
    
    for i in 1:n_steps
        
        # up
        edges_to_pixels[1, 2:end, :] = atanh.( thJ * tanh.( im[1:end-1, :] + pixels_to_edges[1, 1:end-1, :] ) )
        
        # down
        edges_to_pixels[2, 1:end-1, :] = atanh.( thJ * tanh.( im[2:end, :] + pixels_to_edges[2, 2:end, :] ) )
        
        # left
        edges_to_pixels[3, :, 2:end] = atanh.( thJ * tanh.( im[:, 1:end-1] + pixels_to_edges[3, :, 1:end-1] ) )
        
        # right
        edges_to_pixels[4, :, 1:end-1] = atanh.( thJ * tanh.( im[:, 2:end] + pixels_to_edges[4, :, 2:end] ) )
        
        pixels_to_edges, h_sum = compute_pixel_to_factors( edges_to_pixels, im )
        
    end
    
    return h_sum
    
end