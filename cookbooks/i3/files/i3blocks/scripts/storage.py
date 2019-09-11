'''
ディスクの使用量を表示
TODO:
    接続されたディスクを自動検出
'''

import subprocess
import enum
import re

class ByteUnit(enum.Enum):
    '''
    バイト単位を表す
    '''
    BYTE      = 'B'
    KILO_BYTE = 'KB'
    MEGA_BYTE = 'MB'
    GIGA_BYTE = 'GB'
    TERA_BYTE = 'TB'
    PETA_BYTE = 'PB'
    EXA_BYTE  = 'EB'
    YOTA_BYTE = 'YB'
    ZETA_BYTE = 'ZB'

class ByteSize(object):
    '''
    バイトサイズを保持する
    '''
    def __init__(self, byte):
        self.__byte = byte

    def byte(self, byte_unit = ByteUnit.BYTE):
        # 各接頭辞に合わせて加工
        exponent = 0
        if byte_unit == ByteUnit.KILO_BYTE:
            exponent = 1
        elif byte_unit == ByteUnit.MEGA_BYTE:
            exponent = 2
        elif byte_unit == ByteUnit.GIGA_BYTE:
            exponent = 3
        elif byte_unit == ByteUnit.TERA_BYTE:
            exponent = 4
        elif byte_unit == ByteUnit.PETA_BYTE:
            exponent = 5
        elif byte_unit == ByteUnit.EXA_BYTE:
            exponent = 6
        elif byte_unit == ByteUnit.YOTA_BYTE:
            exponent = 7
        elif byte_unit == ByteUnit.ZETA_BYTE:
            exponent = 8
        return self.__byte / (1024**exponent)

class DiskType(enum.Enum):
    SERIAL = "\uf0a0"
    MULTI_MEDIA_CARD = "\uf7c2"
    UNKNOWN = "\uf128"

    @classmethod
    def guess_disk_type(cls, partition):
        if re.search(r'^/dev/sd.?([1-9][0-9]*)?$', partition):
            return cls.SERIAL
        elif re.search(r'/dev/mmcblk[0-9]+p[0-9]+$', partition):
            return cls.MULTI_MEDIA_CARD

        return cls.UNKNOWN

class Disk(object):
    '''
    ディスクの状態を保持する
    保持するのは

    * ディスクの使用量
    * 利用できるサイズ

    の2つ
    '''
    def __init__(self, partition, byte_unit = ByteUnit.GIGA_BYTE):
        # dfでディスクの使用量と利用可能量を取得
        command = f"df --output=avail --output=used --block-size=1 {partition} | tail -1"
        output = subprocess.check_output(command, shell=True).decode('UTF-8').rstrip()

        self.__available, self.__used = map(
            ByteSize,
            map(int, output.strip().split(' '))
        )
        self.__byte_unit = byte_unit
        self.__partition = partition

    def __repr__(self):
        disk_type = DiskType.guess_disk_type(self.__partition)
        disk = f"{disk_type.value} {self.__partition.split('/')[-1]}"
        if disk_type == DiskType.UNKNOWN:
            return f"{disk} <b><span color='#dc322f'>unknown disk type</span></b>"

        if self.__available.byte() == 0:
            return f"{disk} <b><span color='#dc322f'>no space</span></b>"

        # ディスクの開き率を計算
        available_rate = (self.__available.byte() - self.__used.byte()) * 100 / self.__available.byte()

        available, used = self.__available.byte(self.__byte_unit), self.__used.byte(self.__byte_unit)
        raw_disk_usage_message = "{:.2f} [{}]".format(used, self.__byte_unit.value)
        # ディスクの使用量に応じて色変える
        if available_rate <= 10:
            # 10%以下しか利用できない状態は危険なので、赤色に
            raw_disk_usage_message = f"<b><span color='#dc322f'>{raw_disk_usage_message}</span></b>"
        elif available_rate <= 20:
            # 20%以下か利用できない場合は警告の意味を込めてオレンジ色に
            raw_disk_usage_message = f"<b><span color='#cb4b16'>{raw_disk_usage_message}</span></b>"

        return f"{disk} {raw_disk_usage_message}"

def get_disks():
    command = "df | awk '$6 != \"/boot\"' | awk 'match($1,\"/dev/\") != 0' | awk '{print $1}'"
    output = subprocess.check_output(command, shell=True).decode('UTF-8').rstrip()

    return output.split("\n")

def main():
    print(
        ' '.join(
            map(lambda partition: str(Disk(partition)), get_disks())
        )
    )

main()

