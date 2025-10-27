function out = COMSOL_ATS_forward(i)
%
% COMSOL_site1.m
%
% Model exported on Jul 9 2025, 11:46 by COMSOL 6.2.0.415.
%unzip('param'+string(i)+'/data_set_edit.zip')
import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('D:\WADE_SFA\COMSOL_ATS');

model.component.create('comp1', true);

model.component('comp1').geom.create('geom1', 2);

model.component('comp1').mesh.create('mesh1');

model.component('comp1').physics.create('ec', 'ConductiveMedia', 'geom1');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/ec', true);

model.component('comp1').geom('geom1').create('imp1', 'Import');
model.component('comp1').geom('geom1').feature('imp1').set('filename', 'C:\Users\m10921371\OneDrive - Colorado School of Mines\Desktop\COMSOL\ATS_model\mesh_2025.mphbin');
model.component('comp1').geom('geom1').run('imp1');
model.component('comp1').geom('geom1').create('csol1', 'ConvertToSolid');
model.component('comp1').geom('geom1').feature('csol1').selection('input').set({'imp1'});
model.component('comp1').geom('geom1').run('csol1');
model.component('comp1').geom('geom1').create('pt3', 'Point');
model.component('comp1').geom('geom1').feature('pt3').set('p', [0 258.52]);
model.component('comp1').geom('geom1').run('fin');

model.func.create('int1', 'Interpolation');
model.func('int1').set('source', 'file');
model.func('int1').set('nargs', 3);
model.func('int1').set('filename', 'D:\WADE_SFA\COMSOL_ATS\param'+string(i)+'\data_set_edit.txt');
model.func('int1').setIndex('funcs', 'u', 0, 0);
model.func('int1').setIndex('funcs', 1, 0, 1);
model.func('int1').setIndex('funcs', 'w', 1, 0);
model.func('int1').setIndex('funcs', 2, 1, 1);
model.func('int1').setIndex('funcs', 'por', 2, 0);
model.func('int1').setIndex('funcs', 3, 2, 1);
model.func('int1').setIndex('funcs', 'sat', 3, 0);
model.func('int1').setIndex('funcs', 4, 3, 1);
model.func('int1').setIndex('funcs', 'cond', 4, 0);
model.func('int1').setIndex('funcs', 5, 4, 1);
model.func('int1').setIndex('funcs', 'Qv', 5, 0);
model.func('int1').setIndex('funcs', 8, 5, 1);
model.func('int1').setIndex('fununit', 'm/s', 0);
model.func('int1').setIndex('fununit', 'm/s', 1);
model.func('int1').setIndex('fununit', 1, 2);
model.func('int1').setIndex('fununit', 1, 3);
model.func('int1').setIndex('fununit', 'S/m', 4);
model.func('int1').setIndex('fununit', 'C/m^3', 5);
model.func('int1').setIndex('argunit', 'm', 0);
model.func('int1').setIndex('argunit', 'm', 1);
model.func('int1').setIndex('argunit', 'd', 2);

