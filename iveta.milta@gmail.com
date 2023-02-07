Create and populate text files 'admin.txt' and 'guest.txt'
with open('admin.txt', 'w') as f:
    f.write('John, Doe, Admin, 30\n')
    f.write('Jane, Smith, Admin, 35\n')

with open('guest.txt', 'w') as f:
    f.write('Bob, Johnson, Guest, 40\n')
    f.write('Sara, Brown, Guest, 25\n')

# 2. Combine and process the files
with open('admin.txt', 'r') as f1, open('guest.txt', 'r') as f2:
    data = f1.read() + f2.read()

# split by newline
entries = data.strip().split('\n')

# parse entries
parsed_entries = [entry.split(', ') for entry in entries]

# filter administrators
admins = [entry for entry in parsed_entries if entry[2] == 'Admin']

# calculate average age
admin_ages = [int(entry[3]) for entry in admins]
average_age = sum(admin_ages) / len(admin_ages)

# find oldest and youngest administrators
oldest = max(admin_ages)
youngest = min(admin_ages)

# 3. Print results
print(f'Combined file contains {len(admins)} administrators and {len(parsed_entries) - len(admins)} guests.')
print(f'Average age of administrators: {average_age}')
print(f'Oldest administrator: {oldest}')
print(f'Youngest administrator: {youngest}')
