import base64
import boto3
import json
import os
import random


bedrock_client = boto3.client("bedrock-runtime", region_name="us-east-1")
s3_client = boto3.client("s3")

def lambda_handler(event, context):
    
    try:
        body = json.loads(event['body'])
        prompt = body.get("prompt", "Default prompt text")  
    except (json.JSONDecodeError, KeyError) as e:
        #
        return {
            "statusCode": 400,
            "body": json.dumps({"error": "Invalid request format or missing 'prompt' field."})
        }

    
    seed = random.randint(0, 2147483647)
    candidate_id = "59"  
    s3_image_path = f"{candidate_id}/generated_images/titan_{seed}.png"

   
    model_id = os.environ["MODEL_ID"]
    native_request = {
        "taskType": "TEXT_IMAGE",
        "textToImageParams": {"text": prompt},
        "imageGenerationConfig": {
            "numberOfImages": 1,
            "quality": "standard",
            "cfgScale": 8.0,
            "height": 1024,
            "width": 1024,
            "seed": seed,
        }
    }

   
    response = bedrock_client.invoke_model(modelId=model_id, body=json.dumps(native_request))
    model_response = json.loads(response["body"].read())

   
    base64_image_data = model_response["images"][0]
    image_data = base64.b64decode(base64_image_data)

    
    bucket_name = os.environ["BUCKET_NAME"]
    s3_client.put_object(Bucket=bucket_name, Key=s3_image_path, Body=image_data)

   
    return {
        "statusCode": 200,
        "body": json.dumps({"s3_image_path": f"s3://{bucket_name}/{s3_image_path}"})
    }
