from datetime import datetime
import random
import time

import influxdb_client as db
from influxdb_client import InfluxDBClient
from influxdb_client.client.write_api import ASYNCHRONOUS


URL = "http://localhost:8086"
TOKEN = "token"
ORG = "inspermileage"
BUCKET = "trainee"


def main():
    acceleration = 0.0
    speed = 0.0
    interval = 1.0

    with InfluxDBClient(url=URL, token=TOKEN, org=ORG) as client:
        with client.write_api(write_options=ASYNCHRONOUS) as write_client:
            while True:
                speed += acceleration * interval
                acceleration = random.uniform(-1.0, 1.0)

                if speed < 0.0:
                    speed = 0.0
                elif speed > 100:
                    speed = 100.0

                now = datetime.utcnow()
                speedPoint = (
                    db.Point("carro")
                    .tag("roda", "Roda")
                    .field("velocidade", speed)
                    .time(now, db.WritePrecision.MS)
                )
                response = write_client.write(bucket=BUCKET, record=speedPoint)

                while not response.ready():
                    response.wait()

                if not response.successful():
                    raise Exception("Request not successful!")

                print(f"{now.time()}: {speed:+07.2f} km/h ({acceleration:+.2f})\r", end="")
                time.sleep(interval)


if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        pass
