name = input("Ho va ten:")
splitname = list(name.replace(" ", ""))

nguyenam = ["a" , "e" , "o" , "i" , "u"]
phuam = ["b", "c", "d", "f", "g", "h", "j", "k" , "l", "m", "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z"]

listnguyenam = []
listphuam = []
listnumnguyenam = []
listnumphuam = []

def chartonumber(listofchar):
    listnum = []
    for abc in listofchar:
        if abc == "a" or abc == "j" or abc == "s":
            abc = int(1)
            listnum.append(abc)
        elif abc == "b" or abc == "k" or abc == "t":
            abc = int(2)
            listnum.append(abc)
        elif abc == "c" or abc == "l" or abc == "u":
            abc = int(3)
            listnum.append(abc)
        elif abc == "d" or abc == "m" or abc == "v":
            abc = int(4)
            listnum.append(abc)
        elif abc == "e" or abc == "n" or abc == "x":
            abc = int(5)
            listnum.append(abc)
        elif abc == "f" or abc == "o" or abc == "y":
            abc = int(6)
            listnum.append(abc)
        elif abc == "g" or abc == "p" or abc == "z":
            abc = int(7)
            listnum.append(abc)
        elif abc == "h" or abc == "q":
            abc = int(8)
            listnum.append(abc)
        elif abc == "i" or abc == "r":
            abc = int(9)
            listnum.append(abc)
    return listnum

def checknguyenamphuam(splitname):
    #print("splitname la:" + splitname)
    for i in range(len(splitname)):
        if splitname[i] == "y" and i > 0:
            before = int(i) - 1
            after = int(i) + 1
            if splitname[before] in phuam and splitname[after] in phuam:
                listnguyenam.append(splitname[i])
            else:
                listphuam.append(splitname[i])
        else:
            if splitname[i] in phuam:
                listphuam.append(splitname[i])
            elif splitname[i] in nguyenam:
                listnguyenam.append(splitname[i])
    #print('List nguyen am: ' + str(listnguyenam))
    #print('List phu am: ' + str(listphuam))


def nguyenamtonumber(listnguyenam):
    listnumnguyenam = chartonumber(listnguyenam)
    print('Number nguyen am la:' + str(chartonumber(listnguyenam)))
    return listnumnguyenam
 
def phunamtonumber(listphuam):
    listnumphuam = chartonumber(listphuam)
    print('Number phu am la:' + str(chartonumber(listphuam)))
    return listnumphuam 

def sumfinal(allnumber):
    sum = 0
    sumfinal = 0
    sumfinal02 = 0
    for i in allnumber:        
        sum = sum + i    
    for i in str(sum):
        sumfinal = sumfinal + int(i)
    for i in str(sumfinal):
        sumfinal02 = sumfinal02 + int(i)
    
    return sumfinal02
    

    

        
checknguyenamphuam(splitname)

listnumnguyenam = nguyenamtonumber(listnguyenam)
listnumphuam = phunamtonumber(listphuam)
sumnguyenam = sumfinal(listnumnguyenam)
sumphuam = sumfinal(listnumphuam)

print('Sum Nguyen Am Linh Hon la: ' + str(sumnguyenam) + )
print('Phu Am Nhan Cach la:' + str(sumphuam))



