"Simple object with no size"
struct Particle{T}
  position::Vector3{T}
  velocity::Vector3{T}
  acceleration::Vector3{T}
  damping::Vector3{T}
  inversemass::T
  forceaccum::Vector{3}     # Accumulated force to be applied at the next simulation iteration only. This value is zeroed at each integration step.
end

"Clear forces applied to particule.  Applied after each intergration step!"
clearaccumulator!(p::Particle) = p.forceaccum = forceAccum.clear()

"Gravitational force"
const G = Vector3{[0.0, 10.0, 0.0]}

function integrate(p::Particle, duration)
  if p.inversemass <= 0.0
    return
  end

  # Update linear position
  p.position += duration .* velocity 

  # Acceleration from force
  resultingacc = p.acceleration .+ inversemass .* forceaccum 

  # Impose drag
  p.velocity *= damping .^ duration

  clearaccumulator!(p)
end
@spec duration > 0.0

