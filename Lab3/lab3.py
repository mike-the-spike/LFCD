if __name__ == '__main__':
    # Initialize the lists
    states=[]
    transitions=[]
    initialState=[]
    alphabet=[]
    finalState=[]
    # Open the file
    f=open("input.txt", "r")
    
    # Read the file and split it into lines
    input = f.read().split("\n") 
    for line in input:
        # Split the line into the left and right parts of the transition
        lines=line.split(">")
        left=lines[0]
        right=lines[1]  
        # Get the state from the left part
        state=left.split(",")[0][1:]
        # Get the character from the left part
        character=left.split(",")[1][0:-1] # Extract only the character without the right bracket ')'
        # Check if the state is already in the list of states
        if state not in states:
            # Check if the state is the initial state
            if state[0] == "{":
                state=state.replace("{", "").replace("}", "") 
                if state not in initialState:
                    initialState.append(state)
            states.append(state)
        # Check if the character is already in the list of alphabet
        if character not in alphabet:
            alphabet.append(character)
        # Check if the next state is a final state
        if right[0] == "(":
            elem=right.replace("(", "").replace(")", "")
            if elem not in finalState:
                finalState.append(elem)
            if elem not in states:
                states.append(elem)
            transitions.append([state, elem])
        if right[0] == "[":
            elem = right.replace("[", "").replace("]", "")
            if elem not in states:
                states.append(elem)
            transitions.append([state, elem])

    # Print the initial state, states, alphabet, transitions, and final states
    print("Initial state: \n", initialState, "\n")
    print("States: \n", states, "\n")        
    print("Alphabet: \n", alphabet, "\n")
    print("Transitions: \n", transitions, "\n")
    print("Final states: \n", finalState, "\n")
