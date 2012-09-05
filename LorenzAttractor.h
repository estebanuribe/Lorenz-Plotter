//
//  LorenzAttractor.h
//  Lorenz
//
//  Created by Esteban Uribe on 8/30/12.
//  Copyright (c) 2012 Esteban Uribe. All rights reserved.
//

#ifndef __Lorenz__LorenzAttractor__
#define __Lorenz__LorenzAttractor__

#include <iostream>

class LorenzAttractor {
    double rho = 0.0;
    double phi = 0.0;
    double beta = 0.0;
    double h = 0.01;
    
public:
    LorenzAttractor(double r, double phi, double beta);
    void    setRho  (double r);
    void    setPhi  (double p);
    void   setBeta  (double b);
    
    double getRho();
    double getPhi();
    double getBeta();
    
    double xprime   (double x, double y);
    double yprime   (double x, double y, double z);
    double zprime   (double x, double y, double z);
};

#endif /* defined(__Lorenz__LorenzAttractor__) */
