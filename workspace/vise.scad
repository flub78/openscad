/*
*  Copyright (c)..: 2019 www.DIY3DTech.com
*
*  Creation Date..: 01/08/2018
*  Description....: 3D printable vice project
*
*  Rev 1: Develop Model
*  Rev 2: 
*
*  This program is free software; you can redistribute it and/or modify
*  it under the terms of the GNU General Public License as published by
*  the Free Software Foundation; either version 2 of the License, or
*  (at your option) any later version.
*
*  This program is distributed in the hope that it will be useful,
*  but WITHOUT ANY WARRANTY; without even the implied warranty of
*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*  GNU General Public License for more details.
*/ 
 
/*------------------Customizer View-------------------*/
 
// preview[view:north, tilt:top]
 
/*---------------------Parameters---------------------*/
 
top_width       =   50;     //width of top in mm
top_height      =   18;     //height of top in mm
base_height     =    5;     //height of base in mm
base_width      =   33;     //width of base in mm
vise_width      =   18;     //width of vice in mm
nut_thick       =    6;     //thickness of nut in mm
bumper_tall     =   12;     //bumper tall in mm
bumper_cap_tall =    3.2;   //height bumper bolt cap in mm
//----split vars dia below and dims above----
rod_dia         =    4.0;   //rod diameter in mm
bolt_dia        =    6.30;  //bolt dia in mm
spring_dia      =    9.7;   //spring dia in mm
mount_dia       =    3.2;   //top mount bolt dia in mm
nut_dia         =   12.6;   //nut dia in mm
bumper_dia      =   12;     //bumper dia in mm
inset_dia       =   10;     //inset dia of bumper in mm
bumper_bolt_dia =    2.85;  //dia of bumper bolt
bumper_cap_dia  =    5.6;   //dia bumper bolt cap in mm
expan_offset    =    0.2;   //dia offset for plastic expan
//------------logic to split parts------------
bumpers         =   1;      //1 is Yes and 0 is No
jaws            =   1;      //1 is Yes and 0 is No
 
/*-----------------------Execute----------------------*/
 
main_module();
 
/*-----------------------Modules----------------------*/
 
module main_module(){ //create module
    difference() {
            union() {//start union
                
                //set up toggle for jaws
                if (jaws==1) 
                            {//start jaw logic
                //build left vise module (back) 
                translate ([0,-vise_width*1.5,0]) rotate ([0,0,0]) color( "Magenta", 1.0 )left_module();
                
                //build right vise module (front)
                translate ([0,vise_width*1.5,0]) rotate ([0,0,0]) color( "Gold", 1.0 )right_module();
                             }//end if logic for jaws
                
                //set up toggle for bumpers
                if (bumpers==1) 
                            {//start bumper logic
                //build bumper
                translate ([-((top_width/2)+(bumper_dia/2)),vise_width*1.5,(((top_height+base_height)/2)+(bumper_tall/2))]) rotate ([0,0,0]) bumper_module();
                
                translate ([((top_width/2)-(bumper_dia/2))+7,vise_width*1.5,(((top_height+base_height)/2)+(bumper_tall/2))]) rotate ([0,0,0]) bumper_module();
                
                translate ([-((top_width/2)+(bumper_dia/2)),-vise_width*1.5,(((top_height+base_height)/2)+(bumper_tall/2))]) rotate ([0,0,0]) bumper_module();
                
                translate ([((top_width/2)-(bumper_dia/2))+7,-vise_width*1.5,(((top_height+base_height)/2)+(bumper_tall/2))]) rotate ([0,0,0]) bumper_module();
                            }//end if logic for bumpers
                        
                    } //end union
                            
    //start subtraction of difference
                    //set up toggle for jaws
                if (jaws==1) 
                            {//start jaw logic
                    //create rod holes for face block
                    #translate ([-(top_width-base_width)+rod_dia,vise_width,-(top_height/2)+rod_dia]) rotate ([90,0,0]) cylinder(vise_width*2,rod_dia /2,rod_dia /2,$fn=60,true);
                    #translate ([(top_width-base_width)-rod_dia,vise_width,-(top_height/2)+rod_dia]) rotate ([90,0,0]) cylinder(vise_width*2,rod_dia/2,rod_dia/2,$fn=60,true);
                    
                    //create rod holes for receiver
                    translate ([-(top_width-base_width)+rod_dia,-vise_width*1.5,-(top_height/2)+rod_dia]) rotate ([90,0,0]) cylinder(vise_width*2,(rod_dia+expan_offset)/2,(rod_dia+expan_offset)/2,$fn=60,true);
                    translate ([(top_width-base_width)-rod_dia,-vise_width*1.5,-(top_height/2)+rod_dia]) rotate ([90,0,0]) cylinder(vise_width*2,(rod_dia+expan_offset)/2,(rod_dia+expan_offset)/2,$fn=60,true);
 
                    //create create bolt hole
                    translate ([0,0,-(top_height/2)+bolt_dia]) rotate ([90,0,0]) cylinder(vise_width*5,bolt_dia/2,bolt_dia/2,$fn=60,true);
                             
                    //create create spring hole
                    #translate ([0,0,-(top_height/2)+bolt_dia]) rotate ([90,0,0]) cylinder(vise_width*2.5,spring_dia/2,spring_dia/2,$fn=60,true);
                             }//end jaw logic
                    
                    
                                               
    } //end difference
}//end module
 
