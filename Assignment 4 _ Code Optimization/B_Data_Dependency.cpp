/*
Computer Architecture Lab 6 - 12-02-2018
	Assignment B: Analyse the impact of data dependencies for multi-core processors. Use 2 dependent equations in a
				[10000 or 100000] Loop & 4 independent equations for same number of Loop size. Find GFlops, total 
				program latency.

	Module : Data Dependency with Dependent and Independent Equations
		-- Eshita Arza		(COE15B013)
		-- Akshay Kumar		(CED15I031)
		-- Aditya Prakash	(CED15I025)
*/

#include <iostream>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>

#define GFL 1073741824

using namespace std;

clock_t time1;
double GFlops;
unsigned long int loop_limit;
float a, b, c, p;
float dep_expr1, dep_expr2;
float indep_expr1, indep_expr2, indep_expr3, indep_expr4;

/*Function for Dependent Equations in loop*/
void Dependent_Equations (int loop_limit)
{
	time1 = clock ();
	for(int i = 0; i < loop_limit; i++)
	{
		dep_expr1 = (++a) + sqrt (b) - 3;
		dep_expr2 = (c--) + powf (dep_expr1, p) + a;
	}
	time1 = clock () - time1;
	printf ("Dependent Equations took %li cycles (%f seconds), %lf GFlops\n", time1, (((float)time1) / CLOCKS_PER_SEC), (((double)time1) / GFL));
}

/*Function for Independent Equations in loop*/
void Independent_Equations (int loop_limit)
{
	time1 = clock ();
	for(int i = 0; i < loop_limit; i++)
	{
		/*indep_expr1 = powf(a, p);
		indep_expr2 = sqrt(b);
		indep_expr3 = a + 2 * b;
		indep_expr4 = p * a;*/
		indep_expr1 = (a + 1) + sqrt (b) - 3;
		indep_expr2 = (c - 1) + powf (a , p) + b;
	}
	time1 = clock () - time1;
	printf ("Independent Equations took %li cycles (%f seconds), %lf GFlops\n", time1, ((float)time1) / CLOCKS_PER_SEC, (((double)time1) / GFL));
}

/*main module*/
int main ()
{
	cout << "Enter the values of:\n";
	cout << "loop_limit (of order 10000 or 100000) : "; cin >> loop_limit;
	cout << "a : "; cin >> a;
	cout << "b : "; cin >> b;
	cout << "c : "; cin >> c;
	cout << "p (power) : "; cin >> p;
	Dependent_Equations (loop_limit);
	Independent_Equations (loop_limit);
	return 0;
}