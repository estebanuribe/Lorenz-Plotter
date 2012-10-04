//
//  LorenzAttractor.cpp
//  Lorenz
//
//  Created by Esteban Uribe on 8/30/12.
//  Copyright (c) 2012 Esteban Uribe. All rights reserved.
//

#include "LorenzAttractor.h"


LorenzAttractor::LorenzAttractor(double hv, double av, double bv, double cv) {
    a = av;
    b = bv;
    c = cv;
    h = hv;
}

double LorenzAttractor::xprime(double x, double y) { return x + h * a * (y - x); }
double LorenzAttractor::yprime(double x, double y, double z) { return y + h * (x * (b - z) - y); }
double LorenzAttractor::zprime(double x, double y, double z) { return z + h * (x * y - c * z); }