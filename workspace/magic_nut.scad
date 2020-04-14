/* 
*  Open SCAD Name.: Magic_Nut_Thing_v2.scad
*  Copyright (c)..: 2017 www.DIY3DTech.com
*
*  Creation Date..: 08/10/2017
*  Description....: Create of the Magic Nut
*
*  Rev 1: Develop Model
*  Rev 2: 
*
*  Built On: Open SCAD version 2017.01.20
*
*  This program is free software; you can redistribute it and/or modify it under the
*  terms of the GNU General Public License as published by the Free Software
*  Foundation; either version 2 of the License, or (at your option) any later version.
*
*  This program is distributed in the hope that it will be useful, but WITHOUT ANY
*  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
*  PARTICULAR PURPOSE.  See the GNU General Public License for more details.
* 
*  Note: the programming concepts within are shared openly in the hopes of educating
*  and training and can be used commercially.  However the completed object itself
*  created as result of this code remains the sole intellectual property of Campbell
*  and Company Publishing LLC.  If you have an interested in producing or using the
*  end product in a commercial application, please contact us at info@diy3dtech.com
*  for licensing possibilities.
*
*/ 

/*------------------Customizer View-------------------*/

// preview[view:north, tilt:top]

/*---------------------Parameters---------------------*/

//height of Thing in mm
grip_height     =   30;

//diameter of the Thing in mm
grip_dia        =   20;

//diameter of bolt opening (keep tight)
bolt_dia        =    6.3;

//diameter of nut/bolt head (long side)
bolt_head_dia   =   13;

//height of collar in mm
collar_height   =    3;

//base offset (bottom thickness) in mm
base_offset     =    2;

/*-----------------------Execute----------------------*/

main_module();

/*-----------------------Modules----------------------*/

module main_module(){  
    
    //transfer values 
    b_hg=grip_height;
    b_dia=grip_dia; 

    difference()
    {
        union()
        {
            //create knurled cylinder as base  
            k_cyl(b_hg,b_dia);
            
            translate ([0,0,0]) rotate ([0,0,0]) cylinder(collar_height,grip_dia /2,grip_dia /2,$fn=60,true);
            
        }
        
            //create opening for bolt shaft         
            translate ([0,0,b_hg/2]) rotate ([0,0,0]) cylinder(b_hg*2,bolt_dia/2,bolt_dia/2,$fn=60,true);
        
            //create opening for hex head with offset        
            translate ([0,0,(b_hg/2)+base_offset]) rotate ([0,0,0]) cylinder(b_hg,bolt_head_dia/2,bolt_head_dia/2,$fn=6,true);
       
    }
}//end module

module k_cyl(bnhg,bndia)
{
 // create base module for knob body

    k_cyl_hg=bnhg;   // Knurled cylinder height
    k_cyl_od=bndia;   // Knurled cylinder outer* diameter

    knurl_wd=3;      // Knurl polyhedron width
    knurl_hg=4;      // Knurl polyhedron height
    knurl_dp=1;      // Knurl polyhedron depth

    e_smooth=collar_height;      // Cylinder ends smoothed height
    s_smooth=0;      // [ 0% - 100% ] Knurled surface smoothing amount

    knurled_cyl(k_cyl_hg, k_cyl_od, 
                knurl_wd, knurl_hg, knurl_dp, 
                e_smooth, s_smooth);
}//end module


module knurled_cyl(chg, cod, cwd, csh, cdp, fsh, smt)
{
    cord=(cod+cdp+cdp*smt/100)/2;
    cird=cord-cdp;
    cfn=round(2*cird*PI/cwd);
    clf=360/cfn;
    crn=ceil(chg/csh);

    intersection()
    {
        shape(fsh, cird, cord-cdp*smt/100, cfn*4, chg);

        translate([0,0,-(crn*csh-chg)/2])
          knurled_finish(cord, cird, clf, csh, cfn, crn);
    }
}//end module

module shape(hsh, ird, ord, fn4, hg)
{
        union()
        {
            cylinder(h=hsh, r1=ird, r2=ord, $fn=fn4, center=false);

            translate([0,0,hsh-0.002])
              cylinder(h=hg-2*hsh+0.004, r=ord, $fn=fn4, center=false);

            translate([0,0,hg-hsh])
              cylinder(h=hsh, r1=ord, r2=ird, $fn=fn4, center=false);
        }

}//end module

module knurled_finish(ord, ird, lf, sh, fn, rn)
{
    for(j=[0:rn-1])
    let(h0=sh*j, h1=sh*(j+1/2), h2=sh*(j+1))
    {
        for(i=[0:fn-1])
        let(lf0=lf*i, lf1=lf*(i+1/2), lf2=lf*(i+1))
        {
            polyhedron(
                points=[
                     [ 0,0,h0],
                     [ ord*cos(lf0), ord*sin(lf0), h0],
                     [ ird*cos(lf1), ird*sin(lf1), h0],
                     [ ord*cos(lf2), ord*sin(lf2), h0],

                     [ ird*cos(lf0), ird*sin(lf0), h1],
                     [ ord*cos(lf1), ord*sin(lf1), h1],
                     [ ird*cos(lf2), ird*sin(lf2), h1],

                     [ 0,0,h2],
                     [ ord*cos(lf0), ord*sin(lf0), h2],
                     [ ird*cos(lf1), ird*sin(lf1), h2],
                     [ ord*cos(lf2), ord*sin(lf2), h2]
                    ],
                faces=[
                     [0,1,2],[2,3,0],
                     [1,0,4],[4,0,7],[7,8,4],
                     [8,7,9],[10,9,7],
                     [10,7,6],[6,7,0],[3,6,0],
                     [2,1,4],[3,2,6],[10,6,9],[8,9,4],
                     [4,5,2],[2,5,6],[6,5,9],[9,5,4]
                    ],
                convexity=5);
         }
    }
 }//end module
                                       
/*----------------------End Code----------------------*/