```C
arachnophobia/
├── main.py              # Main entry point (executing the crawler logic)
├── config.py            # Configurations (API keys, settings for crawlers)
├── cli.py               # Command line interface (for interacting with the crawler)
├── webcrawler/
│   ├── __init__.py      # Initialize webcrawler package
│   ├── duckduckgo_api.py # DuckDuckGo search API logic
│   ├── google_api.py    # Google search API (New file for Google)
│   ├── bing_api.py      # Bing search API (New file for Bing)
│   ├── website_scraper.py # Scrapes website content, using Selenium
│   └── data_processor.py # Processes and formats scraped data
├── database/
│   ├── __init__.py
│   └── db_manager.py    # Manages database operations (storing URLs, search results)
├── utils/
│   ├── __init__.py
│   └── helpers.py       # Helper functions for parsing, saving, etc.
└── README.md

```

[[File structure]]  


Tech stack

- watchtower 
- Kubernetes 
	- minikube
- Docker 
- postgreSQL
- prometheus 
- grafana
- Python 
- Next.js 

[[notes_arach]]

[[doc_arach]]
