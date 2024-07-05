function generate_synthetic_data(; l_x = 128, seed = 1234, n_pts = 25, ndim = 2)
    # generate synthetic binary data with blob-like objects
   
   rs = MersenneTwister(seed)
   x = 1:l_x
   y = 1:l_x
   mask = zeros(l_x, l_x)
   points = Int.( ceil.( l_x * rand( rs, Float64, (2, n_pts) ) ) )
   
   for idx in 1:n_pts
       mask[points[1,idx], points[2,idx]] = 1.0
   end
   
   mask = imfilter( mask, Kernel.gaussian( l_x / (4*sqrt(n_pts)) ) )
   mask = mask .> mean(mask)
   
   return Float64.(mask)
   
end