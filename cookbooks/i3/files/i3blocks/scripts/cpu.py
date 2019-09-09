import subprocess
import operator, functools

class Cpu(object):
    def __init__(self):
        command = "mpstat | tail -1 | awk '{print $4 \" \" $5 \" \" $6}'"
        output = subprocess.check_output(command, shell=True).decode('UTF-8').rstrip()

        self.__usage = functools.reduce(
            operator.add,
            map(float, output.strip().split(' '))
        )

    def __repr__(self):
        printable_usage = "{:.2f}%".format(self.__usage)
        if self.__usage >= 70:
            return f"<b><span color='#cb4b16'>{printable_usage}</span></b>"
        elif self.__usage >= 90.0:
            return f"<b><span color='#dc322f'>{printable_usage}%</span></b>"

        return printable_usage

def main():
    print(Cpu())

main()

