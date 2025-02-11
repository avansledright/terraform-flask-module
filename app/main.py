import logging
from flask import Flask, request, render_template, jsonify
from datetime import datetime

app = Flask(__name__)

# Establish logging
def setup_logging():
    # Configure logging format
    formatter = logging.Formatter(
        '%(asctime)s - %(name)s - %(levelname)s - %(message)s'
    )

    # Set up console handler
    console_handler = logging.StreamHandler()
    console_handler.setFormatter(formatter)
    console_handler.setLevel(logging.INFO)

    # Configure root logger
    root_logger = logging.getLogger()
    root_logger.setLevel(logging.INFO)
    root_logger.addHandler(console_handler)

    # Configure Flask logger
    app.logger.setLevel(logging.INFO)
    app.logger.addHandler(console_handler)

@app.before_request
def log_request_info():
    app.logger.info(
        f'Request: {request.method} {request.url} - '
        f'IP: {request.remote_addr}'
    )

@app.after_request
def log_response_info(response):
    app.logger.info(
        f'Response: {response.status} - '
        f'Size: {response.content_length}'
    )
    return response

@app.route('/health')
def health_check():
    app.logger.info("Running health check")
    return jsonify({
        'status': 'healthy',
        'service': 'web-app'
    }), 200

@app.route('/')
def index():
    return render_template('index.html')

if __name__ == '__main__':
    setup_logging()
    app.logger.info('Application started')
    app.run(host='0.0.0.0', port=5000)