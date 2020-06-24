# curves
R code to (i) import a CSV file of student grades, and (ii) implement various curving mechanisms and their average

This takes 5 different mechanisms used to curve student grades. For deeper details including the pros/cons of each method, check out this awesome post by Dave Richeson: https://divisbyzero.com/2008/12/22/how-to-curve-an-exam-and-assign-grades/

Method 1: create a geometric series to implement a concave function that curves the grade of each student

Method 2: a proportion of the gap-from-100% for each student is added to their grade

Method 3: figure how far from 100% the top-scoring student is, add that margin to all students

Method 4: shift the class average to the specified/desired average

Method 5: transform the grades with an affine function to achieve a specified minimum and average

Finally, the code implements all 5 methods and stacks them side-by-side for the instructor to compare the distributions (e.g. desired proportion of A's, F's). Addiitonally, each row (student) is averaged across each column (curved grade for that student) to give a "split the difference" curve between the 5 mechanisms. 
