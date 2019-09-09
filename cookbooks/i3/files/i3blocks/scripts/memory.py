'''
メモリの使用率を表示
'''

import subprocess

class Memory(object):
    '''
    freeコマンドからavailableとtotalをとりだして使用率を計算・保持する
    '''
    def __init__(self):
        command = "free | grep -i mem: | awk '{print $7 \" \" $2}'"
        output = subprocess.check_output(command, shell=True)
        available, total = map(int, output.decode('UTF-8').rstrip().split(' '))

        self.__usage_rate = (total - available) * 100 / total

    def __repr__(self):
        pretty_usage_rtate = "{:.2f}%".format(self.__usage_rate)

        return f"<b><span color='#dc322f'>{pretty_usage_rtate}</span></b>" \
                if self.__usage_rate > 70.0 \
                else pretty_usage_rtate

def main():
    memory = Memory()
    print(memory)

main()

