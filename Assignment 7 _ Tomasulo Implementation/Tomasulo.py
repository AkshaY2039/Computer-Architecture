
clk = 1
iss = 0 #issue
read = 1 #read operand
exe = 2 #execute
wri = 3 #write back

LD = 1
MULT = 2
SUBD = 3
DIVD = 4
ADDD = 5

F0, F1, F2, F3, F4, F5, F6, F7, F8, F9, F10, R2, R3 = 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 2, 3


#Creating the matrices
#w stands for width ; h stands for height

#Functional Unit Status
w, h = 9, 5;
FU = [[0 for x in range(w)] for y in range(h)]

#Instruction Status
w, h = 4, 7;
IS = [[0 for x in range(w)] for y in range(h)]

#Register Result status
w, h = 11, 1;
RS = [[-1 for x in range(w)] for y in range(h)]

#l[0][] keeps track of the functional unit that the instruction is using
#l[1][] keeps track of the time that instruction was issued
w, h = 7, 2;
load = [[0 for x in range(w)] for y in range(h)]

#Keeps track of the availability of the source registers
w, h = 11, 1;
source = [[0 for x in range(w)] for y in range(h)]

#Keeps track of the instructions that have finished execution
w, h = 6, 1;
complete = [[0 for x in range(w)] for y in range(h)]

#Keeps track of the register that have been updates; i.e those registers that have been read and written into
li = []

instruction = [[LD,F1,34,R2],[LD,F2,45,R3],[MULT,F0,F2,F4],[SUBD,F3,F1,F2],[DIVD,F5,F0,F1],[ADDD,F1,F3,F2],[-1,-1,-1,-1]]


#Register renaming
for i in range(0,6):
	for j in range(i+1,6):
		if instruction[i][2] == instruction[j][1]: 
			#checking if the destination of the instruction two is same as a source register in instruction one
			for k in range(j,6):
				if instruction[k][1] ==  instruction[i][1]:
					instruction[k][1] = F6
				if instruction[k][2] ==  instruction[i][1]:
					instruction[k][2] = F6
				if instruction[k][3] ==  instruction[i][1]:
					instruction[k][3] = F6

			F6 = F6 + 1

		if instruction[i][3] == instruction[j][1]:
			for k in range(j,6):
				if instruction[k][1] ==  instruction[i][1]:
					instruction[k][1] = F6
				if instruction[k][2] ==  instruction[i][1]:
					instruction[k][2] = F6
				if instruction[k][3] ==  instruction[i][1]:
					instruction[k][3] = F6
			F6 = F6 + 1


