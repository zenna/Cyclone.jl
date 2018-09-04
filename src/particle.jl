"Simple object with no size"
struct Particle{T}
  position::Vector3{T}
  velocity::Vector3{T}
  acceleration::Vector3{T}
  damping::Vector3{T}
  inversemass::T
  forceaccum::Vector3{T}     # Accumulated force to be applied at the next simulation iteration only. This value is zeroed at each integration step.
end

"Clear forces applied to particule.  Applied after each intergration step!"
clearaccumulator!(p::Particle) = fill!(p.forceaccum, 0.0)

"Gravitational force"
const G = Vector3{Float64}([0.0, 10.0, 0.0])

"Integrate dynamics of `p` for `duration`"
function integrate!(p::Particle, duration)
  if p.inversemass <= 0.0
    return p
  end

  # Update linear position
  p.position .+= duration .* p.velocity 

  # Acceleration from force
  resultingacc = p.acceleration .+ p.inversemass .* p.forceaccum 

  # Update linear velocity from the acceleration.
  p.velocity .+= resultingacc .* duration

  # Impose drag
  p.velocity .*= p.damping .^ duration
  
  clearaccumulator!(p)
  p
end
@spec duration > 0.0

# "Non mutating integrate!"
# function integrate(p::Particle, duration)
# end  if p.inversemass < 0.0
#     return p
#   end

#   Particle(p.position .+ duration .* p.velocity,
#            )