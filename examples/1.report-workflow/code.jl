using Unitful
using PhysicalConstants.CODATA2018

const R = MolarGasConstant; # Universal Gas Constant from CODATA 2018.

# PV = nRT
T = 298.0 * u"K";
P = 1u"bar";
n = 1u"mol";

V = n * R * T / P;