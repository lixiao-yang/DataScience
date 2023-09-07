def var_number(lap, position, car):
    return 36 * (lap - 1) + 6 * (position - 1) + car + 1

def generate_boilerplate_dimacs(N):
    clauses = []

    # Rule 1: A car must be somewhere in the race.
    for lap in range(1, 3):
        for car in range(N):
            clause = [var_number(lap, position + 1, car) for position in range(N)]
            clauses.append(clause)

    # Rule 2: A car can't be in two places at once.
    for lap in range(1, 3):
        for car in range(N):
            for pos1 in range(N):
                for pos2 in range(pos1 + 1, N):
                    clauses.append([-var_number(lap, pos1 + 1, car), -var_number(lap, pos2 + 1, car)])

    # Rule 3: Two cars can't be in the same position at the same time.
    for lap in range(1, 3):
        for position in range(N):
            for car1 in range(N):
                for car2 in range(car1 + 1, N):
                    clauses.append([-var_number(lap, position + 1, car1), -var_number(lap, position + 1, car2)])

    return clauses


def generate_label_shift_dimacs(N):
    label_shift_clauses = []
    for car in range(N):
        for pos_lap1 in range(1, N+1):
            var_lap1 = var_number(1, pos_lap1, car)
            possible_positions_lap2 = [pos_lap1 - car, pos_lap1 + car]

            valid_positions_lap2 = [pos for pos in possible_positions_lap2 if 1 <= pos <= N]
            if valid_positions_lap2:
                for pos_lap2 in valid_positions_lap2:
                    var_lap2 = var_number(2, pos_lap2, car)
                    label_shift_clauses.append([-var_lap1, var_lap2])
            else:
                label_shift_clauses.append([-var_lap1])

    return label_shift_clauses

def generate_amazing_race_dimacs(N):
    # Generate boilerplate DIMACS
    boilerplate_clauses = generate_boilerplate_dimacs(N)
    label_shift_clauses = generate_label_shift_dimacs(N)

    clauses = boilerplate_clauses + label_shift_clauses

    # Write to file
    with open("dimacs_output.txt", "w") as f:
        f.write(f"p cnf {var_number(2, N, N-1)} {len(clauses)}\n")
        for clause in clauses:
            clause_str = " ".join(map(str, clause)) + " 0\n"
            f.write(clause_str)

    print("DIMACS file generated.")

# Generate DIMACS for N = 6
# generate_amazing_race_dimacs(6)
generate_boilerplate_dimacs(6)
