using Cyclone: Particle, Vector3, integrate!
using Test

function testcyclone()
  p = 
  particle = Particle(ones(Vector3{Float64}),
                      ones(Vector3{Float64}),
                      ones(Vector3{Float64}),
                      ones(Vector3{Float64}),
                      1.0,
                      ones(Vector3{Float64}))
  integrate!(particle, 2.0)
  particle
end

testcyclone()