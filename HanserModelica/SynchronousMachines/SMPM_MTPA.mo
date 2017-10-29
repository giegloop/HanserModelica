within HanserModelica.SynchronousMachines;
model SMPM_MTPA "Test example: PermanentMagnetSynchronousMachine fed by current source"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter Integer m=3 "Number of phases";
  parameter Modelica.SIunits.Voltage VNominal=100
    "Nominal RMS voltage per phase";
  parameter Modelica.SIunits.Frequency fNominal=50 "Nominal frequency";
  parameter Modelica.SIunits.Frequency f=50 "Actual frequency";
  parameter Modelica.SIunits.Time tRamp=1 "Frequency ramp";
  parameter Modelica.SIunits.Torque TLoad=181.4 "Nominal load torque";
  parameter Modelica.SIunits.Time tStep=1.2 "Time of load torque step";
  parameter Modelica.SIunits.Inertia JLoad=0.29 "Load's moment of inertia";
  parameter Modelica.SIunits.AngularVelocity wNominal = 2*pi*fNominal/smpmData.p "Nominal angular velocity";
  Modelica.SIunits.Angle thetaQS=rotorAngleQS.rotorDisplacementAngle "Rotor displacement angle, quasi stastic";

  parameter
    Modelica.Electrical.Machines.Utilities.ParameterRecords.SM_PermanentMagnetData
    smpmData(useDamperCage=false, effectiveStatorTurns=64,
    fsNominal=fNominal,
    TsRef=373.15,
    Lmd=0.1/(2*pi*fNominal),
    Lmq=0.3/(2*pi*fNominal))      "Machine data"
    annotation (Placement(transformation(extent={{80,72},{100,92}})));
  Modelica.Magnetic.QuasiStatic.FundamentalWave.BasicMachines.SynchronousMachines.SM_PermanentMagnet
    smpmQS(
    p=smpmData.p,
    fsNominal=smpmData.fsNominal,
    Rs=smpmData.Rs,
    TsRef=smpmData.TsRef,
    Lssigma=smpmData.Lssigma,
    Jr=smpmData.Jr,
    Js=smpmData.Js,
    frictionParameters=smpmData.frictionParameters,
    wMechanical(fixed=true),
    statorCoreParameters=smpmData.statorCoreParameters,
    strayLoadParameters=smpmData.strayLoadParameters,
    VsOpenCircuit=smpmData.VsOpenCircuit,
    Lmd=smpmData.Lmd,
    Lmq=smpmData.Lmq,
    useDamperCage=smpmData.useDamperCage,
    Lrsigmad=smpmData.Lrsigmad,
    Lrsigmaq=smpmData.Lrsigmaq,
    Rrd=smpmData.Rrd,
    Rrq=smpmData.Rrq,
    TrRef=smpmData.TrRef,
    permanentMagnetLossParameters=smpmData.permanentMagnetLossParameters,
    phiMechanical(fixed=true, start=0),
    m=m,
    TsOperational=293.15,
    alpha20s=smpmData.alpha20s,
    effectiveStatorTurns=smpmData.effectiveStatorTurns,
    alpha20r=smpmData.alpha20r,
    TrOperational=293.15) annotation (Placement(transformation(extent={{0,10},{20,30}})));

  Modelica.Mechanics.Rotational.Sources.ConstantSpeed
    quadraticSpeedDependentTorqueQS(w_fixed=wNominal)
    annotation (Placement(transformation(extent={{100,10},{80,30}})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star
    starMachineQS(m=
        Modelica.Electrical.MultiPhase.Functions.numberOfSymmetricBaseSystems(
                                                                     m))
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-20,20})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground
    groundMQS annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-50,10})));
  Modelica.Magnetic.QuasiStatic.FundamentalWave.Utilities.MultiTerminalBox
    terminalBoxQS(terminalConnection="Y", m=m) annotation (Placement(
        transformation(extent={{0,26},{20,46}})));
  Modelica.Magnetic.QuasiStatic.FundamentalWave.Utilities.CurrentController currentControllerQS(m=m, p=smpmQS.p) annotation (Placement(transformation(extent={{-40,80},{-20,100}})));
  Modelica.Mechanics.Rotational.Sensors.AngleSensor angleSensorQS
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={40,60})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Sources.ReferenceCurrentSource referenceCurrentSourceQS(m=m) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={10,90})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star starQS(m=m)
    annotation (Placement(transformation(
        origin={60,90},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground
    groundeQS annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={60,70})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Resistor resistorQS(m=m, R_ref=fill(1e5, m)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={30,90})));
  Modelica.Magnetic.QuasiStatic.FundamentalWave.Sensors.RotorDisplacementAngle rotorAngleQS(m=m, p=smpmData.p) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={40,20})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.CurrentQuasiRMSSensor currentRMSSensorQS(m=m) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={10,60})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.VoltageQuasiRMSSensor voltageQuasiRMSSensorQS(m=m) annotation (Placement(transformation(extent={{-30,60},{-10,40}})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star starMQS(m=m) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-40,40})));
  Modelica.ComplexBlocks.Sources.ComplexRotatingPhasor rotSource(magnitude=100, w=2*pi) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-80,30})));
  Modelica.ComplexBlocks.ComplexMath.ComplexToReal complexToReal annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-80,60})));
