import json
import sys

with open("info.json", "r") as read_file:
    data = json.load(read_file)['securitygroups']
for i in data:
    for j in i['properties']['securityRules']:
        if j['properties']['destinationPortRange'] == "3389" and j['properties']['access'] == "Allow":
            with open("nsg", "a+") as file_object:
                file_object.seek(0)
                data = file_object.read(100)
                if len(data) == 0 :
                    file_object.write("[nsg]\n")
                else:
                    file_object.write("\n")
                file_object.write(i['name']+":"+j['name'])
                print(i['name'])
