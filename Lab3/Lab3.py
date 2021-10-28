# CptS 355 - Fall 2021 - Lab 3
# Dayton Dekam

debugging = False
def debug(*s): 
     if debugging: 
          print(*s)

## problem 1 getNumCases 
def getNumCases(data, counties, months):
     totalCases = 0

     for county in counties:
          countyFound = data.get(county)
          if countyFound != None:
               for wantedMonth in months:
                    if wantedMonth in countyFound:
                         totalCases += countyFound[wantedMonth]
                         
     return totalCases

## problem 2 getMonthlyCases
def getMonthlyCases(data):
     monthlyCases = {}

     for county in data:
          countyData = data[county]

          for month in countyData:
               if month not in monthlyCases:
                    monthlyCases.update({month : {}})
                    monthlyCases[month].update({county : 0})
               if county not in monthlyCases[month]:
                    monthlyCases[month].update({county : 0})

               monthlyCases[month][county] += countyData[month] ## add cases to month

     return monthlyCases


from functools import reduce
## problem 3 mostCases 

## totals up the cases for the month
## monthData is a dictionary of the county paired with a 
## dictionary Counties and their cases
#  Returns a tupil of the month and it's cases (Month, Cases)
def totalMonthCases(month, monthData):
     totalMonthCases = sum(monthData.values())
     return (month, totalMonthCases)

# Returns the tuple with the largest second value
def biggestTuple(x, y):
     if x[1] > y[1]:
          return x
     else:
          return y

def mostCases(data):
     monthData = getMonthlyCases(data)
     if monthData == None:
          return None

     ## Sum up all the monthly cases and put their tupil (month, cases) in a list
     monthsCasesList = list(map(lambda key: totalMonthCases(key, monthData[key]), monthData.keys()))
     hottestMonth = reduce(biggestTuple, monthsCasesList)
     
     return hottestMonth

## problem 4a) searchDicts(L,k)
def searchDicts(L, k):
     for d in reversed(L):
          if k in d:
               return d[k]

     return None
## problem 4b) searchDicts2(L,k)
def searchDicts2(tL, k):
     found = False
     curIndex = len(tL) - 1

     while found is False:
          if curIndex >= len(tL) or curIndex < 0:
               break
          tpl = tL[curIndex]
          nextIndex = tpl[0]
          valDict = tpl[1]
          
          if k in valDict:
               found = True
               valueFound = valDict[k]
          else:
               if nextIndex is curIndex:
                    break
               else:
                    curIndex = nextIndex
     
     if found is False:
          return None
     else:
          return valueFound

## problem 5 - getLongest

## problem 6 - apply2nextN 