import json
import boto3

bedrock = boto3.client("bedrock-runtime")

ALLOWED_MODEL = "us.amazon.nova-lite-v1:0"

def handler(event, context):
    body = json.loads(event.get("body") or "{}")
    prompt = body.get("prompt", "Say hello in five words.")
    model = body.get("model", ALLOWED_MODEL)

    try:
        resp = bedrock.converse(
            modelId=model,
            messages=[{"role": "user", "content": [{"text": prompt}]}],
        )
        text = resp["output"]["message"]["content"][0]["text"]
        return {"statusCode": 200, "body": json.dumps({"model": model, "response": text})}
    except Exception as e:
        return {"statusCode": 500, "body": json.dumps({"error": type(e).__name__, "detail": str(e)})}
