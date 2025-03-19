```python
# parser.py
import subprocess
import re

def parse_alert_line(line):
    """
    Parse a log line from Snort.
    Expects a log line like: [12345] ALERT: potential threat detected ...
    Returns a dict with keys 'sid' and 'alert' if matched, otherwise None.
    """
    pattern = re.compile(r"\[(?P<sid>\d+)\] ALERT: (?P<alert>.*)")
    match = pattern.match(line)
    if match:
        return match.groupdict()
    return None

def follow_snort_logs(log_file):
    """
    Follows the Snort log file in real time using 'tail -f' and yields parsed alerts.
    """
    process = subprocess.Popen(
        ['tail', '-f', log_file],
        stdout=subprocess.PIPE,
        universal_newlines=True
    )
    
    try:
        for line in iter(process.stdout.readline, ''):
            line = line.strip()
            if line:
                parsed = parse_alert_line(line)
                if parsed:
                    yield parsed
                else:
                    yield {"error": f"Could not parse line: {line}"}
    except KeyboardInterrupt:
        process.kill()
    finally:
        process.terminate()
```

### **How It Works**

- **Real-Time Monitoring:** The `parser.follow_snort_logs(log_file)` function uses `tail -f` to stream the Snort log file in real time.
- **Parsing Alerts:** Each log line is parsed with a regular expression to extract the `sid` and `alert` message.
- **CLI Alerts:** The **`alert.py`** script then prints out the alert information on the console.

---

# Real-Time Snort Alert Monitor Documentation

## **Core Components**

## 1. **parse_alert_line(line: str) -> dict | None**

**Purpose**: Extracts structured data from raw Snort alert logs  
**Regex Pattern**: `r"$$(?P<sid>\d+)$$ ALERT: (?P<alert>.*)"`

```python
[           # Literal opening bracket
(?P<sid>\d+)  # Capture group 'sid' for numeric Signature ID
\] ALERT:     # Literal closing bracket and alert prefix
(?P<alert>.*)  # Capture group 'alert' for everything after
```


**Input Example**:  
`"[14956] ALERT: ET POLICY curl User-Agent Outbound"`

**Output**:

```python
{'sid': '14956', 'alert': 'ET POLICY curl User-Agent Outbound'}
```

**Adaptation Notes**:

- Modify regex to match your Snort log format
- Add capture groups for IPs/timestamps if needed:

```python
r"\[(?P<sid>\d+)\] (\d+-\d+-\d+) (?P<src_ip>\d+\.\d+\.\d+\.\d+).*ALERT: (?P<alert>.*)"
```

## 2. **follow_snort_logs(log_file: str) -> Generator**

**Purpose**: Tails log file and yields parsed alerts in real-time

**Key Implementation Details**:

```python
subprocess.Popen(
    ['tail', '-f', log_file],  # Continuous file following
    stdout=subprocess.PIPE,    # Stream output to Python
    universal_newlines=True    # Handle as text not bytes
)
```

**Flow**:

1. Starts `tail -f` as subprocess
2. Reads output line-by-line indefinitely
3. Yields parsed alerts or error objects
4. Handles graceful termination on CTRL+C