Black box diagram for the web app



``` python
app/
├── Dockerfile                # Docker setup for Flask app
├── requirements.txt          # Python dependencies
├── app/
│   ├── __init__.py           # App initialization
│   ├── main.py               # Main application logic
│   ├── routes.py             # Flask routes
│   ├── templates/            # HTML templates for UI
│   │   ├── index.html        # Main page template
│   │   └── playbook.html     # Playbook display page
│   ├── static/               # Static files (CSS, JS)
│   ├── ai_interaction/       # AI interaction code
│   │   ├── llama_model.py    # Code to connect with LLaMA                                    model
│   │   ├── swarm_model.py    # Code to connect with OpenAI                                   Swarm
│   │   └── duckduckgo_api.py # DuckDuckGo API integration
│   ├── incident_processor/   # Incident request processing                                   code
│   │   └── processor.py      # Validates and processes                                       requests
│   └── feedback/             # Feedback and logging logic
│       └── feedback_handler.py # Handles feedback submissions
└── tests/                    # Test files for each component
    ├── test_routes.py
    ├── test_ai_interaction.py
    └── test_feedback.py

```