/*
Computer Architecture Lab 2 - 08-01-2018
	Assignment : IEEE 754 Convertor
	Module : Single Precision Convertor
		-- Eshita Arza	(COE15B013)
		-- Akshay Kumar	(CED15I031)
*/
#include <stdio.h>

long double Power(char a, int b, char sign)
{
	long double soln = (int)(a - '0');
	if(sign == '+')
		while(b)
		{
			soln *= 2;
			b--;
		}
	if(sign == '-')
		while(b)
		{
			soln /= 2;
			b--;
		}
	return soln;
}

int main() // main function
{
	int conv_choice, exponent, rem, i, j;
	char sign, exp_sign;
	long double Decimal; 	// Variable to store the decimal
	char IEEE_Bin_SP[32];	// Character array to store the IEEE format in Binary
	
	while(1)
	{
		printf("Enter your choice:\n\t1. IEEE 754 to Decimal\n\t2. Decimal to IEEE 754\n\t [ ...Any Other Key to Exit... ]\n--->\t");
		scanf("%d", &conv_choice);
		if(conv_choice == 1)
		{
			for(i = 0; i < 32; i++)
				IEEE_Bin_SP[i] = '0';
			printf("Enter the 32 bit IEEE 754 binary string : ");
			scanf("%s", IEEE_Bin_SP);
			Decimal = 1;
			for(i = 9; i < 32; i++)
				Decimal += Power(IEEE_Bin_SP[i], i-8, '-');
			exponent = -127;
			for(i = 8, j = 0; i > 0; i--, j++)
				exponent += Power(IEEE_Bin_SP[i], j, '+');
			
			sign = (IEEE_Bin_SP[0] == '1')? '-' : '+';
			printf("\t\tSign = %c\n", sign);
			printf("\t\tExponent = %d\n", exponent);
			printf("\t\tMantissa = %Lf\n", Decimal);
			printf("\t\tNumber (Computational Form) = %c%Lf * 2 ^ %d\n", sign, Decimal, exponent);

			if(IEEE_Bin_SP[0] == '1')
				Decimal *= -1;
			if(exponent < 0)
				exp_sign = '-';
			else
				exp_sign = '+';
			Decimal *= Power('1', exponent, exp_sign);
			printf("\t\tNumber (Decimal Form) = %Lf\n", Decimal);

		}
		else
			if(conv_choice == 2)
			{
				printf("Enter the Decimal Value : ");
				scanf("%Lf", &Decimal);
				if(Decimal < 0)
				{
					IEEE_Bin_SP[0] = '1';
					Decimal *= -1;
				}
				else
					IEEE_Bin_SP[0] = '0';
				if(Decimal >= 2)
				{
					exponent = 0;
					while(Decimal >= 2)
					{
						Decimal /= 2;
						exponent++;
					}
				}
				else
				{
					exponent = 0;
					while(Decimal < 1)
					{
						Decimal *= 2;
						exponent--;
					}
				}

				exponent += 127; // offset of exponent
				printf("\tOutput\n");
				printf("\t\tSign Bit = %c\n", IEEE_Bin_SP[0]);
				printf("\t\tExponent with offset = %d\n", exponent);
				Decimal -= 1;

				for(i = 8; i > 0; i--)
				{
					rem = exponent%2;
					exponent /= 2;
					if(rem)
						IEEE_Bin_SP[i] = '1';
					else
						IEEE_Bin_SP[i] = '0';
				}

				for(i = 9; i < 32; i++)
				{
					Decimal *= 2;
					if(Decimal >= 1)
					{
						IEEE_Bin_SP[i] = '1';
						Decimal -= 1;
					}
					else
						IEEE_Bin_SP[i] = '0';
				}

				IEEE_Bin_SP[32] = '\0';
				printf("\t\tIEEE 754 Single Precision  (Binary) = %s\n", IEEE_Bin_SP);
				
				// Rounding Off
				Decimal *= 2;
				i = 31;
				if(Decimal >= 1)
					while(1)
					{
						if(IEEE_Bin_SP[i] == '1')
						{
							IEEE_Bin_SP[i] = '0';
							i--;
						}
						else
							{
								IEEE_Bin_SP[i] = '1';
								break;
							}
					}
				printf("\t\tIEEE 754 Single Precision (Rounded) = %s\n", IEEE_Bin_SP);
			}
			else
				break;
	}
	return 0;
}