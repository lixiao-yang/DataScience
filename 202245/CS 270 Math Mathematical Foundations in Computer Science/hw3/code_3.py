def generate_dimacs(N):
    clauses = []

    # cars don't disappear
    for lap in [1, 2]:
        for pos in range(N):
            clause = []
            for car in range(N):
                var = 36*(lap - 1) + 6*(pos) + car + 1
                clause.append(var)
            clauses.append(clause)

    # a single car can't be in two places at once
    for lap in [1, 2]:
        for car in range(N):
            for pos1 in range(N):
                for pos2 in range(pos1 + 1, N):
                    var1 = 36*(lap - 1) + 6*(pos1) + car + 1
                    var2 = 36*(lap - 1) + 6*(pos2) + car + 1
                    clauses.append([-var1, -var2])

    # two cars can't be in the same position at the same time
    for lap in [1, 2]:
        for pos in range(N):
            for car1 in range(N):
                for car2 in range(car1 + 1, N):
                    var1 = 36*(lap - 1) + 6*(pos) + car1 + 1
                    var2 = 36*(lap - 1) + 6*(pos) + car2 + 1
                    clauses.append([-var1, -var2])

    # Every car must be label-shifted
    for car in range(N):
        for pos1 in range(N):
            clause = []
            var1 = 36*(1 - 1) + 6*(pos1) + car + 1  # Car in pos1 in lap1
            clause.append(-var1)
            for shift in [-car, car]:
                pos2 = pos1 + shift
                if 0 <= pos2 < N:  # Check if the new position is valid
                    var2 = 36*(2 - 1) + 6*(pos2) + car + 1  # Car in pos2 in lap2
                    clause.append(var2)
            clauses.append(clause)

    return clauses

def print_dimacs(clauses, N, filename="output2.txt"):
    with open(filename, "w") as f:
        f.write("p cnf {} {}\n".format(36+6*(N-1)+N, len(clauses)))
        for clause in clauses:
            f.write(" ".join(map(str, clause)) + " 0\n")

N = int(input("Enter the number of cars: "))
clauses = generate_dimacs(N)
print_dimacs(clauses, N)