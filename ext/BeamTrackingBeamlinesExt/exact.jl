@inline function pure_patch(tm::Exact, bunch, patchparams, L) 
  tilde_m, gamsqr_0, beta_0 = ExactTracking.drift_params(bunch.species, bunch.Brho_ref[])
  winv = ExactTracking.w_inv_matrix(patchparams.dx_rot, patchparams.dy_rot, patchparams.dz_rot)
  return KernelCall(ExactTracking.patch!, (beta_0, gamsqr_0, tilde_m, patchparams.dt, patchparams.dx, patchparams.dy, patchparams.dz, winv, L))
end

@inline function thick_pure_bsolenoid(tm::Exact, bunch, bm0, L)
  Ksn, Kss = get_strengths(bm0, L, bunch.Brho_ref[])
  Ks = sqrt(Ksn^2 + Kss^2)
  tilde_m, gamsqr_0, beta_0 = ExactTracking.drift_params(bunch.species, bunch.Brho_ref[])
  return KernelCall(ExactTracking.exact_solenoid!, (Ks, beta_0, gamsqr_0, tilde_m, L))
end

@inline function drift(tm::Exact, bunch, L)
  tilde_m, gamsqr_0, beta_0 = ExactTracking.drift_params(bunch.species, bunch.Brho_ref[])
  return KernelCall(ExactTracking.exact_drift!, (beta_0, gamsqr_0, tilde_m, L))
end