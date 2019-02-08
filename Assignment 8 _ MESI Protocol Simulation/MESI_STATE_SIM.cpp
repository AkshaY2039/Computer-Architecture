// Computer Architecture Lab 13 - 09-04-2018
// 	Assignment: Write a program to simulate MESI Cache protocol.

// 	Module : MESI Simulator
// 		-- Eshita Arza		(COE15B013)
// 		-- Akshay Kumar		(CED15I031)
// 		-- Aditya Prakash	(CED15I025)

#include <iostream>
#include <iomanip>

using namespace std;

/* Macros for the different states */
#define EXCLUSIVE	1
#define INVALID		0
#define MODIFIED	2
#define SHARED		3

/* Macros for the different operations */
#define PR_RD		0
#define PR_WR		1
#define BUS_RD		2
#define BUS_RD_X	3
#define FLUSH		4
#define BUS_RD_S	5 

/* function to display Hint */
void Hint (int option)
{
	cout << endl;
	/* hint for Operation Codes if option isn't 0 */
	if (option)
	{
		cout << "*************************************************************" << endl;
		cout << "*                   OPERATIONS CODES                        *" << endl;
		cout << "*************************************************************" << endl;
		cout << "*  Processor Read --> 0      **  Processor Write --> 1      *" << endl;
		cout << "*  Bus Read --> 2            **  Bus ReadX --> 3            *" << endl;
		cout << "*  Flush --> 4               **  Bus Read(S) --> 5          *" << endl;
		cout << "*************************************************************" << endl;
	}
	/* hint for State Codes if option is 0 */
	else
	{
		cout << "*************************************************************" << endl;
		cout << "*                       STATE CODES                         *" << endl;
		cout << "*************************************************************" << endl;
		cout << "*  INVALID --> 0              **  EXCLUSIVE --> 2           *" << endl;
		cout << "*  MODIFIED --> 2             **  SHARED --> 3              *" << endl;
		cout << "*************************************************************" << endl;
	}
	cout << endl;
}

/* Display message in case of invalid operations */
void Invalid_Operation_Msg ()
{
	cout << "\txxxxxxx INVALID OPERATIONS xxxxxxx\n";
}

/* main module */
int main ()
{
	/* variable to store state, operation-1, operation-2 */
	int state, op1, op2;

	/* quit flag to quit simulation */
	char quit_flag = 'S';

	/* displaying hint for state codes */
	Hint (0);
	/* asking input for initial state of cache line */
	cout << "Enter the initial state of the cache line : ";
	cin >> state;

	/* while quit_flag is not Q */
	while (quit_flag != 'Q')
	{
		/* displaying hint for Operation codes */
		Hint (1);

		cout << "\t\t\t **** Current State --> ";
		if (state == EXCLUSIVE)
			cout << "EXCLUSIVE";
		else
			if (state == SHARED)
				cout << "SHARED";
			else
				if (state == MODIFIED)
					cout << "MODIFIED";
				else
					cout << "INVALID";
		cout << " ***\n";

		/* asking input for operations */
		cout << "Enter the operation 1 code : ";
		cin >> op1;
		cout << "Enter the operation 2 code : ";
		cin >> op2;

		switch (state)
		{
			case INVALID	:	if (op1 == PR_WR && op2 == BUS_RD_X)
								{
									state = MODIFIED;
									cout << "\t\t\t **** Next state --> MODIFIED ***\n";
								}
								else
									if (op1 == PR_RD)
									{
										if (op2 == BUS_RD)
										{
											state = EXCLUSIVE;
											cout << "\t\t\t **** Next state --> EXCLUSIVE ***\n";
										}
										else
											if (op2 == BUS_RD_S)
											{
												state = SHARED;
												cout << "\t\t\t **** Next state --> SHARED ***\n";
											}
									}
									else
										Invalid_Operation_Msg ();
								break;
			case MODIFIED	:	if (op1 == PR_RD || op1 == PR_WR)
								{
									state = MODIFIED;
									cout << "\t\t\t **** Next state --> MODIFIED ***\n";
								}
								else
									if (op2 == FLUSH)
									{
										if (op1 == BUS_RD_X)
										{
											state = INVALID;
											cout << "\t\t\t **** Next state --> INVALID ***\n";
										}
										else
											if (op1 == BUS_RD)
											{
												state = SHARED;
												cout << "\t\t\t **** Next state --> SHARED ***\n";
											}
									}
									else
										Invalid_Operation_Msg ();
								break;
			case EXCLUSIVE	:	switch (op1)
								{
									case PR_RD		:	state = EXCLUSIVE;
														cout << "\t\t\t **** Next state --> EXCLUSIVE ***\n";
														break;
									case PR_WR		:	state = MODIFIED;
														cout << "\t\t\t **** Next state --> MODIFIED ***\n";
														break;
									case BUS_RD_X	:	state = INVALID;
														cout << "\t\t\t **** Next state --> INVALID ***\n";
														break;
									case BUS_RD		:	state = SHARED;
														cout << "\t\t\t **** Next state --> SHARED ***\n";
														break;
									default			:	Invalid_Operation_Msg ();
								}
								break;
			case SHARED		:	switch (op1)
								{
									case PR_RD		:	state = SHARED;
														cout << "\t\t\t **** Next state --> SHARED ***\n";
														break;
									case PR_WR		:	if (op2 == BUS_RD_X)
														{
															state = MODIFIED;
															cout << "\t\t\t **** Next state --> MODIFIED ***\n";
														}
														else
															Invalid_Operation_Msg ();
														break;
									case BUS_RD_X	:	state = INVALID;
														cout << "\t\t\t **** Next state --> INVALID ***\n";
														break;
									case BUS_RD		:	state = SHARED;
														cout << "\t\t\t **** Next state --> SHARED ***\n";
														break;
									default			:	Invalid_Operation_Msg ();
								}
								break;
			default			:	cout << "\n\t\t\t!!!! You have entered a wrong State code. please Quit !!!!\n";
								break;
		}

		/* prompt to quit */
		cout << "\n\t\t\t To Quit program press 'Q' else press any other key followed by ENTER : ";
		cin >> quit_flag;
	}
	return 0;
}