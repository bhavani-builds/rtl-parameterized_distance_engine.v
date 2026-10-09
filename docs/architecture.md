
# AI Edge Anomaly Detection Accelerator
## Hardware Architecture

```text
       Input Sensor Features
                |
                v
       +------------------+
       | Feature Extractor|
       +------------------+
                |
                v
       +------------------+
       | Distance Engine  |
       | Squared Distance |
       +------------------+
                |
                v
       +------------------+
       | Anomaly Score    |
       | Scaling (/1024)  |
       +------------------+
                |
                v
       +------------------+
       | Threshold        |
       | Classifier       |
       +------------------+
                |
                v
       Normal / Anomaly Result

       +------------------+
       | FSM Controller   |
       | Controls Stages  |
       +------------------+

       +------------------+
       | Performance      |
       | Monitor          |
       +------------------+
```

## Functional Blocks

- **Feature Extractor:** Captures the input feature vector.
- **Distance Engine:** Computes squared differences between input and reference features.
- **Anomaly Score:** Scales the distance into a score.
- **Threshold Classifier:** Classifies samples as normal or anomalous.
- **FSM Controller:** Coordinates the processing stages.
- **Performance Monitor:** Measures inference latency in clock cycles.

## Verification

Python reference models check expected distance calculations
and anomaly classifications. GitHub Actions runs the Python tests
on pushes and pull requests.
