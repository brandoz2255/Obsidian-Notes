**app.py** that uses both **parser.py** and **alert.py** to handle HTTP requests. In this example, we’ll create two endpoints:

1. **/start** – Starts a background thread that continuously monitors the Snort log file (using the parser logic) and triggers alerts (using simple CLI printouts from our alert logic).
2. **/alerts** – Returns any alerts collected since the last request.

```python
# app.py
from flask import Flask, jsonify
import threading
import time

# Import our custom modules
import parser      # Contains parse_alert_line() and follow_snort_logs()
import alert       # For now, alert.py prints CLI alerts (could be expanded)

app = Flask(__name__)

# Global list to store alerts
alerts = []

def monitor_snort():
    """
    Monitor the Snort log file in real time.
    This function runs in a background thread.
    It uses parser.follow_snort_logs() to yield parsed alerts,
    then appends them to the global alerts list.
    """
    log_file = '/var/log/snort/alert.fast'  # Adjust as needed
    for alert_data in parser.follow_snort_logs(log_file):
        # Check if the line was parsed correctly
        if "error" in alert_data:
            message = alert_data["error"]
        else:
            message = f"SID: {alert_data.get('sid')} | Message: {alert_data.get('alert')}"
        print("CLI Alert:", message)  # This mimics alert.py's CLI behavior
        alerts.append(message)
        time.sleep(0.1)  # Optional: throttle the loop a bit

@app.route('/start', methods=['GET'])
def start_monitoring():
    """
    Start the Snort log monitoring thread.
    This endpoint can be called once to initiate continuous alert monitoring.
    """
    # Check if the monitor thread is already running
    if not any(t.name == "snort_monitor" for t in threading.enumerate()):
        thread = threading.Thread(target=monitor_snort, name="snort_monitor", daemon=True)
        thread.start()
        return jsonify({"status": "Snort monitoring started"}), 200
    else:
        return jsonify({"status": "Monitoring already running"}), 200

@app.route('/alerts', methods=['GET'])
def get_alerts():
    """
    Return all collected alerts since the last request.
    This endpoint lets you see the parsed alerts from the Snort logs.
    """
    global alerts
    current_alerts = alerts.copy()
    alerts.clear()  # Clear alerts after returning them
    return jsonify({"alerts": current_alerts}), 200

if __name__ == '__main__':
    # Start the Flask app on port 5000
    app.run(host="0.0.0.0", port=5000, debug=True)
```

### **How This Works**

- **Background Monitoring:**  
    The `monitor_snort()` function uses `parser.follow_snort_logs(log_file)` (from your parser.py) to continuously read new lines from the Snort log file. For each parsed alert, it prints a message to the CLI (simulating alert.py’s behavior) and appends the message to a global `alerts` list.
    
- **/start Endpoint:**  
    When you make a GET request to `/start`, a background thread is spawned (if not already running) to start monitoring the logs.
    
- **/alerts Endpoint:**  
    When you access `/alerts`, it returns all the alerts collected so far in JSON format and clears the list, so you only get new alerts on subsequent requests.

---

### **Next Steps & Considerations**

- **Integration with alert.py:**  
    Currently, the alert logic is simple (printing to CLI). If you want to expand this—say, to trigger external notifications—you can add functions in alert.py and call them from within `monitor_snort()`.
    
- **Concurrency & Persistence:**  
    For production use, consider using a more robust message queue or a persistent datastore to handle alerts, especially if the alert rate is high.
    
- **Live Updates:**  
    In the future, you might explore techniques like Server-Sent Events (SSE) or WebSockets to push alerts to a front-end in real time.
    - This we need for Next.js 
    - WebSockets