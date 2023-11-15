import openai
import gradio
import boto3

# Configure AWS credentials
aws_access_key_id = # access_key
aws_secret_access_key = # secret_key
aws_region = "us-east-1"

# Create a DynamoDB client
dynamodb = boto3.client('dynamodb', region_name=aws_region, aws_access_key_id=aws_access_key_id, aws_secret_access_key=aws_secret_access_key)

# OpenAI API key
openai.api_key = #open AI API KEY

# Define predefined responses for the chatbot
saved_responses = {
    "What is Azubi Program?": "Azubi Africa is a tech training program with a proven track record across Africa, providing tailored training to make talents ready for a job in tech (education partner of Microsoft & AWS). Over 1,000 trainees certified in Ghana, Kenya & Rwanda in 2021 on Microsoft & Amazon Web Services.",
    "how long till I receive feedback, After my application?": "Ideally 2 weeks. If you do not get a response from us after two weeks, please consider your application unsuccessful.",
    "Are there prerequisites or language requirements?": "English language is fundamental.",
    "Are the opportunities open to only Africans?": "No, we thrive in our diversity.",
    "Do you work with PWDs?": "Yes, we have an entire domain dedicated to ensuring their inclusion.",
    "When should I apply?": "Applications are open. Visit https://www.azubiafrica.org/ and click on Apply Now to begin your Application.",
    "program_duration": "Our program typically lasts for 9 months.",
    "what is an income share agreement": "Learn, earn, and pay later under our ISA model.",
    "collaboration": "We collaborate with industry leaders and organizations to enhance your learning experience.",
    "what is the enrollment fee": "All learners are required to pay a one-time, non-refundable commitment fee of 100 EUR within the 4-week trial period",
    
}
# Initial system message

messages = [{"role": "system", "content": "You are a cloud engineer expert that specializes in AWS infrastructure and Architecture"}]

# Function to save predefined responses to DynamoDB
def save_response(user_input, assistant_reply,max_size=1024):
    if not assistant_reply.strip():  # Check if assistant_reply is empty or contains only whitespace
        return

    # Truncate the response if it exceeds the maximum size
    truncated_reply = assistant_reply[:max_size]
    table_name = "chatbot"  # DynamoDB table name
    # Save the conversation to DynamoDB
    response = dynamodb.put_item(
        TableName=table_name,
        Item={
            'user_input': {'S': user_input},
            'assistant_reply': {'S': truncated_reply}
     
        }
    )

# Save predefined responses to DynamoDB
for user_input, assistant_reply in saved_responses.items():
    save_response(user_input, assistant_reply)

# Function to handle custom responses
def CustomChatGPT(user_input):
    if user_input.lower() == "admin":
        # Admin login
        admin_password = "Admin@123"
        if input("Enter admin password: ") == admin_password:
            admin_response = input("You are logged in as an admin. Enter a new response: ")
            question_area = input("Enter the question (e.g., program_duration): ")
            saved_responses[question_area] = admin_response

            # Save the new question and response to the database
            save_response(question_area, admin_response)

            return f"Response for {question_area} updated."
        else:
            return "Admin login failed. You are not an admin."
    elif user_input in saved_responses:
        return saved_responses[user_input]
    else:
        messages.append({"role": "user", "content": user_input})
        response = openai.ChatCompletion.create(
            model="gpt-3.5-turbo",
            messages=messages
        )
        ChatGPT_reply = response["choices"][0]["message"]["content"]
        messages.append({"role": "assistant", "content": ChatGPT_reply})
        # Save the conversation to DynamoDB
        save_response(user_input, ChatGPT_reply)
        return ChatGPT_reply

# Create a Gradio interface for the chatbot
demo = gradio.Interface(fn=CustomChatGPT, inputs="text", outputs="text", title="Cloud Engineering Chatbot Assistance")

# Launch the Gradio interface and allow sharing
demo.launch(share=True)