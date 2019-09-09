import subprocess

class Volume(object):
    def __init__(self, device):
        command = f"pactl list sinks | grep -i 'volume' | head -1 | awk -F/ '{{print $2 \" \" $4}}' | xargs"
        output = subprocess.check_output(command, shell=True).decode('UTF-8').rstrip()
        self.__left, self.__right = output.split(' ')

        command = f"pactl list sinks | grep -i 'mute' | head -1 | awk '{{print $2}}' | xargs"
        output = subprocess.check_output(command, shell=True).decode('UTF-8').rstrip()
        self.__is_mute = output == 'yes'

    def __repr__(self):
        volume = max(float(self.__left[:-1]), float(self.__right[:-1]))
        volume_message = f"L: {self.__left} R: {self.__right}"
        if self.__is_mute:
            return f"\uf6a9 <b><span color='#dc322f'>mute</span></b>"
        elif volume <= 10.0:
            return f"\uf026 {volume_message}"
        elif volume <= 30.0:
            return f"\uf027 {volume_message}"
        return f"\uf028 {volume_message}"

def main():
    print(Volume('Master'))

main()

