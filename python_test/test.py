import sys
import csv
'''
with open("names.txt", "a") as fp:
    for i in sys.argv[1:]:
        fp.write(f'{i}\n')


with open("names.txt", "r") as fp:
    for name in fp:
        print(name.rstrip())
'''

students = []

with open("names.csv") as fp:
    reader = csv.reader(fp)
    for name, house in reader:
        student = {"name": name, "house": house}
        students.append(student)

for student in sorted(students, key=lambda student: student["name"]):
    print(f"{student['name']} is in {student['house']}")
