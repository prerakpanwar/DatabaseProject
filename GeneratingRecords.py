#!/usr/bin/env python
# coding: utf-8

# # Generating records for User and Achievements Table.

# In[9]:


pip install faker


# In[10]:


from faker import Faker
import random
from datetime import datetime, timedelta

fake = Faker()

# Function to generate a random date of birth between 18 and 70 years ago
def generate_date_of_birth():
    end_date = datetime.now() - timedelta(days=365 * 18)
    start_date = end_date - timedelta(days=365 * 70)
    return fake.date_of_birth(minimum_age=18, maximum_age=70)

# Generate 500 records
records = []
for i in range(1, 501):  # Using a counter variable for user ID
    user_id = i
    username = fake.user_name()
    email = fake.email()
    first_name = fake.first_name()
    last_name = fake.last_name()
    date_of_birth = generate_date_of_birth()

    records.append((user_id, username, email, first_name, last_name, date_of_birth))

# Save the records to a CSV file
with open("generated_data2.csv", "w") as file:
    file.write("User_ID,Username,email,First Name,Last Name,Date of Birth\n")
    for record in records:
        file.write(",".join(map(str, record)) + "\n")

print("Generated 500 records. Check 'generated_data2.csv'")


# In[11]:


from faker import Faker
from datetime import datetime, timedelta
import random

fake = Faker()

# Function to generate a random date within a specified year range in 'YYYY-MM-DD' format
def generate_random_date(start_date, end_date):
    return fake.date_between_dates(datetime.strptime(start_date, '%Y-%m-%d'), datetime.strptime(end_date, '%Y-%m-%d')).strftime('%Y-%m-%d')

# Provided achievements and categories
provided_data = [
    (2, 1, 'Novice', '2023-05-16', 40, 'Waste Management Captain'),
    (6, 2, 'Apprentice', '2023-09-10', 100, 'Waste Management Captain'),
    (9, 3, 'Skywalker', '2023-04-30', 340, 'Recycling Manager'),
    (2, 4, 'Explorer', '2023-11-16', 209, 'Community Service Leader'),
    (4, 5, 'Novice', '2023-10-04', 57, 'Waste Management Captain'),
    (7, 6, 'Novice', '2023-01-26', 39, 'Recycling Manager'),
    (1, 7, 'Expert', '2023-09-02', 468, 'Recycling Manager'),
    (3, 8, 'Apprentice', '2023-03-17', 119, 'Community Service Leader'),
    (9, 9, 'Skywalker', '2023-05-17', 376, 'Community Service Leader'),
    (10, 10, 'Explorer', '2023-07-27', 294, 'Waste Management Captain'),
]

# Function to generate 500 rows
def generate_achievement_data(existing_data, num_rows=500):
    generated_data = []
    
    for i in range(1, num_rows + 1):
        user_id = i
        achievement_id, _, achievement_name, achievement_date, points_earned, category = random.choice(provided_data)
        generated_data.append((achievement_id, user_id, achievement_name, generate_random_date('2021-01-01', '2023-12-31'), points_earned, category))
    
    return generated_data

# Generate 500 rows
generated_achievement_data = generate_achievement_data(provided_data, num_rows=500)

# Save the records to a CSV file
with open("generated_achievement_data.csv", "w") as file:
    file.write("Achievement_ID,User_ID,Achievement_Name,Achievement_Date,Points_Earned,Category\n")
    for record in generated_achievement_data:
        file.write(",".join(map(str, record)) + "\n")

print("Generated 500 achievement records. Check 'generated_achievement_data.csv'")


# In[ ]:




