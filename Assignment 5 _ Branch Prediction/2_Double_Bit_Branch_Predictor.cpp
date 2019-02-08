/*
Computer Architecture Lab 8 - 26-02-2018
	Assignment B: Write a program to generate History Table for Double Bit Branch Predictor
					and analyse its efficiency.
					(prediction_state 0) SNT --> Strongly Branch Not Taken
					(prediction_state 1) WNT --> Weakly Branch Not Taken
					(prediction_state 2) WT --> Weakly Branch Taken
					(prediction_state 3) ST --> Strongly Branch Taken

	Module : Generate Branch History Table for Double Bit Branch Predictor
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
	unsigned long int iterations, success;
	int actual_outcome;
	success = 0; //Initialize success to 0
	int prediction_state;
	int update = 0; //Initialize update as SNT
	char STATE[4][25] = {"Strongly Not Taken", "Weakly Not Taken", "Weakly Taken", "Strongly Taken"};

	cout << "Enter the number of iterations to consider : ";
	cin >> iterations;

	cout << endl;
	cout << setw(17) << "Iteration";
	cout << setw(25) << "Prediction State";
	cout << setw(22) << "Actual Outcome";
	cout << setw(25) << "Update" << endl << endl;

	for (unsigned long int i = 0; i < iterations; ++i)
	{
		prediction_state = update;
		actual_outcome = rand()%2;

		switch (prediction_state)
		{
			case 0:
					if (actual_outcome)
						update = 1;
					else
					{
						update = 0;
						success ++;
					}
					break;

			case 1:
					if (actual_outcome)
						update = 2;
					else
					{
						update = 0;
						success ++;
					}
					break;

			case 2:
					if (actual_outcome)
					{
						update = 3;
						success ++;
					}
					else
						update = 1;
					break;

			case 3:
					if (actual_outcome)
					{
						update = 3;
						success ++;
					}
					else
						update = 2;
					break;
		}

		cout << setw(17) << i + 1;
		cout << setw(25) << STATE[prediction_state];
		cout << setw(22) << (actual_outcome ? "Taken" : "Not Taken");
		cout << setw(25) << STATE[update];
		cout << endl;
	}

	cout << "\nPredictions successful : " << success;
	cout << "\nEfficiency : " << (float)(success * 100) / iterations << "%\n";

	return 0;
}