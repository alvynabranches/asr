import json, random, os

NUMBERS = {1: "one", 2: "two", 3: "three", 4: "four", 5: "five", 6: "six", 7: "seven", 8: "eight", 9: "nine", 10: "ten", 11: "eleven", 12: "twelve"}

INIT_SENTENCE_OPTIONS = list({
    "i will have", 
    "we will have", 
    "we want", 
    "i want", 
    "can we have", 
    "can i have", 
    "can we get", 
    "can i get", 
    "will i get", 
    "will we get", 
    "i will try", 
    "we will try",
    "i'll try", 
    "we'll have try", 
    "we want", 
    "i want", 
    "can you give me", 
    "can you give us", 
    "i'll have", 
    "we'll have", 
    "can you bring me", 
    "can you bring us", 
    "shall i have", 
    "shall we have", 
    "can you bring me", 
    "can you give us", 
    "make me", 
    "make us", 
    "give me", 
    "give us", 
    "order me", 
    "order us", 
    "get me", 
    "get us", 
    "would i", 
    
})

ORDERS = json.load(open(os.path.join(os.path.dirname(__file__), "dishes.json")))

def generate_sentences(n:int):
    sentences = []
    if len(ORDERS[n]["options"]) > 0:
        for i in range(len(ORDERS[n]["options"])):
            sentences.append((INIT_SENTENCE_OPTIONS[random.randint(0, len(INIT_SENTENCE_OPTIONS))] + " " + ORDERS[n]["item"] + " with " + ORDERS[n]["options"][i].format(NUMBERS[random.randint(1, 5)]) if "{}" in ORDERS[n]["options"][i] else INIT_SENTENCE_OPTIONS[random.randint(0, len(INIT_SENTENCE_OPTIONS))] + " " + ORDERS[n]["item"] + " with " + ORDERS[n]["options"][i]).lower())
    else:
        sentences.append((INIT_SENTENCE_OPTIONS[random.randint(0, len(INIT_SENTENCE_OPTIONS))] + " " + ORDERS[n]["item"]).lower())
    return sentences

def generate_orders(range):
    orders = []
    errors = []
    for i in range:
        try: orders += generate_sentences(i)
        except Exception: errors.append(i)
    return orders, errors

orders, errors = generate_orders(range(len(ORDERS)))
open(os.path.join(os.path.dirname(__file__), "orders.txt"), 'w').write("\n".join(orders) + "\n")

for _ in range(1000):
    orders, errors = generate_orders(errors)
    open(os.path.join(os.path.dirname(__file__), "orders.txt"), 'a').write("\n".join(orders) + "\n")
    if len(errors) == 0: break
    print(_)
    
if len(errors) > 0: print(errors)