model.component('comp1').material.create('mat1', 'Common');
model.component('comp1').material('mat1').propertyGroup('def').func.create('eta', 'Piecewise');
model.component('comp1').material('mat1').propertyGroup('def').func.create('Cp', 'Piecewise');
model.component('comp1').material('mat1').propertyGroup('def').func.create('rho', 'Piecewise');
model.component('comp1').material('mat1').propertyGroup('def').func.create('k', 'Piecewise');
model.component('comp1').material('mat1').propertyGroup('def').func.create('cs', 'Interpolation');
model.component('comp1').material('mat1').propertyGroup('def').func.create('an1', 'Analytic');
model.component('comp1').material('mat1').propertyGroup('def').func.create('an2', 'Analytic');
model.component('comp1').material('mat1').propertyGroup('def').func.create('an3', 'Analytic');
model.component('comp1').material('mat1').label('Water, liquid');
model.component('comp1').material('mat1').set('family', 'water');
model.component('comp1').material('mat1').propertyGroup('def').func('eta').set('arg', 'T');
model.component('comp1').material('mat1').propertyGroup('def').func('eta').set('pieces', {'273.15' '413.15' '1.3799566804-0.021224019151*T^1+1.3604562827E-4*T^2-4.6454090319E-7*T^3+8.9042735735E-10*T^4-9.0790692686E-13*T^5+3.8457331488E-16*T^6'; '413.15' '553.75' '0.00401235783-2.10746715E-5*T^1+3.85772275E-8*T^2-2.39730284E-11*T^3'});
model.component('comp1').material('mat1').propertyGroup('def').func('eta').set('argunit', 'K');
model.component('comp1').material('mat1').propertyGroup('def').func('eta').set('fununit', 'Pa*s');
model.component('comp1').material('mat1').propertyGroup('def').func('Cp').set('arg', 'T');
model.component('comp1').material('mat1').propertyGroup('def').func('Cp').set('pieces', {'273.15' '553.75' '12010.1471-80.4072879*T^1+0.309866854*T^2-5.38186884E-4*T^3+3.62536437E-7*T^4'});
model.component('comp1').material('mat1').propertyGroup('def').func('Cp').set('argunit', 'K');
model.component('comp1').material('mat1').propertyGroup('def').func('Cp').set('fununit', 'J/(kg*K)');
model.component('comp1').material('mat1').propertyGroup('def').func('rho').set('arg', 'T');
model.component('comp1').material('mat1').propertyGroup('def').func('rho').set('smooth', 'contd1');
model.component('comp1').material('mat1').propertyGroup('def').func('rho').set('pieces', {'273.15' '293.15' '0.000063092789034*T^3-0.060367639882855*T^2+18.9229382407066*T-950.704055329848'; '293.15' '373.15' '0.000010335053319*T^3-0.013395065634452*T^2+4.969288832655160*T+432.257114008512'});
model.component('comp1').material('mat1').propertyGroup('def').func('rho').set('argunit', 'K');
model.component('comp1').material('mat1').propertyGroup('def').func('rho').set('fununit', 'kg/m^3');
model.component('comp1').material('mat1').propertyGroup('def').func('k').set('arg', 'T');
model.component('comp1').material('mat1').propertyGroup('def').func('k').set('pieces', {'273.15' '553.75' '-0.869083936+0.00894880345*T^1-1.58366345E-5*T^2+7.97543259E-9*T^3'});
model.component('comp1').material('mat1').propertyGroup('def').func('k').set('argunit', 'K');
model.component('comp1').material('mat1').propertyGroup('def').func('k').set('fununit', 'W/(m*K)');
model.component('comp1').material('mat1').propertyGroup('def').func('cs').set('table', {'273' '1403';  ...
'278' '1427';  ...
'283' '1447';  ...
'293' '1481';  ...
'303' '1507';  ...
'313' '1526';  ...
'323' '1541';  ...
'333' '1552';  ...
'343' '1555';  ...
'353' '1555';  ...
'363' '1550';  ...
'373' '1543'});
model.component('comp1').material('mat1').propertyGroup('def').func('cs').set('interp', 'piecewisecubic');
model.component('comp1').material('mat1').propertyGroup('def').func('cs').set('fununit', {'m/s'});
model.component('comp1').material('mat1').propertyGroup('def').func('cs').set('argunit', {'K'});
model.component('comp1').material('mat1').propertyGroup('def').func('an1').set('funcname', 'alpha_p');
model.component('comp1').material('mat1').propertyGroup('def').func('an1').set('expr', '-1/rho(T)*d(rho(T),T)');
model.component('comp1').material('mat1').propertyGroup('def').func('an1').set('args', {'T'});
model.component('comp1').material('mat1').propertyGroup('def').func('an1').set('fununit', '1/K');
model.component('comp1').material('mat1').propertyGroup('def').func('an1').set('argunit', {'K'});
model.component('comp1').material('mat1').propertyGroup('def').func('an1').set('plotfixedvalue', {'273.15'});
model.component('comp1').material('mat1').propertyGroup('def').func('an1').set('plotargs', {'T' '273.15' '373.15'});
model.component('comp1').material('mat1').propertyGroup('def').func('an2').set('funcname', 'gamma_w');
model.component('comp1').material('mat1').propertyGroup('def').func('an2').set('expr', '1+(T/Cp(T))*(alpha_p(T)*cs(T))^2');
model.component('comp1').material('mat1').propertyGroup('def').func('an2').set('args', {'T'});
model.component('comp1').material('mat1').propertyGroup('def').func('an2').set('fununit', '1');
model.component('comp1').material('mat1').propertyGroup('def').func('an2').set('argunit', {'K'});
model.component('comp1').material('mat1').propertyGroup('def').func('an2').set('plotfixedvalue', {'273.15'});
model.component('comp1').material('mat1').propertyGroup('def').func('an2').set('plotargs', {'T' '273.15' '373.15'});
model.component('comp1').material('mat1').propertyGroup('def').func('an3').set('funcname', 'muB');
model.component('comp1').material('mat1').propertyGroup('def').func('an3').set('expr', '2.79*eta(T)');
model.component('comp1').material('mat1').propertyGroup('def').func('an3').set('args', {'T'});
model.component('comp1').material('mat1').propertyGroup('def').func('an3').set('fununit', 'Pa*s');
model.component('comp1').material('mat1').propertyGroup('def').func('an3').set('argunit', {'K'});
model.component('comp1').material('mat1').propertyGroup('def').func('an3').set('plotfixedvalue', {'273.15'});
model.component('comp1').material('mat1').propertyGroup('def').func('an3').set('plotargs', {'T' '273.15' '553.75'});
model.component('comp1').material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', '');
model.component('comp1').material('mat1').propertyGroup('def').set('bulkviscosity', '');
model.component('comp1').material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', {'alpha_p(T)' '0' '0' '0' 'alpha_p(T)' '0' '0' '0' 'alpha_p(T)'});
model.component('comp1').material('mat1').propertyGroup('def').set('bulkviscosity', 'muB(T)');
model.component('comp1').material('mat1').propertyGroup('def').set('dynamicviscosity', 'eta(T)');
model.component('comp1').material('mat1').propertyGroup('def').set('ratioofspecificheat', 'gamma_w(T)');
model.component('comp1').material('mat1').propertyGroup('def').set('electricconductivity', {'5.5e-6[S/m]' '0' '0' '0' '5.5e-6[S/m]' '0' '0' '0' '5.5e-6[S/m]'});
model.component('comp1').material('mat1').propertyGroup('def').set('heatcapacity', 'Cp(T)');
model.component('comp1').material('mat1').propertyGroup('def').set('density', 'rho(T)');
model.component('comp1').material('mat1').propertyGroup('def').set('thermalconductivity', {'k(T)' '0' '0' '0' 'k(T)' '0' '0' '0' 'k(T)'});
model.component('comp1').material('mat1').propertyGroup('def').set('soundspeed', 'cs(T)');
model.component('comp1').material('mat1').propertyGroup('def').addInput('temperature');
model.component('comp1').material('mat1').label('subsurface');
model.component('comp1').material('mat1').propertyGroup('def').set('relpermittivity', {'3.03+9.38*moist+146.0*moist^2-76.7*moist^3'});
model.component('comp1').material('mat1').propertyGroup('def').set('electricconductivity', {'cond(x,y,t)'});
model.component('comp1').material('mat1').propertyGroup('def').set('moist', {'por(x,y,t)*sat(x,y,t)'});
model.component('comp1').material('mat1').propertyGroup('def').descr('moist', 'moisture content');
model.component('comp1').material('mat1').propertyGroup('def').set('porosity', {'por(x,y,t)'});