#ISSUE
def issue(ins, clk):

	print "here"
	if instruction[ins][0] == 1: #LOAD INSTRUCTION

		if FU[0][0] != 'Y':
			load[0][ins] = 0 #Being used by the 0th functional unit
			load[1][ins] = clk
			IS[ins][iss] = clk
			FU[0][0] = 'Y'
			FU[0][1] = instruction[ins][0] #operation
			FU[0][2] = instruction[ins][1] #destination
			FU[0][4] = instruction[ins][3] #source register 2
			FU[0][8] = 'Y'

			#updating the destination register's status in the register status
			RS[0][instruction[ins][1]] = load[0][ins]
	
	elif instruction[ins][0] == 2: #MUL INSTRUCTION
		if FU[1][0] != 'yes':
			load[0][ins] = 1
			load[1][ins] = clk
			FU[1][0] = 'yes'
			source[0][instruction[ins][2]] = 1
			source[0][instruction[ins][3]] = 1
			IS[ins][iss] = clk
			FU[1][1] = instruction[ins][0]
			FU[1][2] = instruction[ins][1]
			FU[1][3] = instruction[ins][2]
			FU[1][4] = instruction[ins][3]

			#if S1 is not being written into by any other register
			if RS[0][instruction[ins][2]] < 0:
				FU[1][7] = 'yes'
				RS[0][instruction[ins][1]] = load[0][ins]
			else:
				#if S1 is being written into then we update the value of the functional unit
				FU[1][7] = 'no'
				FU[1][5] = RS[0][instruction[ins][2]]	

			#if S2 is not being written into by any other register
			if RS[0][instruction[ins][3]] < 0:
				FU[1][8] = 'yes'
				RS[0][instruction[ins][1]] = load[0][ins]
			else:
				#if S1 is being written into then we update the value of the functional unit
				FU[1][8] = 'no'
				FU[1][6] = RS[0][instruction[ins][3]]
	
		elif FU[2][0] != 'yes':
			source[0][instruction[ins][2]] = 1
			source[0][instruction[ins][3]] = 1
			FU[2][0] = 'yes'
			IS[ins][iss] = clk
			load[0][ins] = 2
			load[1][ins] = clk
			FU[2][1] = instruction[ins][0]
			FU[2][2] = instruction[ins][1]
			FU[2][3] = instruction[ins][2]
			FU[2][4] = instruction[ins][3]
			
			if RS[0][instruction[ins][2]] < 0:
				FU[2][7] = 'yes'
				RS[0][instruction[ins][1]] = load[0][ins]
			else:
				FU[2][7] = 'no'
				FU[2][5] = RS[0][instruction[ins][2]]	

			if RS[0][instruction[ins][3]] < 0:
				FU[2][8] = 'yes'
				RS[0][instruction[ins][1]] = load[0][ins]
			else:
				FU[2][8] = 'no'
				FU[2][6] = RS[0][instruction[ins][3]]
	
	elif instruction[ins][0] == 3 or instruction[ins][0] == 5:
		if FU[3][0] != 'yes':
			load[0][ins] = 3
			load[1][ins] = clk
			FU[3][0] = 'yes'
			source[0][instruction[ins][2]] = 1
			source[0][instruction[ins][3]] = 1
			IS[ins][iss] = clk
			FU[3][1] = instruction[ins][0]
			FU[3][2] = instruction[ins][1]
			FU[3][3] = instruction[ins][2]
			FU[3][4] = instruction[ins][3]
			if RS[0][instruction[ins][2]] < 0:
				FU[3][7] = 'yes'
				RS[0][instruction[ins][1]] = load[0][ins]
			else:
				FU[3][7] = 'no'
				FU[3][5] = RS[0][instruction[ins][2]]	

			if RS[0][instruction[ins][3]] < 0:
				FU[3][8] = 'yes'
				RS[0][instruction[ins][1]] = load[0][ins]
			else:
				FU[3][8] = 'no'
				FU[3][6] = RS[0][instruction[ins][3]]
	
	elif instruction[ins][0] == 4:
		if FU[4][0] != 'yes':
			FU[4][0] = 'yes'
			load[0][ins] = 4
			load[1][ins] = clk
			source[0][instruction[ins][2]] = 1
			source[0][instruction[ins][3]] = 1
			IS[ins][iss] = clk
			FU[4][1] = instruction[ins][0]
			FU[4][2] = instruction[ins][1]
			FU[4][3] = instruction[ins][2]
			FU[4][4] = instruction[ins][3]
			if RS[0][instruction[ins][2]] < 0:
				FU[4][7] = 'yes'
				RS[0][instruction[ins][1]] = load[0][ins]
			else:
				FU[4][7] = 'no'
				FU[4][5] = RS[0][instruction[ins][2]]	

			if RS[0][instruction[ins][3]] < 0:
				FU[4][8] = 'yes'
				RS[0][instruction[ins][1]] = load[0][ins]
			else:
				FU[4][8] = 'no'
				FU[4][6] = RS[0][instruction[ins][3]]


