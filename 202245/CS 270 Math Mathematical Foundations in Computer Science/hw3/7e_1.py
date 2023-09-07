def generate_dimacs(N):
    clauses = []

    # cars don't disappear
    for lap in [1, 2]:
        for pos in range(N):
            clause = []
            for car in range(1, N+1):
                var = N*N*(lap - 1) + N*(pos) + car + 1
                clause.append(var)
            clauses.append(clause)

    # a single car can't be in two places at once
    for lap in [1, 2]:
        for car in range(N):
            for pos1 in range(1, N+1):
                for pos2 in range(pos1 + 1, N):
                    var1 = N*N*(lap - 1) + N*(pos1) + car + 1
                    var2 = N*N*(lap - 1) + N*(pos2) + car + 1
                    clauses.append([-var1, -var2])

    # two cars can't be in the same position at the same time
    for lap in [1, 2]:
        for pos in range(1, N+1):
            for car1 in range(N):
                for car2 in range(car1 + 1, N):
                    var1 = N*N*(lap - 1) + N*(pos) + car1 + 1
                    var2 = N*N*(lap - 1) + N*(pos) + car2 + 1
                    clauses.append([-var1, -var2])

    for car in range(N):
        for pos in range(1, N+1):
            amazing_pos1 = pos - car
            amazing_pos2 = pos + car
        if amazing_pos2 <= N and amazing_pos1>0:
            var1_lap1 = (N*N)*(1 - 1) + N*(pos - 1) + car +1
            var1_lap2 = (N*N)*(2 - 1) + N*(amazing_pos1 - 1) + car +1
            var2_lap2 = (N*N)*(2 - 1) + N*(amazing_pos2 - 1) + car +1
            clause.append(f"-{var1_lap1} {var1_lap2} {var2_lap2} 0")
        elif amazing_pos2 > N and amazing_pos1 > 0:
            var1_lap1 = (N*N)*(1 - 1) + N*(pos - 1) + car +1
            var1_lap2 = (N*N)*(2 - 1) + N*(amazing_pos1 - 1) + car +1
            clause.append(f"-{var1_lap1} {var1_lap2} 0")
        elif amazing_pos1 <= 0 and amazing_pos2 > 0:
            var1_lap1 = (N*N)*(1 - 1) + N*(pos - 1) + car +1
            var2_lap2 = (N*N)*(2 - 1) + N*(amazing_pos2 - 1) + car +1
            clause.append(f"-{var1_lap1} {var2_lap2} 0")
        else:
            var1_lap1 = (N*N)*(1 - 1) + N*(pos - 1) + car +1
            clause.append(f"-{var1_lap1} 0")
            
    return clauses

def print_dimacs(clauses, N, filename="7e.txt"):
    with open(filename, "w") as f:
        f.write("p cnf {} {}\n".format(N*N+N*(N-1)+N, len(clauses)))
        for clause in clauses:
            f.write(" ".join(map(str, clause)) + " 0\n")

N = int(input("Enter the number of cars: "))
clauses = generate_dimacs(N)
print_dimacs(clauses, N)