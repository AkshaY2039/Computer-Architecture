# Computer Architecture Lab 8 - 05-03-2018
# 	Assignment: Write a program to simulate Scoreboard Technique.

# 	Module : Decode Instructions for Scoreboard Simulator from assembly code in the SCB.asm file
# 		-- Eshita Arza		(COE15B013)
# 		-- Akshay Kumar		(CED15I031)
# 		-- Aditya Prakash	(CED15I025)

import re # import regex library

class Instruction: # instruction class makes us to use the given instruction's parts for scoreboard

	def __init__ (self, repr, op, dst, src1, src2):
		self.issue = self.read_ops = self.ex_cmplt = self.write_res = -1
		self.op = op		# instruction operation
		self.fi = dst		# destination register
		self.fj = src1		# source register
		self.fk = src2		# source register
		self.repr = repr	# the string representation

	def __str__ (self):
		return "%-30s%-10d%-15d%-20d%-15d" % \
			(self.repr, self.issue, self.read_ops, self.ex_cmplt, self.write_res)

# Method to tokenize an instruction string
def tokenize_instruction (instruction):
	tokens = re.split (',| ', instruction)
	return list (filter (None, tokens))	# remove empty strings if any

# Generic ADD, SUBTRACT, MULTIPLY or DIVIDE instruction
def __arithmetic (inst):
	instruction_tokens = tokenize_instruction (inst)
	op = unit_for_instruction [instruction_tokens [0]]
	fi = instruction_tokens [1]
	fj = instruction_tokens [2]
	fk = instruction_tokens [3]
	return Instruction (inst, op, fi, fj, fk)

# Generic LOAD or STORE instruction
def __load_store (inst):
	instruction_tokens = tokenize_instruction (inst)
	op = 'integer'
	fi = instruction_tokens [1]
	fk = re.search ('\((.*)\)', instruction_tokens [2]).group (1)	# extract register
	return Instruction (inst, op, fi, None, fk)

# Generic ARTHMETIC OPERATION with immediate
def __arithmetici (inst):
	instruction_tokens = tokenize_instruction (inst)
	op = unit_for_instruction [instruction_tokens [0]]
	fi = instruction_tokens [1]
	fj = instruction_tokens [2]
	return Instruction (inst, op, fi, fj, None)

# LOAD IMMEDIATE instruction
def __li (inst):
	instruction_tokens = tokenize_instruction (inst)
	op = 'integer'
	fi = instruction_tokens [1]
	return Instruction (inst, op, fi, None, None)

# Mapping Assembly Instructions to respective functions
instructions = {
	'LI':		__li,			# INTEGER unit
    'LW':		__load_store,
    'SW':		__load_store,
    'LD':		__load_store,
    'SD':		__load_store,
    'ADD':		__arithmetic,
    'ADDI':		__arithmetici,
    'SUB':		__arithmetic,
    'SUBI':		__arithmetici,
    'ADDD':		__arithmetic,	# ADD unit
    'SUBD':		__arithmetic,
    'MULTD':	__arithmetic,	# MULT unit
    'DIVD':		__arithmetic,	# DIV unit
	}

# Mapping Arithmetic Assembly Instructions to respective Functional Units
unit_for_instruction = {
	'ADD':		'integer',
	'ADDI':		'integer',
	'SUB':		'integer',
	'SUBI':		'integer',
	'ADDD':		'add',		# ADD unit
	'SUBD':		'add',
	'MULTD':	'mult',		# MULT unit
	'DIVD':		'div',		# DIV unit
	}
