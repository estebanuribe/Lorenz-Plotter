//
//  LorenzAttractor.cpp
//  Lorenz
//
//  Created by Esteban Uribe on 8/30/12.
//  Copyright (c) 2012 Esteban Uribe. All rights reserved.
//

#include "LorenzAttractor.h"


LorenzAttractor::LorenzAttractor(double r, double p, double b) {
    rho = r;
    phi = p;
    beta = b;
    h = 0.0000000000000000001;
}

void LorenzAttractor::setRho(double r) { rho = r; }

void LorenzAttractor::setPhi(double p)  { phi = p; }

void LorenzAttractor::setBeta(double b) { beta = b; }

double LorenzAttractor::getRho() { return rho; }
double LorenzAttractor::getPhi() { return phi; }
double LorenzAttractor::getBeta() { return beta; }

double LorenzAttractor::xprime(double x, double y) { return x+h*rho*(y - x); }
double LorenzAttractor::yprime(double x, double y, double z) { return y+h*(x*(phi - z)-y); }
double LorenzAttractor::zprime(double x, double y, double z) { return z+h*(x*y-beta*z); }

