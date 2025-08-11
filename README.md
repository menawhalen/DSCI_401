# DSCI_401

This is the class repository for Dr. Whalen's DSCI 401 class in fall of 2025.

# Python Setup for DSCI 401

1. Install JupyterLab Desktop (or via their OS app store if available).

2. Set up the virtual environment for class exactly as before:

```bash
cd path/to/DSCI_401
python -m venv venv
source venv/bin/activate  # Mac/Linux
venv\Scripts\activate     # Windows
pip install -r requirements.txt
python -m ipykernel install --user --name=dsci401 --display-name "Python (DSCI 401)"
```

Open JupyterLab Desktop → it should now list Python (DSCI 401) in the kernel menu.
