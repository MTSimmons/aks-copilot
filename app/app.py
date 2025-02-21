from flask import Flask, request, jsonify, render_template_string
from dotenv import load_dotenv
import os
import logging
from azure.ai.inference import ChatCompletionsClient
from azure.core.credentials import AzureKeyCredential

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

load_dotenv()

app = Flask(__name__)

# Load Azure OpenAI settings from environment variables
try:
    endpoint = os.getenv("AZURE_OPENAI_ENDPOINT", "").rstrip('/')
    deployment = os.getenv("AZURE_OPENAI_DEPLOYMENT")
    credential = os.getenv("AZURE_INFERENCE_CREDENTIAL")

    if not all([endpoint, deployment, credential]):
        raise ValueError("Missing required environment variables")

    # Initialize the client with the full deployment URL
    client = ChatCompletionsClient(
        endpoint=f"{endpoint}/openai/deployments/{deployment}",
        credential=AzureKeyCredential(credential)
    )
    logger.info(f"Successfully initialized ChatCompletionsClient with endpoint: {endpoint}")

except Exception as e:
    logger.error(f"Failed to initialize: {str(e)}")
    raise

@app.route("/", methods=["GET"])
def index():
    return """
    <html>
      <body>
        <h2>Azure OpenAI Simple Web App</h2>
        <form action="/generate" method="post">
          <input type="text" name="prompt" placeholder="Enter your prompt" size="50"/>
          <button type="submit">Submit</button>
        </form>
      </body>
    </html>
    """

@app.route("/generate", methods=["POST"])
def generate():
    prompt = request.form.get("prompt")
    if not prompt:
        logger.warning("Empty prompt received")
        return "Please provide a prompt.", 400

    try:
        logger.info(f"Processing prompt: {prompt[:50]}...")
        payload = {
            "messages": [{"role": "user", "content": prompt}],
            "max_tokens": 800,  # Increased token limit
            "temperature": 0.7  # Added temperature for more controlled responses
        }
        response = client.complete(payload)
        text = response.choices[0].message.content.strip()
        logger.info("Successfully generated response")

    except Exception as e:
        logger.error(f"Error generating response: {str(e)}")
        return f"Error processing request: {str(e)}", 500

    return f"""
    <html>
      <body>
        <h3>Response:</h3>
        <p>{text}</p>
        <a href="/">Back</a>
      </body>
    </html>
    """

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)