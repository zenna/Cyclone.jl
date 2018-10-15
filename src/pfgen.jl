# Particle force generators

"Particle Force Generator"
abstract type ParticleForceGenerator end

struct ParticleForceRegistration{PFG <: ParticleForceGenerator}
  particle::Particle
  fg::PFG
end

const Registry = Vector{ParticleForceGenerator}

function updateforces!(pfr::ParticleForceRegistration, duration)
  foreach
end

# Gravity Force Gen
struct Gravity <: ParticleForceGenerator
  gravity::Vector3{T}
end

function updateforce!(particle::Particle, g::Gravity, duration)
  if !hasfinitemass(particle)
    return
  end
  addforce!(particle, g.gravity * particle.mass)
end

# Drag force generator

struct ParticleDrag{T} <: ParticleForceGenerator
  kl::T
  k2::T
end 

function updateforce!(particle::Particle, d::ParticleDrag, duration)
  Vector3 force;
  particle->getVelocity(&force);

  fm = magnitude(force)
  dragcoeff = k1 * fm + k2 * fm * fm;
  normalize!(force)
  force *= -dragcoeff
  addforce!(particle, force)
end