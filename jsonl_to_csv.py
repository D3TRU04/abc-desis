import json
import csv

input_file = "r_ABCDesis_posts.jsonl"
output_file = "r_ABCDesis_posts.csv"

data = []
fieldnames = set()

# First pass: read all data and gather all keys
with open(input_file, "r") as f:
    for line in f:
        obj = json.loads(line)
        data.append(obj)
        fieldnames.update(obj.keys())

fieldnames = sorted(fieldnames)

# Write to CSV
with open(output_file, "w", newline="", encoding="utf-8") as csvfile:
    writer = csv.DictWriter(csvfile, fieldnames=fieldnames, extrasaction='ignore')
    writer.writeheader()
    writer.writerows(data)

print(f"✅ Converted {len(data)} records to {output_file}")

