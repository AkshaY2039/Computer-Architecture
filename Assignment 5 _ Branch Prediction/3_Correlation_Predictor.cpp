/*
Computer Architecture Lab 8 - 26-02-2018
	Assignment C: Write a program to generate History Table for Correlation Predictor
					and analyse its efficiency.
				Sample code:
				if (a == (b + 1))
					a = 0;
				if (b < 15)
					b = 0;
				if ((a + b) != 0)
					{...};

	Module : Generate Branch History Table for Correlation Predictor for above application state
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
int main()
{
	srand (time (NULL));
	unsigned long int iterations, success;
	int prediction, a, b, c;
	success = 0; //Initialize success to 0

	cout << "Sample Code:\n";
	cout << "\tif (a == (b + 1))";
 	cout << "\n\t\ta = 0;";
	cout << "\n\tif (b < 15)";
	cout << "\n\t\tb = 0;";
	cout << "\n\tif ((a + b) != 0)";
	cout << "\n\t\t{...}\n";

	cout << "Enter the number of iterations to consider : ";
	cin >> iterations;

	cout << endl;
	cout << setw(17) << "Iteration";
	cout << setw(25) << "State [1]";
	cout << setw(25) << "State [2]";
	cout << setw(25) << "Prediction";
	cout << setw(25) << "State [3]" << endl << endl;

	for (unsigned long int i = 0; i < iterations; ++i)
	{
		int state[3] = {0};
		a = rand()%20;
		b = rand()%20;
		if (a == (b + 1))	// branch 1
		{
			a = 0;
			state[0] = 1;
		}
		if (b < 15)			// branch 2
		{
			b = 0;
			state[1] = 1;
		}

		if (state[1] && state[0]) // prediction based on last 2 branches
			prediction = 0;
		else
			prediction = 1;

		if ((a + b) != 0)	// branch 3
		{
			state[2] = 1;
		}

		if (state[2] == prediction)
			success ++;

		cout << setw(17) << i + 1;
		cout << setw(25) << (state [0]? "Taken" : "Not Taken");
		cout << setw(25) << (state [1]? "Taken" : "Not Taken");
		cout << setw(25) << (prediction? "Taken" : "Not Taken");
		cout << setw(25) << (state [2]? "Taken" : "Not Taken") << endl;
	}

	cout << "\nPredictions successful : " << success;
	cout << "\nEfficiency : " << (float)(success * 100) / iterations << "%\n";

	return 0;
}