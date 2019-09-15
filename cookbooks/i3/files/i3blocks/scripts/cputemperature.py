class CpuTemperatur(object):
    def __init__(self, temperature):
        self.__temperature = temperature

    def __repr__(self):
        temperature = "{:.2f} °C".format(self.__temperature // 1000)
        printable_message = ""
        if self.__temperature < 45000:
            return f"\uf2cb {temperature}"
        elif self.__temperature < 55000:
            return f"\uf2ca {temperature}"
        elif self.__temperature < 70000:
            return f"\uf2c9 {temperature}"
        elif self.__temperature < 80000:
            return f"<b><span color='#b58900'>\uf2c8 {temperature}</span></b>"
        else:
            return f"<b><span color='#dc322f'>\uf2c7 {temperature}</span></b>"

def measure_temperature():
    with open('/sys/class/thermal/thermal_zone0/temp') as f:
        try:
            print(CpuTemperatur(int(f.read().rstrip())))
        except:
            return f"<b><span color='#dc322f'>invalid temperature</span></b>"

def main():
    measure_temperature()

main()

