/-
  RobustTrust.Basic
  Smoke test: imports from Mathlib for MeasureTheory, Topology, and Probability.
-/
import Mathlib.MeasureTheory.Measure.ProbabilityMeasure
import Mathlib.Topology.MetricSpace.Basic
import Mathlib.Probability.ProbabilityMassFunction.Basic

-- Smoke test: verify these Mathlib types are accessible
#check MeasureTheory.ProbabilityMeasure
#check MetricSpace
#check PMF
