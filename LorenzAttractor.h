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

/*struct lorenzCoordinates {
    double x;
    double y;
    double z;
} lorenzCoordinates;*/

class LorenzAttractor {

public:
    double a = 0.0;
    double b = 0.0;
    double c = 0.0;
    double h = 0.01;

    LorenzAttractor(double hv, double av, double bv, double cv);
        
    double xprime   (double x, double y);
    double yprime   (double x, double y, double z);
    double zprime   (double x, double y, double z);
};

#endif /* defined(__Lorenz__LorenzAttractor__) */