model.component('comp1').physics('ec').create('gnd1', 'Ground', 0);
model.component('comp1').physics('ec').feature('gnd1').selection.set([3]);
model.component('comp1').physics('ec').create('ecd1', 'ExternalCurrentDensity', 2);
model.component('comp1').physics('ec').feature('ecd1').selection.set([1]);
model.component('comp1').physics('ec').feature('ecd1').set('Je', {'Qv(x,y,t)*u(x,y,t)' 'Qv(x,y,t)*w(x,y,t)' '0'});

%model.component('comp1').mesh('mesh1').autoMeshSize(2);
model.component('comp1').mesh('mesh1').feature('size').set('hauto', 1);
model.component('comp1').mesh('mesh1').run;

model.study('std1').feature('time').set('tunit', 'd');
model.study('std1').feature('time').set('tlist', 'range(80,1,244)');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(80,1,244)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').label('Electric Potential (ec)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('showlegendsmaxmin', true);
model.result('pg1').set('defaultPlotID', 'InterfaceComponents/PlotDefaults/icom2/pdef1/pcond2/pcond2/pg1');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('solutionparams', 'parent');
model.result('pg1').feature('surf1').set('colortable', 'Dipole');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result('pg1').feature.create('str1', 'Streamline');
model.result('pg1').feature('str1').set('showsolutionparams', 'on');
model.result('pg1').feature('str1').set('solutionparams', 'parent');
model.result('pg1').feature('str1').set('expr', {'ec.Ex' 'ec.Ey'});
model.result('pg1').feature('str1').set('titletype', 'none');
model.result('pg1').feature('str1').set('posmethod', 'uniform');
model.result('pg1').feature('str1').set('udist', 0.02);
model.result('pg1').feature('str1').set('maxlen', 0.4);
model.result('pg1').feature('str1').set('maxtime', Inf);
model.result('pg1').feature('str1').set('inheritcolor', false);
model.result('pg1').feature('str1').set('showsolutionparams', 'on');
model.result('pg1').feature('str1').set('maxtime', Inf);
model.result('pg1').feature('str1').set('showsolutionparams', 'on');
model.result('pg1').feature('str1').set('maxtime', Inf);
model.result('pg1').feature('str1').set('showsolutionparams', 'on');
model.result('pg1').feature('str1').set('maxtime', Inf);
model.result('pg1').feature('str1').set('showsolutionparams', 'on');
model.result('pg1').feature('str1').set('maxtime', Inf);
model.result('pg1').feature('str1').set('data', 'parent');
model.result('pg1').feature('str1').selection.geom('geom1', 1);
model.result('pg1').feature('str1').selection.set([1 2 3 4]);
model.result('pg1').feature('str1').set('inheritplot', 'surf1');
model.result('pg1').feature('str1').feature.create('col1', 'Color');
model.result('pg1').feature('str1').feature('col1').set('colortable', 'DipoleDark');
model.result('pg1').feature('str1').feature('col1').set('colorlegend', false);
model.result('pg1').feature('str1').feature.create('filt1', 'Filter');
model.result('pg1').feature('str1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').label('Electric Field Norm (ec)');
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').set('showlegendsmaxmin', true);
model.result('pg2').set('defaultPlotID', 'InterfaceComponents/PlotDefaults/icom3/pdef1/pcond2/pcond2/pg1');
model.result('pg2').feature.create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('showsolutionparams', 'on');
model.result('pg2').feature('surf1').set('solutionparams', 'parent');
model.result('pg2').feature('surf1').set('expr', 'ec.normE');
model.result('pg2').feature('surf1').set('colortable', 'Prism');
model.result('pg2').feature('surf1').set('colortabletrans', 'nonlinear');
model.result('pg2').feature('surf1').set('colorcalibration', -0.8);
model.result('pg2').feature('surf1').set('showsolutionparams', 'on');
model.result('pg2').feature('surf1').set('data', 'parent');
model.result('pg2').feature.create('str1', 'Streamline');
model.result('pg2').feature('str1').set('showsolutionparams', 'on');
model.result('pg2').feature('str1').set('solutionparams', 'parent');
model.result('pg2').feature('str1').set('expr', {'ec.Ex' 'ec.Ey'});
model.result('pg2').feature('str1').set('titletype', 'none');
model.result('pg2').feature('str1').set('posmethod', 'uniform');
model.result('pg2').feature('str1').set('udist', 0.02);
model.result('pg2').feature('str1').set('maxlen', 0.4);
model.result('pg2').feature('str1').set('maxtime', Inf);
model.result('pg2').feature('str1').set('inheritcolor', false);
model.result('pg2').feature('str1').set('showsolutionparams', 'on');
model.result('pg2').feature('str1').set('maxtime', Inf);
model.result('pg2').feature('str1').set('showsolutionparams', 'on');
model.result('pg2').feature('str1').set('maxtime', Inf);
model.result('pg2').feature('str1').set('showsolutionparams', 'on');
model.result('pg2').feature('str1').set('maxtime', Inf);
model.result('pg2').feature('str1').set('showsolutionparams', 'on');
model.result('pg2').feature('str1').set('maxtime', Inf);
model.result('pg2').feature('str1').set('data', 'parent');
model.result('pg2').feature('str1').selection.geom('geom1', 1);
model.result('pg2').feature('str1').selection.set([1 2 3 4]);
model.result('pg2').feature('str1').set('inheritplot', 'surf1');
model.result('pg2').feature('str1').feature.create('col1', 'Color');
model.result('pg2').feature('str1').feature('col1').set('expr', 'ec.normE');
model.result('pg2').feature('str1').feature('col1').set('colortable', 'PrismDark');
model.result('pg2').feature('str1').feature('col1').set('colorlegend', false);
model.result('pg2').feature('str1').feature('col1').set('colortabletrans', 'nonlinear');
model.result('pg2').feature('str1').feature('col1').set('colorcalibration', -0.8);
model.result('pg2').feature('str1').feature.create('filt1', 'Filter');
model.result('pg2').feature('str1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result('pg1').run;
model.result.export.create('data1', 'Data');
model.result.export('data1').setIndex('expr', 'V', 0);
model.result.export('data1').set('filename', 'D:\WADE_SFA\COMSOL_ATS\param'+string(i)+'\result.txt');
model.result.export('data1').run;
mphsave(model, 'COMSOL_ATS_check.mph');





















%
% COMSOL_ATS_forward.m
%
% Model exported on Oct 15 2025, 23:02 by COMSOL 6.2.0.415.

%import com.comsol.model.*
%import com.comsol.model.util.*
%
%model = ModelUtil.create('Model');
%
%model.modelPath('D:\WADE_SFA\COMSOL_ATS');
%
%model.label('COMSOL_ATS_forward.mph');
%
%model.component.create('comp1', true);
%
%model.component('comp1').geom.create('geom1', 2);
%
%model.result.table.create('mm1', 'Table');
%
%model.func.create('int1', 'Interpolation');
%model.func('int1').set('source', 'file');
%model.func('int1').set('importedname', 'data_set_edit.txt');
%model.func('int1').set('importeddim', '3D');
%model.func('int1').set('funcs', {'u' '1';  ...
%'w' '2';  ...
%'por' '3';  ...
%'sat' '4';  ...
%'cond' '5';  ...
%'Qv' '8'});
%model.func('int1').set('fununit', {'m/s' 'm/s' '1' '1' 'S/m' 'C/m^3'});
%model.func('int1').set('argunit', {'m' 'm' 'd'});
%model.func('int1').set('filename', 'D:\WADE_SFA\COMSOL_ATS\param'+string(i)+'\data_set_edit.txt');
%model.func('int1').importData;
%model.func('int1').set('nargs', '3');
%model.func('int1').set('struct', 'spreadsheet');
%
%model.component('comp1').mesh.create('mesh1');
%
%model.component('comp1').geom('geom1').create('imp1', 'Import');
%model.component('comp1').geom('geom1').feature('imp1').set('type', 'native');
%model.component('comp1').geom('geom1').feature('imp1').set('filename', 'C:\Users\m10921371\OneDrive - Colorado School of Mines\Desktop\COMSOL\ATS_model\mesh_2025.mphbin');
%model.component('comp1').geom('geom1').create('csol1', 'ConvertToSolid');
%model.component('comp1').geom('geom1').feature('csol1').selection('input').set({'imp1'});
%model.component('comp1').geom('geom1').create('pt3', 'Point');
%model.component('comp1').geom('geom1').feature('pt3').set('p', [0 258.52]);
%model.component('comp1').geom('geom1').run;
%model.component('comp1').geom('geom1').run('fin');
%
%model.component('comp1').material.create('mat1', 'Common');
%model.component('comp1').material('mat1').propertyGroup('def').func.create('eta', 'Piecewise');
%model.component('comp1').material('mat1').propertyGroup('def').func.create('Cp', 'Piecewise');
%model.component('comp1').material('mat1').propertyGroup('def').func.create('rho', 'Piecewise');
%model.component('comp1').material('mat1').propertyGroup('def').func.create('k', 'Piecewise');
%model.component('comp1').material('mat1').propertyGroup('def').func.create('cs', 'Interpolation');
%model.component('comp1').material('mat1').propertyGroup('def').func.create('an1', 'Analytic');
%model.component('comp1').material('mat1').propertyGroup('def').func.create('an2', 'Analytic');
%model.component('comp1').material('mat1').propertyGroup('def').func.create('an3', 'Analytic');
%
%model.component('comp1').physics.create('ec', 'ConductiveMedia', 'geom1');
%model.component('comp1').physics('ec').create('gnd1', 'Ground', 0);
%model.component('comp1').physics('ec').feature('gnd1').selection.set([2]);
%model.component('comp1').physics('ec').create('ecd1', 'ExternalCurrentDensity', 2);
%model.component('comp1').physics('ec').feature('ecd1').selection.set([1]);
%
%model.component('comp1').mesh('mesh1').create('ftri1', 'FreeTri');
%
%model.result.table('mm1').label('Maximum and Minimum Values');
%model.result.table('mm1').comments('Max/min surface');
%
%model.component('comp1').view('view1').axis.set('xmin', -4.419822692871094);
%model.component('comp1').view('view1').axis.set('xmax', 88.39657592773438);
%model.component('comp1').view('view1').axis.set('ymin', 194.2510986328125);
%model.component('comp1').view('view1').axis.set('ymax', 311.406005859375);
%
%model.component('comp1').material('mat1').label('subsurface');
%model.component('comp1').material('mat1').set('family', 'water');
%model.component('comp1').material('mat1').propertyGroup('def').func('eta').set('arg', 'T');
%model.component('comp1').material('mat1').propertyGroup('def').func('eta').set('pieces', {'273.15' '413.15' '1.3799566804-0.021224019151*T^1+1.3604562827E-4*T^2-4.6454090319E-7*T^3+8.9042735735E-10*T^4-9.0790692686E-13*T^5+3.8457331488E-16*T^6'; '413.15' '553.75' '0.00401235783-2.10746715E-5*T^1+3.85772275E-8*T^2-2.39730284E-11*T^3'});
%model.component('comp1').material('mat1').propertyGroup('def').func('eta').set('argunit', 'K');
%model.component('comp1').material('mat1').propertyGroup('def').func('eta').set('fununit', 'Pa*s');
%model.component('comp1').material('mat1').propertyGroup('def').func('Cp').set('arg', 'T');
%model.component('comp1').material('mat1').propertyGroup('def').func('Cp').set('pieces', {'273.15' '553.75' '12010.1471-80.4072879*T^1+0.309866854*T^2-5.38186884E-4*T^3+3.62536437E-7*T^4'});
%model.component('comp1').material('mat1').propertyGroup('def').func('Cp').set('argunit', 'K');
%model.component('comp1').material('mat1').propertyGroup('def').func('Cp').set('fununit', 'J/(kg*K)');
%model.component('comp1').material('mat1').propertyGroup('def').func('rho').set('arg', 'T');
%model.component('comp1').material('mat1').propertyGroup('def').func('rho').set('smooth', 'contd1');
%model.component('comp1').material('mat1').propertyGroup('def').func('rho').set('pieces', {'273.15' '293.15' '0.000063092789034*T^3-0.060367639882855*T^2+18.9229382407066*T-950.704055329848'; '293.15' '373.15' '0.000010335053319*T^3-0.013395065634452*T^2+4.969288832655160*T+432.257114008512'});
%model.component('comp1').material('mat1').propertyGroup('def').func('rho').set('argunit', 'K');
%model.component('comp1').material('mat1').propertyGroup('def').func('rho').set('fununit', 'kg/m^3');
%model.component('comp1').material('mat1').propertyGroup('def').func('k').set('arg', 'T');
%model.component('comp1').material('mat1').propertyGroup('def').func('k').set('pieces', {'273.15' '553.75' '-0.869083936+0.00894880345*T^1-1.58366345E-5*T^2+7.97543259E-9*T^3'});
%model.component('comp1').material('mat1').propertyGroup('def').func('k').set('argunit', 'K');
%model.component('comp1').material('mat1').propertyGroup('def').func('k').set('fununit', 'W/(m*K)');
%model.component('comp1').material('mat1').propertyGroup('def').func('cs').set('table', {'273' '1403';  ...
%'278' '1427';  ...
%'283' '1447';  ...
%'293' '1481';  ...
%'303' '1507';  ...
%'313' '1526';  ...
%'323' '1541';  ...
%'333' '1552';  ...
%'343' '1555';  ...
%'353' '1555';  ...
%'363' '1550';  ...
%'373' '1543'});
%model.component('comp1').material('mat1').propertyGroup('def').func('cs').set('interp', 'piecewisecubic');
%model.component('comp1').material('mat1').propertyGroup('def').func('cs').set('fununit', {'m/s'});
%model.component('comp1').material('mat1').propertyGroup('def').func('cs').set('argunit', {'K'});
%model.component('comp1').material('mat1').propertyGroup('def').func('an1').set('funcname', 'alpha_p');
%model.component('comp1').material('mat1').propertyGroup('def').func('an1').set('expr', '-1/rho(T)*d(rho(T),T)');
%model.component('comp1').material('mat1').propertyGroup('def').func('an1').set('args', {'T'});
%model.component('comp1').material('mat1').propertyGroup('def').func('an1').set('fununit', '1/K');
%model.component('comp1').material('mat1').propertyGroup('def').func('an1').set('argunit', {'K'});
%model.component('comp1').material('mat1').propertyGroup('def').func('an1').set('plotfixedvalue', {'273.15'});
%model.component('comp1').material('mat1').propertyGroup('def').func('an1').set('plotargs', {'T' '273.15' '373.15'});
%model.component('comp1').material('mat1').propertyGroup('def').func('an2').set('funcname', 'gamma_w');
%model.component('comp1').material('mat1').propertyGroup('def').func('an2').set('expr', '1+(T/Cp(T))*(alpha_p(T)*cs(T))^2');
%model.component('comp1').material('mat1').propertyGroup('def').func('an2').set('args', {'T'});
%model.component('comp1').material('mat1').propertyGroup('def').func('an2').set('fununit', '1');
%model.component('comp1').material('mat1').propertyGroup('def').func('an2').set('argunit', {'K'});
%model.component('comp1').material('mat1').propertyGroup('def').func('an2').set('plotfixedvalue', {'273.15'});
%model.component('comp1').material('mat1').propertyGroup('def').func('an2').set('plotargs', {'T' '273.15' '373.15'});
%model.component('comp1').material('mat1').propertyGroup('def').func('an3').set('funcname', 'muB');
%model.component('comp1').material('mat1').propertyGroup('def').func('an3').set('expr', '2.79*eta(T)');
%model.component('comp1').material('mat1').propertyGroup('def').func('an3').set('args', {'T'});
%model.component('comp1').material('mat1').propertyGroup('def').func('an3').set('fununit', 'Pa*s');
%model.component('comp1').material('mat1').propertyGroup('def').func('an3').set('argunit', {'K'});
%model.component('comp1').material('mat1').propertyGroup('def').func('an3').set('plotfixedvalue', {'273.15'});
%model.component('comp1').material('mat1').propertyGroup('def').func('an3').set('plotargs', {'T' '273.15' '553.75'});
%model.component('comp1').material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', '');
%model.component('comp1').material('mat1').propertyGroup('def').set('bulkviscosity', '');
%model.component('comp1').material('mat1').propertyGroup('def').set('porosity', '');
%model.component('comp1').material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', {'alpha_p(T)' '0' '0' '0' 'alpha_p(T)' '0' '0' '0' 'alpha_p(T)'});
%model.component('comp1').material('mat1').propertyGroup('def').set('bulkviscosity', 'muB(T)');
%model.component('comp1').material('mat1').propertyGroup('def').set('dynamicviscosity', 'eta(T)');
%model.component('comp1').material('mat1').propertyGroup('def').set('ratioofspecificheat', 'gamma_w(T)');
%model.component('comp1').material('mat1').propertyGroup('def').set('electricconductivity', {'cond(x,y,t)' '0' '0' '0' 'cond(x,y,t)' '0' '0' '0' 'cond(x,y,t)'});
%model.component('comp1').material('mat1').propertyGroup('def').set('heatcapacity', 'Cp(T)');
%model.component('comp1').material('mat1').propertyGroup('def').set('density', 'rho(T)');
%model.component('comp1').material('mat1').propertyGroup('def').set('thermalconductivity', {'k(T)' '0' '0' '0' 'k(T)' '0' '0' '0' 'k(T)'});
%model.component('comp1').material('mat1').propertyGroup('def').set('soundspeed', 'cs(T)');
%model.component('comp1').material('mat1').propertyGroup('def').set('relpermittivity', {'3.03+9.38*moist+146.0*moist^2-76.7*moist^3' '0' '0' '0' '3.03+9.38*moist+146.0*moist^2-76.7*moist^3' '0' '0' '0' '3.03+9.38*moist+146.0*moist^2-76.7*moist^3'});
%model.component('comp1').material('mat1').propertyGroup('def').set('moist', 'por(x,y,t)*sat(x,y,t)');
%model.component('comp1').material('mat1').propertyGroup('def').descr('moist', 'moisture content');
%model.component('comp1').material('mat1').propertyGroup('def').set('porosity', 'por(x,y,t)');
%model.component('comp1').material('mat1').propertyGroup('def').addInput('temperature');
%
%model.component('comp1').physics('ec').feature('ecd1').set('Je', {'Qv(x,y,t)*u(x,y,t)'; 'Qv(x,y,t)*w(x,y,t)'; '0'});
%
%model.component('comp1').mesh('mesh1').feature('size').set('hauto', 1);
%model.component('comp1').mesh('mesh1').run;
%
%model.study.create('std1');
%model.study('std1').create('time', 'Transient');
%
%model.sol.create('sol1');
%model.sol('sol1').study('std1');
%model.sol('sol1').attach('std1');
%model.sol('sol1').create('st1', 'StudyStep');
%model.sol('sol1').create('v1', 'Variables');
%model.sol('sol1').create('t1', 'Time');
%model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
%model.sol('sol1').feature('t1').feature.remove('fcDef');
%
%model.result.create('pg2', 'PlotGroup2D');
%model.result.create('pg3', 'PlotGroup2D');
%model.result('pg2').create('surf1', 'Surface');
%model.result('pg2').create('str1', 'Streamline');
%model.result('pg2').feature('surf1').set('expr', 'ec.normE');
%model.result('pg2').feature('str1').create('col1', 'Color');
%model.result('pg2').feature('str1').create('filt1', 'Filter');
%model.result('pg2').feature('str1').feature('col1').set('expr', 'ec.normE');
%model.result('pg2').feature('str1').feature('filt1').set('expr', '!isScalingSystemDomain');
%model.result('pg3').create('surf1', 'Surface');
%model.result('pg3').create('con1', 'ContourSeries');
%model.result.export.create('data1', 'Data');
%
%model.study('std1').feature('time').set('tunit', 'd');
%model.study('std1').feature('time').set('tlist', 'range(0,1,244)');
%
%model.sol('sol1').attach('std1');
%model.sol('sol1').feature('st1').label('Compile Equations: Time Dependent');
%model.sol('sol1').feature('v1').label('Dependent Variables 1.1');
%model.sol('sol1').feature('v1').set('clist', {'{range(0,1,244)}[d]' '0.244[d]'});
%model.sol('sol1').feature('t1').label('Time-Dependent Solver 1.1');
%model.sol('sol1').feature('t1').set('tunit', 'd');
%model.sol('sol1').feature('t1').set('tlist', 'range(0,1,244)');
%model.sol('sol1').feature('t1').feature('dDef').label('Direct 1');
%model.sol('sol1').feature('t1').feature('aDef').label('Advanced 1');
%model.sol('sol1').feature('t1').feature('fc1').label('Fully Coupled 1.1');
%model.sol('sol1').runAll;
%
%model.result('pg2').label('Electric Field Norm (ec)');
%model.result('pg2').set('looplevel', [11]);
%model.result('pg2').set('frametype', 'spatial');
%model.result('pg2').set('showlegendsmaxmin', true);
%model.result('pg2').feature('surf1').set('colortable', 'Prism');
%model.result('pg2').feature('surf1').set('colortabletrans', 'nonlinear');
%model.result('pg2').feature('surf1').set('colorcalibration', -0.8);
%model.result('pg2').feature('surf1').set('resolution', 'normal');
%model.result('pg2').feature('str1').set('expr', {'ec.Ex' 'ec.Ey'});
%model.result('pg2').feature('str1').set('descr', 'Electric field');
%model.result('pg2').feature('str1').set('titletype', 'none');
%model.result('pg2').feature('str1').set('posmethod', 'uniform');
%model.result('pg2').feature('str1').set('udist', 0.02);
%model.result('pg2').feature('str1').set('maxlen', 0.4);
%model.result('pg2').feature('str1').set('inheritplot', 'surf1');
%model.result('pg2').feature('str1').set('inheritcolor', false);
%model.result('pg2').feature('str1').set('resolution', 'normal');
%model.result('pg2').feature('str1').feature('col1').set('colortable', 'PrismDark');
%model.result('pg2').feature('str1').feature('col1').set('colorlegend', false);
%model.result('pg2').feature('str1').feature('col1').set('colortabletrans', 'nonlinear');
%model.result('pg2').feature('str1').feature('col1').set('colorcalibration', -0.8);
%model.result('pg3').label('Electric Potential (ec) 1');
%model.result('pg3').set('looplevel', [158]);
%model.result('pg3').set('frametype', 'spatial');
%model.result('pg3').set('showlegendsmaxmin', true);
%model.result('pg3').feature('surf1').set('rangecoloractive', true);
%model.result('pg3').feature('surf1').set('rangecolormin', -0.02);
%model.result('pg3').feature('surf1').set('rangecolormax', 0.02);
%model.result('pg3').feature('surf1').set('colortable', 'Dipole');
%model.result('pg3').feature('surf1').set('resolution', 'normal');
%model.result('pg3').feature('con1').set('level', '0.05');
%model.result('pg3').feature('con1').set('resolution', 'normal');
%model.result.export('data1').set('expr', {'V'});
%model.result.export('data1').set('unit', {'V'});
%model.result.export('data1').set('descr', {'Electric potential'});
%model.result.export('data1').set('filename', 'D:\WADE_SFA\COMSOL_ATS\param'+string(i)+'\result.txt');
%model.result.export('data1').run;
%