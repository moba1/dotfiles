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
        if self.__is_mute:
            return f"<b><span color='#dc322f'>mute</span></b>"
        return f"L: {self.__left} R: {self.__right}"

def main():
    print(Volume('Master'))

main()

