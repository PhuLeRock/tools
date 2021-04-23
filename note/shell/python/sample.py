#!/usr/bin/python -tt
import sys, os

def morethan3():
	if len(sys.argv[1]) == 3:
		print "it is 3, wao"
	elif len(sys.argv[1]) > 3:
		print "more than 3"
	elif len(sys.argv[1]) < 3:
		print "less than 3"



def write_multilines_to_file():
	endoffile = """ 
day la 
cuoi file"""
	myfile = open("wrfile","w")
	ipfile = open(sys.argv[1],"r")
	myfile.truncate
	myfile.writelines(ipfile)
	myfile.writelines(endoffile)
	myfile.close

def callshell():	
	os.system("cp /etc/init.d/virtualbox .")
	os.system("sed -i 's,Sun VirtualBox,phuleroi,g' virtualbox")

#listname = ['phu','tunh','anhhv']
#print listname[0]
#print listname[1]
#print listname[2]
#x = 0
#for congdon in [1,2,3,4]:
#	x = x + 2
#	print x

	
if __name__ == '__main__':
	#write_multilines_to_file() 
	#morethan3()
	callshell()
	#othershell



	

