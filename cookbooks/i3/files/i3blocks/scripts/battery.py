'''
バッテリーの状態を表示
'''

import syslog
import sys

def parse_int_file(file):
    '''
    key=valueのみがあるiniファイルのパースをする

    Args:
        file str:
            パースしたいiniファイルへのパス
    Returns:
        dict:
            key=valueをPythonのdictに読み替えた結果
    '''
    dic = {}
    with open(file, 'r') as f:
        for line in f.readlines():
            key, value = line.rstrip().split('=')
            dic[key] = value

    return dic

class Battery(object):
    '''
    バッテーリの情報を保持する。
    次の2つを保持しておく

    * バッテリーが充電されているのか、それとも放電されているのか
    * バッテリー残量
    '''
    def __init__(self, battery_data_file):
        try:
            battery_status = parse_int_file(battery_data_file)

            self._remain_rate = float(battery_status['POWER_SUPPLY_ENERGY_NOW']) \
                * 100.0 / float(battery_status['POWER_SUPPLY_ENERGY_FULL'])
            self._power_supply_status = battery_status['POWER_SUPPLY_STATUS']
        except FileNotFoundError:
            pass

    def __repr__(self):
        has_remain_rate = hasattr(self, '_remain_rate')
        has_power_supply_status = hasattr(self,  '_power_supply_status')
        if not has_remain_rate and not has_power_supply_status:
            # バッテリーがはずされた状態
            return "\uf1e6 pluged"
        elif has_remain_rate and has_power_supply_status:
            # バッテリーの情報が正しく取得できた場合
            battery_status_message_templat = ''
            battery_remain_rate_message = "{:.2f}%".format(self._remain_rate)
            if self._remain_rate < 10.0:
                # バッテリー残量ガ10%未満
                battery_status_message_template \
                    = f"\uf244{{}}<b><span color='#dc322f'>{battery_remain_rate_message}</span></b>"
            elif self._remain_rate <= 20.0:
                # バッテリー残量が20%以下
                battery_status_message_template \
                    = f"\uf243{{}}<b><span color='#cb4b16'>{battery_remain_rate_message}</span></b>"
            elif self._remain_rate <= 50.0:
                # バッテリーの残量が50%以下
                battery_status_message_template = f"\uf242{{}}{battery_remain_rate_message}"
            elif self._remain_rate < 80.0:
                # バッテリー残量が80%未満
                battery_status_message_template = f"\uf241{{}}{battery_remain_rate_message}"
            else:
                battery_status_message_template = f"\uf240{{}}{battery_remain_rate_message}"

            battery_status_message = ''
            if self._power_supply_status in ['Discharging', 'Unknown']:
                # バッテリーは放電中
                battery_status_message = battery_status_message_template.format(' ')
            elif self._power_supply_status == 'Charging':
                # バッテリーは充電中
                battery_status_message = battery_status_message_template.format(" \uf0e7 ")
            else:
                # 形式が変わって放電か充電なのかが
                # わからなくなった場合などはログに残しておく
                syslog.syslog(
                    syslog.LOG_EMERG,
                    f"unknown power supply status: {self._power_supply_status}"
                )

            return battery_status_message

        else:
            # バッテリーを表示しているファイルの形式が変わった場合
            # ログにそのことを残しておいて例外を出す
            syslog.syslog(
                syslog.LOG_EMERG,
                "invalid battery format. check battery data file"
            )
            raise Exception('unknown battery data format')

def main():
    battery_data_file = f"/sys/class/power_supply/{sys.argv[1]}/uevent"
    print(Battery(battery_data_file))

main()

