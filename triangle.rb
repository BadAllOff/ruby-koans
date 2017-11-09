# Triangle Project Code.

# Triangle analyzes the lengths of the sides of a triangle
# (represented by a, b and c) and returns the type of triangle.
#
# It returns:
#   :equilateral  if all sides are equal
#   :isosceles    if exactly 2 sides are equal
#   :scalene      if no sides are equal
#
# The tests for this method can be found in
#   about_triangle_project.rb
# and
#   about_triangle_project_2.rb
#
def triangle(a, b, c)
	if ( a <= 0 || b <= 0 || c <= 0 ) then
		raise TriangleError, "Sides of triangle can't be less or equal to zero"
	# if the sum of two sides less or egual to one side: it's not a triangle
	elsif ( a >= b+c || b >= a+c || c >= a+b ) then
		raise TriangleError, "This is not a triangle"
	else
	  if a == b && b == c then
	  	:equilateral 
	  elsif a == b || a == c || b == c then
	  	:isosceles
	  else
	  	:scalene
	  end
	end
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
