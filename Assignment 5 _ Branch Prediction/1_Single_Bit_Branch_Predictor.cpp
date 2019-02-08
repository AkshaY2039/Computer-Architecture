/*
Computer Architecture Lab 8 - 26-02-2018
	Assignment A: Write a program to generate History Table for Single Bit Branch Predictor
					and analyse its efficiency.
					NT --> Branch Not Taken
					T --> Branch Taken

	Module : Generate Branch History Table for Single Bit Branch Predictor
		-- Eshita Arza		(COE15B013)
		-- Akshay Kumar		(CED15I031)
		-- Aditya Prakash	(CED15I025)
*/

#include <iostream>
#include <iomanip>
#include <stdlib.h>
#include <time.h>

using namespace std;

/*main module*/
int main ()
{
	srand (time (NULL));
	int prediction_bit, actual_outcome;
	prediction_bit = 0; //Initialize to NT
	unsigned long int iterations, success;
	success = 0; //Initialize success to 0

	cout << "Enter the number of iterations to consider : ";
	cin >> iterations;

	cout << endl;
	cout << setw(17) << "Iteration";
	cout << setw(21) << "Prediction Bit";
	cout << setw(22) << "Actual Outcome";
	cout << setw(14) << "Update" << endl << endl;

	for (unsigned long int i = 0; i < iterations; ++i)
	{
		actual_outcome = rand()%2;
		cout << setw(17) << i + 1;
		cout << setw(21) << (prediction_bit ? "Taken" : "Not Taken");
		cout << setw(22) << (actual_outcome ? "Taken" : "Not Taken");
		cout << setw(14) << (actual_outcome ? "Taken" : "Not Taken");
		cout << endl;
		if (prediction_bit == actual_outcome)
			success ++;
		else
			prediction_bit = actual_outcome;
	}

	cout << "\nPredictions successful : " << success;
	cout << "\nEfficiency : " << (float)(success * 100) / iterations << "%\n";

	return 0;
}