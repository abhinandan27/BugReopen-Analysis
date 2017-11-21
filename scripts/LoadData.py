import json
from pprint import pprint


product ={}
reopened_product={}
severity ={}
reopened={}
priority ={}
reopened_priority={}
assigned_to ={}
reopened_assigned_to={}

data = json.load(open('severity.json'))

for severity_key in data:
    for bug_id in data[severity_key]:
        severity[bug_id] = data[severity_key][bug_id][0]['what']
        if(len(data[severity_key][bug_id])>1):
            reopened[bug_id]=data[severity_key][bug_id][1]['what']

data = json.load(open('priority.json'))

for priority_key in data:
    for bug_id in data[priority_key]:
        priority[bug_id] = data[priority_key][bug_id][0]['what']
        if (len(data[priority_key][bug_id]) > 1):
            reopened_priority[bug_id] = data[priority_key][bug_id][1]['what']

data = json.load(open('component.json'))
component ={}
reopened_component={}
for component_key in data:
    for bug_id in data[component_key]:
        component[bug_id] = data[component_key][bug_id][0]['what']
        if (len(data[component_key][bug_id]) > 1):
            reopened_component[bug_id] = data[component_key][bug_id][1]['what']

data = json.load(open('product.json'))

for product_key in data:
    for bug_id in data[product_key]:
        product[bug_id] = data[product_key][bug_id][0]['what']
        if (len(data[product_key][bug_id]) > 1):
            reopened_product[bug_id] = data[product_key][bug_id][1]['what']

data = json.load(open('assigned_to.json'))

for assigned_to_key in data:
    for bug_id in data[assigned_to_key]:
        assigned_to[bug_id] = data[assigned_to_key][bug_id][0]['what']
        if (len(data[assigned_to_key][bug_id]) > 1):
            reopened_assigned_to[bug_id] = data[assigned_to_key][bug_id][1]['what']

products=[]
severities=[]
priorities=[]
assigned_tos=[]
bugs=[]
reopened_products=[]
reopened_severities=[]
reopened_priorities=[]
reopened_assigned_tos=[]
reopened_bugs=[]

for bug_id in product:
    bugs.append(bug_id)
    products.append(product.get(bug_id))
    severities.append(severity.get(bug_id))
    priorities.append(priority.get(bug_id))
    assigned_tos.append(assigned_to.get(bug_id))

for bug_id in reopened_product:
    reopened_bugs.append(bug_id)
    reopened_products.append(product.get(bug_id))
    reopened_severities.append(severity.get(bug_id))
    reopened_priorities.append(priority.get(bug_id))
    reopened_assigned_tos.append(assigned_to.get(bug_id))

