# Rabi Roshan
# Ceaser Cypher


def ceaser(name, k1):
    result = ""

    for i in range(len(name)):
        ch = name[i]
        if(ch.isupper()):
            result = result + chr((ord(ch)+k1 - 65) % 26 + 65)

        if(ch.islower()):
            result = result + chr((ord(ch)+k1 - 97) % 26 + 97)

    return result


def main():
    n = str(raw_input("Input the text Message:"))
    key = int(raw_input("Input the Key:"))

    cypher = str(ceaser(n, key))
    print("Decrypted Message:" + cypher)


main()
