def generate_dimacs(N):
    clauses = []

    # cars don't disappear
    for lap in [1, 2]:
        for car in range(N):
            clause = []
            for pos in range(N):
                var = ((lap - 1) * N + car) * N + pos + 1
                clause.append(var)
            clauses.append(clause)

    # a single car can't be in two places at once
    for lap in [1, 2]:
        for car in range(N):
            for pos1 in range(N):
                for pos2 in range(pos1 + 1, N):
                    var1 = ((lap - 1) * N + car) * N + pos1 + 1
                    var2 = ((lap - 1) * N + car) * N + pos2 + 1
                    clauses.append([-var1, -var2])

    # two cars can't be in the same position at the same time
    for lap in [1, 2]:
        for pos in range(N):
            for car1 in range(N):
                for car2 in range(car1 + 1, N):
                    var1 = ((lap - 1) * N + car1) * N + pos + 1
                    var2 = ((lap - 1) * N + car2) * N + pos + 1
                    clauses.append([-var1, -var2])

    # Every car must be label-shifted
    for car in range(N):
        for pos1 in range(N):
            clause = []
            var1 = car * N + pos1 + 1  # Car in pos1 in lap1
            clause.append(-var1)
            for shift in [-car, car]:
                pos2 = pos1 + shift
                if 0 <= pos2 < N:  # Check if the new position is valid
                    var2 = N * N + car * N + pos2 + 1  # Car in pos2 in lap2
                    clause.append(var2)
            clauses.append(clause)

    return clauses

def print_dimacs(clauses, N, filename="output.txt"):
    with open(filename, "w") as f:
        f.write("p cnf {} {}\n".format(36+6*(N-1)+N, len(clauses)))
        for clause in clauses:
            f.write(" ".join(map(str, clause)) + " 0\n")

N = int(input("Enter the number of cars: "))
clauses = generate_dimacs(N)
print_dimacs(clauses, N)
