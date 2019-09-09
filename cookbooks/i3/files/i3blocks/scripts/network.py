'''
ネットワークの状態を表示
'''

import subprocess
import sys

def get_ipv4_address(device_name):
    '''
    ipコマンド使ってdevice_nameで指定された
    インターフェースのIPv4アドレスを返す

    Args:
        device_name str:
            IPv4アドレスを見たいインターフェース名

    Returns:
        str:
            IPv4アドスが取得できればIPv4アドレスを、取得できなければ空文字列
    '''
    command = f"ip -4 -o -f inet a show dev {device_name} | awk '{{print $4}}' | cut -f1 -d/"
    return subprocess.check_output(command, shell=True).decode('UTF-8').rstrip()

class Ethernet(object):
    '''
    Ethernetカードの情報を保持する。
    保持する情報は

    * IPv4アドレス
    * 接続状態

    の2つ。
    strするとこれらの情報をi3block用に加工してくれる
    '''
    def __init__(self, device_name):
        # ルーターへ接続できているかをbool値で取得
        command = f"ip link show {device_name} | grep -o 'state [^ ]*' | awk '{{print $2}}'"
        output = subprocess.check_output(command, shell=True).decode('UTF-8').rstrip()
        self.__is_linked = output == 'UP'

        self.__ipv4_address = get_ipv4_address(device_name)

    def __repr__(self):
        message = ''
        if not self.__is_linked:
            # そもそも接続されていない場合、正確には
            # 接続されていなくてもIPアドレスが
            # リリースされていない可能性はあるが、そもそも
            # 通信ができないので、リンクが
            # 接続されていないものとして扱う
            message = '<b><span color="#dc322f">no link</span></b>'
        elif len(self.__ipv4_address) == 0:
            # リンクは接続されているが、IPアドレスが割り振られていない
            message = '<b><span color="#dc322f">no ip</span></b>'
        else:
            # リンクが接続されており、IPアドレスが割り振られている
            message = self.__ipv4_address
        return f"\uf796 {message}"

class Wireless(object):
    '''
    Wirelessカードの情報を保持する。
    保持する情報は

    * IPv4アドレス
    * 接続状態
    * APとの接続強度[dBm]

    の2つ。
    strするとこれらの情報をi3block用に加工してくれる
    '''
    def __init__(self, device_name):
        # APへ接続されているかをbool値で取得
        command = f"ip link show {device_name} | grep -o 'state [^ ]*' | awk '{{print $2}}'"
        output = subprocess.check_output(command, shell=True).decode('UTF-8').rstrip()
        self.__is_linked = output == 'UP'

        self.__ipv4_address = get_ipv4_address(device_name)

        # APへの接続強度を取得
        command = f"iw dev {device_name} link | grep signal | awk '{{print $2}}'"
        output = subprocess.check_output(command, shell=True).decode('UTF-8').rstrip()
        try:
            self.__signal = int(output)
        except:
            self.__signal = None

    def __repr__(self):
        color = ''
        if self.__signal is None or self.__signal <= -80:
            color = "#dc322f"
        elif self.__signal <= -70:
            color = "#b58900"
        else:
            color = "#002b36"

        message = ''
        error_message_template = '<b><span color="#dc322f">{}</span></b>'
        if not self.__is_linked:
            # そもそも接続されていない場合、正確には
            # 接続されていなくてもIPアドレスが
            # リリースされていない可能性はあるが、そもそも
            # 通信ができないので、リンクが
            # 接続されていないものとして扱う
            message = error_message_template.format('no link')
        elif len(self.__ipv4_address) == 0:
            # リンクは接続されているが、IPアドレスが割り振られていない
            message = error_message_template.format('no ip')
        elif self.__signal is None:
            # APとの接続強度が弱すぎる
            message = error_message_template.format('signal strength is too weak')
        else:
            # リンクが接続されており、IPアドレスが割り振られている
            if self.__signal <= -80:
                message = f"<span color='#dc322f'>{self.__ipv4_address}</span>"
            elif self.__signal <= -70:
                message = f"<span color='#b58900'>{self.__ipv4_address}</span>"
            else:
                message = self.__ipv4_address
        return f"\uf1eb {message}"

def main():
    network_status = map(str, [Ethernet(sys.argv[1]), Wireless(sys.argv[2])])
    print(' '.join(filter(lambda x: len(x) != 0, network_status)))

main()

