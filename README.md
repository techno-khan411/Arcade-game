# Catch the Stars — Cloud Run Demo

A small browser game built with HTML, CSS, and JavaScript. It runs in a lightweight Node.js HTTP server and is containerized with Docker, so it can be deployed to Google Cloud Run.

## Run locally

Requirements: Node.js 20+.

```bash
npm start
```

Open http://localhost:8080.

You can also build and run the container locally:

```bash
docker build -t catch-the-stars .
docker run --rm -p 8080:8080 catch-the-stars
```

Then open http://localhost:8080.

## Upload to GitHub

1. Create a new empty repository on GitHub, for example `cloud-run-catch-the-stars`.
2. Extract this project folder.
3. From a terminal opened in the project folder, run:

```bash
git init
git add .
git commit -m "Add Catch the Stars game"
git branch -M main
git remote add origin https://github.com/YOUR-USERNAME/cloud-run-catch-the-stars.git
git push -u origin main
```

Replace `YOUR-USERNAME` with your GitHub username. If Git asks you to authenticate, follow GitHub's sign-in/token instructions.

## Deploy to Google Cloud Run

### Option A — Deploy from source (quickest)

1. In Google Cloud Console, create or select a project and make sure billing is enabled.
2. Enable the **Cloud Run Admin** and **Cloud Build** APIs if prompted.
3. Open **Cloud Shell** and clone your GitHub repository:

```bash
git clone https://github.com/YOUR-USERNAME/cloud-run-catch-the-stars.git
cd cloud-run-catch-the-stars
```

4. Deploy:

```bash
gcloud run deploy catch-the-stars --source . --region asia-south1 --allow-unauthenticated
```

5. If prompted, select the Google Cloud project and allow required API enablement. When deployment finishes, Cloud Run prints a service URL. Open that URL to play the game.

`asia-south1` is the Mumbai region. You can change it to another supported region closer to your users.

### Option B — Build the Docker image yourself

From the project folder, with Docker and `gcloud` configured:

```bash
gcloud builds submit --tag gcr.io/PROJECT_ID/catch-the-stars
gcloud run deploy catch-the-stars --image gcr.io/PROJECT_ID/catch-the-stars --region asia-south1 --allow-unauthenticated
```

Replace `PROJECT_ID` with your Google Cloud project ID. If using Artifact Registry, use an Artifact Registry image path instead.

## Notes

- The app listens on `process.env.PORT` and binds to `0.0.0.0`, as Cloud Run expects.
- `/healthz` returns `ok` for a simple health check.
- `--allow-unauthenticated` makes the game publicly accessible. Omit it if you want to restrict access and configure authentication instead.
- Cloud Run may incur charges depending on usage and your Google Cloud configuration. Review pricing and budgets before deploying.
