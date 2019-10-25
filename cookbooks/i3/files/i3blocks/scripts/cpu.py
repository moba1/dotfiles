import subprocess
import operator, functools
import glob

class CpuTemperature(object):
    def __init__(self):
        try:
            with open('/sys/class/thermal/thermal_zone0/temp') as f:
                self.__temperature = int(f.read()) // 1000
        except:
            self.__temperature = None

    def __repr__(self):
        if self.__temperature is None:
            return ''

        temperature = f"{self.__temperature} ℃"
        if self.__temperature >= 80:
            return f"<b><span color='#dc322f'>\uf2c7 {temperature}</span></b>"
        elif self.__temperature >= 70:
            return f"<b><span color='#b58900'>\uf2c8 {temperature}</span></b>"
        elif self.__temperature >= 60:
            return f"\uf2cb {temperature}"
        elif self.__temperature >= 50:
            return f"\uf2ca {temperature}"
        else:
            return f"\uf2c9 {temperature}"

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
            printable_usage = f"<b><span color='#cb4b16'>{printable_usage}</span></b>"
        elif self.__usage >= 90.0:
            printable_usage = f"<b><span color='#dc322f'>{printable_usage}%</span></b>"

        return f"\uf2db {printable_usage}"

def main():
    cpu_temp_mesasge = str(CpuTemperature())
    print(f"{Cpu()}{'' if len(cpu_temp_mesasge) == 0 else f' {cpu_temp_mesasge}'}")

main()