module left_module(){ //create module
    difference() {
            union() {//start union
                //build top body
                translate ([0,0,0]) rotate ([0,0,0]) rounded (top_width,vise_width ,top_height,1,true);
                //build bottom body
                translate ([0,0,-((top_height/2)+(base_height/2)-0.5)]) rotate ([0,0,0]) rounded (base_width,vise_width ,base_height+1,1,true);
                 
                        
                    } //end union
                            
    //start subtraction of difference
                    
                    //start mounting holes (chamfer will affect position)
                    translate ([-((top_width/2)+(mount_dia/2))+7,0,(((top_height+base_height)/2)-(top_height/2))+2]) rotate ([0,0,0]) cylinder((top_height/2)+1,mount_dia/2,mount_dia/2,$fn=60,true);
                    translate ([-((top_width/2)+(mount_dia/2))+18,0,(((top_height+base_height)/2)-(top_height/2))+2]) rotate ([0,0,0]) cylinder((top_height/2)+1,mount_dia/2,mount_dia/2,$fn=60,true);
                    
                    translate ([((top_width/2)+(mount_dia/2))-7,0,(((top_height+base_height)/2)-(top_height/2))+2]) rotate ([0,0,0]) cylinder((top_height/2)+1,mount_dia/2,mount_dia/2,$fn=60,true);
                    translate ([((top_width/2)+(mount_dia/2))-18,0,(((top_height+base_height)/2)-(top_height/2))+2]) rotate ([0,0,0]) cylinder((top_height/2)+1,mount_dia/2,mount_dia/2,$fn=60,true);
                    //end mounting holes
                    
                    //create nut opening
                    translate ([0,0,-(top_height/2)+bolt_dia]) rotate ([90,0,0]) cylinder(nut_thick,nut_dia/2,nut_dia/2,$fn=6,true);
                    translate ([0,0,-(base_height+1+(nut_dia/2))+1]) rotate ([0,0,0]) cube([nut_dia,nut_thick,base_height+(nut_dia)],true);
                                               
    } //end difference
}//end module
 
module right_module(){ //create module
    difference() {
            union() {//start union
                //build top body
                translate ([0,0,0]) rotate ([0,0,0]) rounded (top_width,vise_width ,top_height,1,true);
                //build bottom body
                translate ([0,0,-((top_height/2)+(base_height/2)-0.5)]) rotate ([0,0,0]) rounded (base_width,vise_width ,base_height+1,1,true);
                 
                        
                    } //end union
                            
    //start subtraction of difference
                    
                    //start mounting holes (chamfer will affect position)
                    translate ([-((top_width/2)+(mount_dia/2))+7,0,(((top_height+base_height)/2)-(top_height/2))+2]) rotate ([0,0,0]) cylinder((top_height/2)+1,mount_dia/2,mount_dia/2,$fn=60,true);
                    translate ([-((top_width/2)+(mount_dia/2))+18,0,(((top_height+base_height)/2)-(top_height/2))+2]) rotate ([0,0,0]) cylinder((top_height/2)+1,mount_dia/2,mount_dia/2,$fn=60,true);
                    
                    translate ([((top_width/2)+(mount_dia/2))-7,0,(((top_height+base_height)/2)-(top_height/2))+2]) rotate ([0,0,0]) cylinder((top_height/2)+1,mount_dia/2,mount_dia/2,$fn=60,true);
                    translate ([((top_width/2)+(mount_dia/2))-18,0,(((top_height+base_height)/2)-(top_height/2))+2]) rotate ([0,0,0]) cylinder((top_height/2)+1,mount_dia/2,mount_dia/2,$fn=60,true);
                    //end mounting holes
                                               
    } //end difference
}//end module
 
module bumper_module(){ //create module
    difference() {
            union() {//start union
                
                //create basic bumper
                translate ([0,0,0]) rotate ([0,0,0]) cylinder(bumper_tall,bumper_dia/2,bumper_dia/2,$fn=60,true);
               
                    } //end union
                            
    //start subtraction of difference
               
               //create torus to dif out center of bumper     
               rotate_extrude(convexity = 10, $fn = 100)
translate([inset_dia, 0, 0])
circle(r = inset_dia/2, $fn = 60);
                    
               //create bolt pass though for bumper
               translate ([0,0,0]) rotate ([0,0,0]) cylinder(bumper_tall*2,bumper_bolt_dia/2,bumper_bolt_dia/2,$fn=60,true);
                    
               //create bolt cap recess
               translate ([0,0,((bumper_tall/2)-(bumper_cap_tall/2))+1]) rotate ([0,0,0]) cylinder(bumper_cap_tall+1,bumper_cap_dia/2,bumper_cap_dia/2,$fn=60,true);
                    
                                               
    } //end difference
}//end module
module rounded(x,y,z,c,center) {
    /* variables:
    * x = X Axis length
    * y = Y Axis Length
    * z = Z Axis Height
    * c = Chamfer amount this will add (in mm) to each axis
    */
    
     //create overlapping cubes
        //cube one overlapped in the X axis with chamfer "c" being doubled
        cube ([x+(c*2),y,z],true);
        //cube two overlapped in the Y axis with chamfer "c" being doubled
        cube ([x,y+(c*2),z],true);
     //end overlapping cubes
        
     //create corner circles
        translate ([-(x/2),-(y/2),0]) { cylinder( z,c,c,$fn=60,true);
        }
        translate ([-(x/2),(y/2),0]) { cylinder( z,c,c,$fn=60,true);
        }
        translate ([(x/2),-(y/2),0]) { cylinder( z,c,c,$fn=60,true);
        }
        translate ([(x/2),(y/2),0]) { cylinder( z,c,c,$fn=60,true);
        }
     //end corner circle
    
} //end module