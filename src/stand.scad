/*
 * All variables are stored inside `_variables.scad`.
 * Please examine this file and change to your needs.
 * OpenSCAD will recognize these changes automatically
 * & reload after editing.
 *
 * Why is this done?
 * Pretty much all files in this repository depend on each other.
 * For example:
 *  `[[0,1,2,3,4,5]-way, tube_with_hole, resvoir].scad` depend on `x_way.scad`.
 *  `x_way.scad` makes use of `tray.scad`.
 * Even seemingly unconnected files like `planter.scad` or `cover.scad`
 * are using variables that are defined in other files.
 * Yes, we could (like before) split all the variables out in their own files,
 * but a single change in one file requires you to also change it in
 * all other files for them to fit together.
 * Unfortunately, this breaks OpenSCAD's customizer.
 */
include<_variables.scad>;
use<resevoir.scad>;

// Parts
module stand(round_base = true)
{
	if (round_base)
	{
		cylinder(h = $wall_thickness, r = $stand_radius, center = true);
	}
	else
	{
		cylinder(h = $wall_thickness, r = $stand_radius, center = true, $fn = 6);
	}

	translate([ 0, 0, $joining_height ])
	difference()
	{
		cylinder(h = $joining_height, r = $main_radius + $wall_thickness, center = true);
		cylinder(h = $joining_height, r = $main_radius, center = true);
	}
}

stand();

translate([ 0, 0, $main_height - $main_height / 2 + $joining_height ])
% resevoir();
