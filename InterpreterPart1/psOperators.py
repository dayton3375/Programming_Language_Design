from psItems import Value, ArrayValue, FunctionValue
class Operators:
    def __init__(self):
        #stack variables
        self.opstack = []  #assuming top of the stack is the end of the list
        self.dictstack = []  #assuming top of the stack is the end of the list
        
        #The builtin operators supported by our interpreter
        self.builtin_operators = {
             # TO-DO in part1
             # include the key value pairs where he keys are the PostScript opertor names and the values are the function values that implement that operator. 
             # Make sure **not to call the functions** 
        }
    #-------  Operand Stack Operators --------------
    """
        Helper function. Pops the top value from opstack and returns it.
    """
    def opPop(self):
        if len(self.opstack) > 0:
            val = self.opstack.pop()
        else:
            val = None
        return val

    """
       Helper function. Pushes the given value to the opstack.
    """
    def opPush(self,value):
        self.opstack.append(value)
        
    #------- Dict Stack Operators --------------
    
    """
       Helper function. Pops the top dictionary from dictstack and returns it.
    """   
    def dictPop(self):
        if len(self.dictstack) > 0:
            val = self.dictstack.pop
        else:
            val = None
        return val

    """
       Helper function. Pushes the given dictionary onto the dictstack. 
    """   
    def dictPush(self,d):
        self.dictstack.append(d)

    """
       Helper function. Adds name:value pair to the top dictionary in the dictstack.
       (Note: If the dictstack is empty, first adds an empty dictionary to the dictstack then adds the name:value to that. 
    """   
    def define(self,name, value):
        if len(self.dictstack) == 0:
            newdict = {}
            self.dictstack.append(newdict)
        self.dictstack[-1][name] = value    # gets last element of list and adds the key:value to that dictionary
            

    """
       Helper function. Searches the dictstack for a variable or function and returns its value. 
       (Starts searching at the top of the dictstack; if name is not found returns None and prints an error message.
        Make sure to add '/' to the begining of the name.)
    """
    def lookup(self,name):
        if len(self.dictstack) == 0:
            print("Error: lookup - dictstack is empty")
            return None

        key = '/' + name

        for d in reversed(self.dictstack): # search each dictionary in the stack
            if key in d:
                return d[key]

        print("Error: lookup - name not found")
        return None
    
    #------- Arithmetic Operators --------------
    
    """
       Pops 2 values from opstack; checks if they are numerical (int); adds them; then pushes the result back to opstack. 
    """   
    def add(self):
        if len(self.opstack) > 1:
            op1 = self.opPop()
            op2 = self.opPop()
            if isinstance(op1,int) and isinstance(op2,int):
                self.opPush(op1 + op2)
            else:
                print("Error: add - one of the operands is not a number value")
                self.opPush(op2)
                self.opPush(op1)             
        else:
            print("Error: add expects 2 operands")
 
    """
       Pop 2 values from opstack; checks if they are numerical (int); subtracts them; and pushes the result back to opstack. 
    """   
    def sub(self):
        if len(self.opstack) > 1:
            op1 = self.opPop()
            op2 = self.opPop()
            if (isinstance(op1, int) and isinstance(op2, int)):
                self.opPush(op2 - op1)
            else:
                print("Error: sub - one of the operands is not a number value")
        else:
            print("Error: sub expects 2 operands")

    """
        Pops 2 values from opstack; checks if they are numerical (int); multiplies them; and pushes the result back to opstack. 
    """    
    def mul(self):
        if len(self.opstack) > 1:
            op1 = self.opPop()
            op2 = self.opPop()
            if (isinstance(op1, int) and isinstance(op2, int)):
                self.opPush(op1 * op2)
            else:
                print("Error: mul - one of the operands is not a number value")
        else:
            print("Error: mul expects 2 operands")

    """
        Pops 2 values from stack; checks if they are int values; calculates the remainder of dividing the bottom value by the top one; 
        pushes the result back to opstack.
    """ 
    def mod(self):
        if len(self.opstack) > 1:
            op1 = self.opPop()
            op2 = self.opPop()
            if (isinstance(op1, int) and isinstance(op2, int)):
                self.opPush(op2 % op1)
            else:
                print("Error: mod - one of the operands is not a number value")
        else:
            print("Error: mod expects 2 operands")


    #---------- Comparison Operators  -----------------
    """
       Pops the top two values from the opstack; pushes "True" is they are equal, otherwise pushes "False"
    """ 
    def eq(self):
        if len(self.opstack) > 1:
            op1 = self.opPop()
            op2 = self.opPop()
            self.opPush(op1 == op2)
        else:
            print("Error: eq expects 2 operands")

    """
       Pops the top two values from the opstack; pushes "True" if the bottom value is less than the top value, otherwise pushes "False"
    """ 
    def lt(self):
        if len(self.opstack) > 1:
            op1 = self.opPop()
            op2 = self.opPop()
            self.opPush(op2 < op1)
        else:
            print("Error: lt expects 2 operands")

    """
       Pops the top two values from the opstack; pushes "True" if the bottom value is greater than the top value, otherwise pushes "False"
    """ 
    def gt(self):
        if len(self.opstack) > 1:
            op1 = self.opPop()
            op2 = self.opPop()
            self.opPush(op2 > op1)
        else:
            print("Error: gt expects 2 operands")

    # ------- Array Operators --------------
    """ 
       Pops an array value from the operand opstack and calculates the length of it. Pushes the length back onto the opstack.
       The `length` method should support ArrayValue values.
    """
    def length(self):
        if len(self.opstack) > 0:
            op = self.opPop()
            if isinstance(op, ArrayValue):
                size = len(op.value)
                self.opPush(size)
            else:
                print("Error: length - top of stack not ArrayValue")
        else:
            print("Error: length - opstack empty")

    """ 
        Pops the `count` (int), an (zero-based) start `index`, and an array constant (ArrayValue) from the operand stack.  
        Pushes the slice of the array of length `count` starting at `index` onto the opstack.(i.e., from `index` to `index`+`count`) 
        If the end index of the slice goes beyond the array length, will give an error. 
    """
    def getinterval(self):
        if len(self.opstack) > 2:
            size = self.opPop()
            index = self.opPop()
            if (isinstance(size, int) and isinstance(index, int)):
                array = self.opPop()
                if isinstance(array, ArrayValue):
                    if len(array.value) >= (index + size):
                        slc = ArrayValue(array.value[index : index + size])
                        self.opPush(slc)
                    else:
                        print("Error: getinterval - index out of bounds of array")
                else:
                    print("Error: getinterval - no ArrayValue on opstack")
            else:
                print("Error: getinterval - first two values on opstack are not integers")
        else:
            print("Error: getinterval - opstack doesn't have 3 or more values")

    """ 
        Pops an array constant (ArrayValue), start `index` (int), and another array constant (ArrayValue) from the operand stack.  
        Replaces the slice in the bottom ArrayValue starting at `index` with the top ArrayValue (the one we popped first). 
        The result is not pushed onto the stack.
        The index is 0-based. If the end index of the slice goes beyond the array length, will give an error. 
    """
    def putinterval(self):
        pass
            

    """ 
        Pops an array constant (ArrayValue) from the operand stack.  
        Pushes all values in the array constant to the opstack in order (the first value in the array should be pushed first). 
        Pushes the orginal array value back on to the stack. 
    """
    def aload(self):
        pass
        
    """ 
        Pops an array constant (ArrayValue) from the operand stack.  
        Pops as many elements as the length of the array from the operand stack and stores them in the array constant. 
        The value which was on the top of the opstack will be the last element in the array. 
        Pushes the array value back onto the operand stack. 
    """
    def astore(self):
        pass

    #------- Stack Manipulation and Print Operators --------------

    """
       This function implements the Postscript "pop operator". Calls self.opPop() to pop the top value from the opstack and discards the value. 
    """
    def pop (self):
        pass

    """
       Prints the opstack. The end of the list is the top of the stack. 
    """
    def stack(self):
        pass

    """
       Copies the top element in opstack.
    """
    def dup(self):
        if len(self.opstack) > 0:
            val = self.opstack[-1]
            self.opPush(val)
        else:
            print("Error: dup - opstack empty")

    """
       Pops an integer count from opstack, copies count number of values in the opstack. 
    """
    def copy(self):
        pass

    """
        Counts the number of elements in the opstack and pushes the count onto the top of the opstack.
    """
    def count(self):
        pass

    """
       Clears the opstack.
    """
    def clear(self):
        pass
        
    """
       swaps the top two elements in opstack
    """
    def exch(self):
        pass

    """
        Implements roll operator.
        Pops two integer values (m, n) from opstack; 
        Rolls the top m values in opstack n times (if n is positive roll clockwise, otherwise roll counter-clockwise)
    """
    def roll(self):
        pass

    """
       Pops an integer from the opstack (size argument) and pushes an  empty dictionary onto the opstack.
    """
    def psDict(self):
        self.opstack.pop()
        empty_dict = {}
        self.opPush(empty_dict)

    """
       Pops the dictionary at the top of the opstack; pushes it to the dictstack.
    """
    def begin(self):
        pass

    """
       Removes the top dictionary from dictstack.
    """
    def end(self):
        pass
        
    """
       Pops a name and a value from opstack, adds the name:value pair to the top dictionary by calling define.  
    """
    def psDef(self):
        pass


    # ------- if/ifelse Operators --------------
    """
       Implements if operator. 
       Pops the `ifbody` and the `condition` from opstack. 
       If the condition is True, evaluates the `ifbody`.  
    """
    def psIf(self):
        pass
        # TO-DO in part2

    """
       Implements ifelse operator. 
       Pops the `elsebody`, `ifbody`, and the condition from opstack. 
       If the condition is True, evaluate `ifbody`, otherwise evaluate `elsebody`. 
    """
    def psIfelse(self):
        pass
        # TO-DO in part2


    #------- Loop Operators --------------
    """
       Implements repeat operator.   
       Pops the `loop_body` (FunctionValue) and loop `count` (int) arguments from opstack; 
       Evaluates (applies) the `loopbody` `count` times. 
       Will be completed in part-2. 
    """  
    def repeat(self):
        pass
        #TO-DO in part2
        
    """
       Implements forall operator.   
       Pops a `codearray` (FunctionValue) and an `array` (ArrayValue) from opstack; 
       Evaluates (applies) the `codearray` on every value in the `array`.  
       Will be completed in part-2. 
    """ 
    def forall(self):
        pass
        # TO-DO in part2

    #--- used in the setup of unittests 
    def clearBoth(self):
        self.opstack[:] = []
        self.dictstack[:] = []
