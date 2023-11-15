---
title: chatbot
app_file: chatadmin.py
sdk: gradio
sdk_version: 3.50.2
---
# Chatbot with DynamoDB 

This project is a chatbot implemented in Python using the OpenAI API and Gradio for the user interface. 
The chatbot is designed to answer questions and provide information about cloud engineering and training program of  "Azubi Africa."

## Features

- Interactive chat interface for users.
- Predefined responses for common questions.
- Admin functionality to update predefined responses.
- Storage of user interactions and responses in an AWS DynamoDB table.

## Technologies Used

- [OpenAI GPT-3.5 Turbo](https://beta.openai.com/signup/): A powerful language model for generating human-like text responses.
- [Gradio](https://gradio.app/): A simple library for creating interactive interfaces for machine learning models.
- [Boto3](https://aws.amazon.com/sdk-for-python/): The AWS SDK for Python to interact with DynamoDB.
- [Terraform](https://www.terraform.io/): Infrastructure as Code (IaC) tool used to create and manage AWS resources.
- [AWS DynamoDB](https://aws.amazon.com/dynamodb/): A NoSQL database service used to store chatbot interactions.