equation
  connect(starMachineQS.plug_p, terminalBoxQS.starpoint) annotation (
      Line(
      points={{-10,20},{-10,32},{0,32}},
      color={85,170,255}));
  connect(groundMQS.pin, starMachineQS.pin_n) annotation (Line(
      points={{-50,20},{-30,20}},
      color={85,170,255}));
  connect(terminalBoxQS.plug_sn, smpmQS.plug_sn) annotation (Line(
      points={{4,30},{4,30}},
      color={85,170,255}));
  connect(terminalBoxQS.plug_sp, smpmQS.plug_sp) annotation (Line(
      points={{16,30},{16,30}},
      color={85,170,255}));
  connect(currentControllerQS.I, referenceCurrentSourceQS.I) annotation (Line(points={{-19,94},{-10,94},{-10,96},{-2,96}},
                                                                                                          color={85,170,255}));
  connect(referenceCurrentSourceQS.plug_p, starQS.plug_p) annotation (Line(points={{10,100},{60,100}},          color={85,170,255}));
  connect(starQS.pin_n, groundeQS.pin) annotation (Line(
      points={{60,80},{60,80}},
      color={85,170,255}));
  connect(angleSensorQS.flange, smpmQS.flange) annotation (Line(
      points={{40,50},{40,40},{30,40},{30,20},{20,20}}));
  connect(referenceCurrentSourceQS.plug_p, resistorQS.plug_p) annotation (Line(points={{10,100},{30,100}},          color={85,170,255}));
  connect(resistorQS.plug_n, referenceCurrentSourceQS.plug_n) annotation (Line(points={{30,80},{10,80}},           color={85,170,255}));
  connect(currentControllerQS.gamma, referenceCurrentSourceQS.gamma) annotation (Line(points={{-19,86},{-10,86},{-10,84},{-2,84}},
                                                                                                                  color={0,0,127}));
  connect(angleSensorQS.phi, currentControllerQS.phi) annotation (Line(points={{40,71},{40,74},{-30,74},{-30,78}}, color={0,0,127}));
  connect(smpmQS.flange, rotorAngleQS.flange) annotation (Line(points={{20,20},{30,20}}, color={0,0,0}));
  connect(terminalBoxQS.plug_sp, rotorAngleQS.plug_p) annotation (Line(points={{16,30},{34,30}},color={85,170,255}));
  connect(terminalBoxQS.plugSupply, currentRMSSensorQS.plug_n) annotation (Line(points={{10,32},{10,50}},   color={85,170,255}));
  connect(currentRMSSensorQS.plug_p, referenceCurrentSourceQS.plug_n) annotation (Line(points={{10,70},{10,80}},
                                                                                                               color={85,170,255}));
  connect(rotorAngleQS.plug_n, terminalBoxQS.plug_sn) annotation (Line(points={{46,30},{46,36},{4,36},{4,30}},   color={85,170,255}));
  connect(voltageQuasiRMSSensorQS.plug_n, currentRMSSensorQS.plug_n) annotation (Line(points={{-10,50},{10,50}},color={85,170,255}));
  connect(starMQS.pin_n, starMachineQS.pin_n) annotation (Line(points={{-40,30},{-40,20},{-30,20}}, color={85,170,255}));
  connect(starMQS.plug_p, voltageQuasiRMSSensorQS.plug_p) annotation (Line(points={{-40,50},{-30,50}}, color={85,170,255}));
  connect(quadraticSpeedDependentTorqueQS.flange, rotorAngleQS.flange) annotation (Line(points={{80,20},{30,20}}, color={0,0,0}));
  connect(complexToReal.u, rotSource.y) annotation (Line(points={{-80,48},{-80,41}}, color={85,170,255}));
  connect(complexToReal.re, currentControllerQS.id_rms) annotation (Line(points={{-86,72},{-86,96},{-42,96}}, color={0,0,127}));
  connect(currentControllerQS.iq_rms, complexToReal.im) annotation (Line(points={{-42,84},{-74,84},{-74,72}}, color={0,0,127}));
  annotation (
    experiment(StopTime=1, Interval=1E-3, Tolerance=1E-6),
    Documentation(info="<html>
<p>
This example compares a time transient and a quasi static model of a permanent magnet synchronous machine. The machines are fed by a current source. The current components are oriented at the magnetic field orientation and transformed to the stator fixed reference frame. This way the machines are operated at constant torque. The machines start to accelerate from standstill.</p>

<p>
Simulate for 2 seconds and plot (versus time):
</p>

<ul>
<li><code>smpm|smpmQS.wMechanical</code>: machine speed</li>
<li><code>smpm|smpmQS.tauElectrical</code>: machine torque</li>
</ul>

<h5>Note</h5>
<p>The resistors connected to the terminals of the windings of the quasi static machine model are necessary 
to numerically stabilize the simulation.</p>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={
        Text(
          extent={{20,0},{100,-8}},
                  textStyle={TextStyle.Bold},
          textString="%m phase quasi static",        lineColor={0,0,0})}));
end SMPM_MTPA;
