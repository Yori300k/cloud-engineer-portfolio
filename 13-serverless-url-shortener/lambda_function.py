import json
import os
import secrets
import boto3

table = boto3.resource("dynamodb").Table(os.environ["TABLE_NAME"])

def handler(event, context):
    method = event["requestContext"]["http"]["method"]

    if method == "POST":
        body = json.loads(event.get("body") or "{}")
        long_url = body.get("url")
        if not long_url:
            return {"statusCode": 400, "body": json.dumps({"error": "url required"})}
        code = secrets.token_urlsafe(4)
        table.put_item(Item={"short_code": code, "long_url": long_url})
        return {"statusCode": 201, "body": json.dumps({"short_code": code})}

    code = event["pathParameters"]["code"]
    item = table.get_item(Key={"short_code": code}).get("Item")
    if not item:
        return {"statusCode": 404, "body": json.dumps({"error": "not found"})}
    return {"statusCode": 302, "headers": {"Location": item["long_url"]}}
