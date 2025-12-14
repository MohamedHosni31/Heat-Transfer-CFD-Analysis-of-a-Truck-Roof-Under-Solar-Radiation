🚛 Solar Heat Transfer & Aerodynamic Analysis of a Truck Roof (CFD + Empirical Study)

This repository contains the full workflow and results of a group mechanical engineering project that investigates forced convection heat transfer and aerodynamic effects on a truck roof exposed to solar radiation.

The project combines numerical CFD simulations and empirical heat transfer correlations, with a strong focus on model validation, mesh independence, and result comparison.

Role: Team Leader
Project Type: Group Academic Project
Field: Heat Transfer · CFD · External Flow Analysis

📌 Project Objectives

Analyze surface temperature distribution along a truck roof under solar loading.

Evaluate the effect of vehicle speed on:

Local surface temperature (Ts, local)

Average surface temperature (Ts, avg)

Average convection coefficient (h, avg)

Friction force (Fd)

Skin friction coefficient (Cd, avg)

Perform a mesh independence study to ensure numerical accuracy.

Validate CFD results using empirical heat transfer and friction correlations.

🧠 Methodology Overview
1️⃣ Numerical Analysis (CFD)

Geometry and fluid domain created in ANSYS Discovery

Meshing performed with multiple refinement levels:

Coarse mesh

Medium mesh

Fine mesh (final selection)

Simulations carried out in ANSYS Fluent

Turbulent external flow with heat transfer

Post-processing of:

Temperature distributions

Heat transfer coefficients

Aerodynamic forces

2️⃣ Empirical Modeling

Analytical model developed using Engineering Equation Solver (EES)

Based on classical correlations for:

Turbulent flat-plate convection

Skin friction coefficient

Parametric analysis over multiple velocities

3️⃣ Validation & Comparison

Numerical vs empirical comparison for:

Ts local vs x

Ts avg and h avg vs velocity

Friction force and Cd vs velocity

Error metrics:

Absolute error

Percentage error

Mean Error

Mean Absolute Percentage Error (MAPE)

📊 Key Results

Fine mesh provided the best balance of accuracy and result stability.

CFD results showed strong agreement with empirical solutions:

Ts local MAPE ≈ low single-digit percentage

Ts avg error decreased with increasing velocity

Heat transfer coefficient trends matched theoretical expectations.

Aerodynamic forces increased non-linearly with velocity, consistent with external flow theory.
