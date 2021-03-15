# Mobile Flutter App to classify cancer type of skin lesions via ML

This app uses a tensorflow machine learning model (see other github repro) converted to a tf-lite model to
classify skin lesions in 7 different cancer categories. The app allows the user to upload an image 
from gallery or to take a picture with the camera and classify it. The app will display the type and
the confidence as well as info about the diagnoses. 

Currently no images are stored, since it is very sensible data.

### Things to improve:
- crop (e.g. fixed zoom, edge detection, user by crop), and edit (e.g. white balance) incoming images, to extract lesion information only
- give advice on how to take image (e.g. camera mask)
- display pobability distribution for other classes
- tweek tflite model prediction parameters
- close tf model after longer inactivity
- overall design
- more/better info for diagnoses

One could add:
- account and login
- history of uploaded images
- api for health care providers