import numpy as np

# define two 3-dimensional vectors
vector1 = np.array([0.39794,0.69897,0.45593])
vector2 = np.array([0,3.49485,0])

# calculate the dot product of the two vectors
dot_product = np.dot(vector1, vector2)

# calculate the magnitude (length) of the two vectors
magnitude_vector1 = np.linalg.norm(vector1)
magnitude_vector2 = np.linalg.norm(vector2)

# calculate the cosine similarity between the two vectors
cosine_similarity = dot_product / (magnitude_vector1 * magnitude_vector2)

print("Cosine similarity between vector1 and vector2:", cosine_similarity)