def read_operand(ins, clk):
	print "here too"
	if instruction[ins][0] == 1:
		if FU[load[0][ins]][8] == 'yes':
			IS[ins][read] = clk
			IS[ins][exe] = IS[ins][read] + 1
			clk = clk + 1
			complete[0][ins] = 1
			li.append(instruction[ins][1])


	elif instruction[ins][0] == 2:
		
		if FU[load[0][ins]][7] == 'no':
			if instruction[ins][2] in li:
				FU[load[0][ins]][7] = 'yes'
				RS[0][instruction[ins][1]] = load[0][ins]
			else:
				FU[load[0][ins]][7] = 'no'
				FU[load[0][ins]][5] = RS[0][instruction[ins][2]]

		if FU[load[0][ins]][8] == 'no':
			if instruction[ins][3] in li:
				FU[load[0][ins]][8] = 'yes'
				RS[0][instruction[ins][1]] = load[0][ins]
			else:
				FU[load[0][ins]][8] = 'no'
				FU[load[0][ins]][6] = RS[0][instruction[ins][3]]

		if FU[load[0][ins]][7] == 'yes' and FU[load[0][ins]][8] == 'yes':
			IS[ins][read] = clk
			IS[ins][exe] = IS[ins][read] + 10
			clk = clk + 10
			complete[0][ins] = 1
			li.append(instruction[ins][1])

	elif instruction[ins][0] == 3:
		if FU[load[0][ins]][7] == 'no':
			if instruction[ins][2] in li:
				FU[load[0][ins]][7] = 'yes'
				RS[0][instruction[ins][1]] = load[0][ins]
			else:
				FU[load[0][ins]][7] = 'no'
				FU[load[0][ins]][5] = RS[0][instruction[ins][2]]
		if FU[load[0][ins]][8] == 'no':
			if instruction[ins][3] in li:
				FU[load[0][ins]][8] = 'yes'
				RS[0][instruction[ins][1]] = load[0][ins]
			else:
				FU[load[0][ins]][8] = 'no'
				FU[load[0][ins]][6] = RS[0][instruction[ins][3]]
		if FU[load[0][ins]][7] == 'yes' and FU[load[0][ins]][8] == 'yes':
			IS[ins][read] = clk
			IS[ins][exe] = IS[ins][read] + 2
			clk = clk + 2
			complete[0][ins] = 1
			li.append(instruction[ins][1])

	elif instruction[ins][0] == 5:
		if FU[load[0][ins]][7] == 'no':
			if instruction[ins][2] in li:
				FU[load[0][ins]][7] = 'yes'
				RS[0][instruction[ins][1]] = load[0][ins]
			else:
				FU[load[0][ins]][7] = 'no'
				FU[load[0][ins]][5] = RS[0][instruction[ins][2]]
		if FU[load[0][ins]][8] == 'no':
			if instruction[ins][3] in li:
				FU[load[0][ins]][8] = 'yes'
				RS[0][instruction[ins][1]] = load[0][ins]
			else:
				FU[load[0][ins]][8] = 'no'
				FU[load[0][ins]][6] = RS[0][instruction[ins][3]]
		if FU[load[0][ins]][7] == 'yes' and FU[load[0][ins]][8] == 'yes':
			IS[ins][read] = clk
			IS[ins][exe] = IS[ins][read] + 2
			clk = clk + 2
			complete[0][ins] = 1
			li.append(instruction[ins][1])

	elif instruction[ins][0] == 4:
		if FU[load[0][ins]][7] == 'no':
			if instruction[ins][2] in li:
				FU[load[0][ins]][7] = 'yes'
				RS[0][instruction[ins][1]] = load[0][ins]
			else:
				FU[load[0][ins]][7] = 'no'
				FU[load[0][ins]][5] = RS[0][instruction[ins][2]]
		if FU[load[0][ins]][8] == 'no':
			if instruction[ins][3] in li:
				FU[load[0][ins]][8] = 'yes'
				RS[0][instruction[ins][1]] = load[0][ins]
			else:
				FU[load[0][ins]][8] = 'no'
				FU[load[0][ins]][6] = RS[0][instruction[ins][3]]
		if FU[load[0][ins]][7] == 'yes' and FU[load[0][ins]][8] == 'yes':
			IS[ins][read] = clk
			IS[ins][exe] = IS[ins][read] + 40
			clk = clk + 40
			complete[0][ins] = 1
			li.append(instruction[ins][1])

def write_back(ins, clk):
	print "here three"
	if instruction[ins][0] == 1:
		if source[0][instruction[ins][1]] == 0 or load[1][ins] < clk:
			IS[ins][wri] = clk
			FU[load[0][ins]][0] = 'no'
			FU[load[0][ins]][1] = 0
			FU[load[0][ins]][2] = 0
			FU[load[0][ins]][3] = 0
			FU[load[0][ins]][4] = 0
			FU[load[0][ins]][5] = 0
			FU[load[0][ins]][6] = 0
			FU[load[0][ins]][8] = 'no'
			RS[0][instruction[ins][1]] = -1
			load[0][ins] = 0
			load[1][ins] = 0
			li.append(instruction[ins][1])

	if instruction[ins][0] == 2 or instruction[ins][0] == 3 or instruction[ins][0] == 4 or instruction[ins][0] == 5:
		if source[0][instruction[ins][1]] == 0 or load[1][ins] < clk:
			IS[ins][wri] = clk
			FU[load[0][ins]][0] = 'no'
			FU[load[0][ins]][1] = 0
			FU[load[0][ins]][2] = 0
			FU[load[0][ins]][3] = 0
			FU[load[0][ins]][4] = 0
			FU[load[0][ins]][5] = 0
			FU[load[0][ins]][6] = 0
			FU[load[0][ins]][7] = 'no'
			FU[load[0][ins]][8] = 'no'
			RS[0][instruction[ins][1]] = -1
			source[0][instruction[ins][2]] = 0
			source[0][instruction[ins][3]] = 0
			load[0][ins] = 0
			load[1][ins] = 0
			li.append(instruction[ins][1])


time = 0
j = 0
y = 0
IS[6][0] = -1
count = 0

while time < 70:
	if IS[5][iss] != 0:
		if IS[5][read] != 0:
			write_back(5, clk)

	if IS[5][iss] != 0:
		if IS[5][read] == 0:
			read_operand(5, clk)

	for ins in range(0,6):
		if IS[ins][iss] == 0:
			issue(ins, clk)
			break

	for j in range(0,ins):
		if IS[j][read] == 0:
			read_operand(j, clk)

	for k in range(0,ins):
		if IS[k][wri] == 0:
			if IS[k][exe] > 0:#and IS[k][exe] < clk:
				print "here also"
				write_back(k, clk)

	'''for j in range(0,ins):
		if IS[j][read] == 0:
			read_operand(j, clk)
	'''
	#print IS			
	clk = clk + 1
	
	for h in range(0,6):
		count = count + complete[0][h]
	
	if count == 6:
		break
	
	time = time + 1
	li = []
'''
	print "Clock : "
	print clk
	print "Instruction Status"
	print "Issue Read Execute Write_back"
	print IS
	print "Functional Unit Status"
	print "Busy Op dest S1 S2 'FU_S1' 'FU_S2' S1? S2?"
	print FU
	print "Register Result Status (destination registers)"
	print RS
	print "Source Registers"
	print source
	print "l"
	print load
	print "Completed Instructions"
	print complete
	print "\n"
	print "\n"
'''
print "Clock : " 
print clk
print "Instruction Status"
print "Issue Read Execute Write_back"
print IS
print "Functional Unit Status"
print "Busy Op dest S1 S2 'FU_S1' 'FU_S2' S1? S2?"
print FU
print "Register Result Status (destination registers)"
print RS
print "Source Registers"
print source
print "l"
print load
print "Completed Instructions"
print complete
print "\n"
print "\n"



