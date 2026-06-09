# Complaint Management and Smart City Portal

A production-ready MERN stack portal for civic complaint submission, officer resolution workflows, admin management, analytics, Cloudinary proof images, timeline tracking, and citizen feedback.

## Features

- JWT authentication with `user`, `admin`, and `officer` roles
- Citizen complaint submission with optional Cloudinary image proof
- Tracking IDs like `CMP-2026-100001`
- Public complaint tracking
- Admin dashboard with complaint/user management
- Officer dashboard scoped only to assigned complaints
- Complaint timeline for every status update
- Resolved complaint feedback with one-time rating and comment
- Admin analytics charts for category, status, and monthly complaints
- Responsive Bootstrap 5 frontend with professional public pages

## Tech Stack

- Frontend: React, Vite, Bootstrap 5, Recharts, Lucide React
- Backend: Node.js, Express.js, Mongoose
- Database: MongoDB Atlas or local MongoDB
- Auth: JWT
- Uploads: Cloudinary, Multer
- Deployment: Render Web Service and Render Static Site

## Folder Structure

```text
smart-city-complaint-portal/
  backend/
    config/
    controllers/
    middleware/
    models/
    routes/
    utils/
    uploads/
    server.js
    package.json
    .env.example
  frontend/
    public/
    src/
      api/
      components/
      context/
      pages/
      routes/
      utils/
    index.html
    package.json
    .env.example
```

## Environment Variables

Backend `backend/.env`:

```env
PORT=5000
MONGO_URI=mongodb://127.0.0.1:27017/smart_city_complaints
JWT_SECRET=replace_with_a_long_random_secret
JWT_EXPIRE=7d
CLOUDINARY_CLOUD_NAME=your_cloud_name
CLOUDINARY_API_KEY=your_api_key
CLOUDINARY_API_SECRET=your_api_secret
FRONTEND_URL=http://localhost:5173
ADMIN_NAME=Smart City Admin
ADMIN_EMAIL=admin@example.com
ADMIN_MOBILE=9876543210
ADMIN_PASSWORD=Admin@12345
```

Frontend `frontend/.env`:

```env
VITE_API_URL=http://localhost:5000/api
```

## Local Setup

Create backend environment file:

```bash
cd backend
copy .env.example .env
```

Update `backend/.env` with your MongoDB URI, JWT secret, Cloudinary keys, and `FRONTEND_URL=http://localhost:5173`.

Install backend dependencies:

```bash
cd backend
npm install
```

Create frontend environment file:

```bash
cd frontend
copy .env.example .env
```

Install frontend dependencies:

```bash
cd frontend
npm install
```

Run backend:

```bash
cd backend
npm run dev
```

Run frontend:

```bash
cd frontend
npm run dev
```

Open the frontend at `http://localhost:5173`.

Backend health check:

```http
GET http://localhost:5000/api/health
```

Create or update the first admin:

```bash
cd backend
npm run seed:admin
```

## Render Deployment Guide

Deploy backend first, then frontend. The frontend needs the live backend API URL, and the backend needs the live frontend URL for CORS.

### 1. Backend Render Web Service

- Create a new Render **Web Service** from this repository.
- Root directory: `backend`
- Runtime: Node
- Build command: `npm install`
- Start command: `npm start`
- Add these environment variables:
  - `MONGO_URI`
  - `JWT_SECRET`
  - `JWT_EXPIRE=7d`
  - `CLOUDINARY_CLOUD_NAME`
  - `CLOUDINARY_API_KEY`
  - `CLOUDINARY_API_SECRET`
  - `ADMIN_NAME`
  - `ADMIN_EMAIL`
  - `ADMIN_MOBILE`
  - `ADMIN_PASSWORD`
  - `FRONTEND_URL=https://your-frontend-service.onrender.com`

After deployment, your backend API will look like:

```text
https://your-backend-service.onrender.com/api
```

### 2. Frontend Render Static Site

- Create a new Render **Static Site** from the same repository.
- Root directory: `frontend`
- Build command: `npm install && npm run build`
- Publish directory: `dist`
- Add `VITE_API_URL=https://your-backend-service.onrender.com/api`

### 3. Update Backend CORS

After the frontend URL is generated, update backend `FRONTEND_URL` to the exact frontend URL:

```env
FRONTEND_URL=https://your-frontend-service.onrender.com
```

Redeploy the backend after changing this variable.

If registration or login fails after deployment, check these two values first:

```env
# Backend service environment
FRONTEND_URL=https://your-frontend-service.onrender.com

# Frontend static site environment
VITE_API_URL=https://your-backend-service.onrender.com/api
```

Common mistakes:

- Do not put `/api` at the end of `FRONTEND_URL`.
- Do put `/api` at the end of `VITE_API_URL`.
- After changing frontend environment variables, redeploy the frontend.
- After changing backend environment variables, redeploy the backend.
- Backend health should open at `https://your-backend-service.onrender.com/api/health`.

### 4. Create Admin Account

Open the backend service shell on Render and run:

```bash
npm run seed:admin
```

Then login with `ADMIN_EMAIL` and `ADMIN_PASSWORD`.

### 5. Photo Uploads on Render

Uploaded complaint photos are stored in Cloudinary. To show photos in the admin panel on Render, all three Cloudinary variables must be present in the backend service:

```env
CLOUDINARY_CLOUD_NAME=your_cloud_name
CLOUDINARY_API_KEY=your_api_key
CLOUDINARY_API_SECRET=your_api_secret
```

If these are missing, complaints without photos can still be created locally, but uploaded proof images cannot be stored or shown in production.

## Admin Login Creation Guide

Public registration always creates a citizen `user` account. This prevents users from creating their own admin or officer access.

Set `ADMIN_EMAIL`, `ADMIN_PASSWORD`, `ADMIN_NAME`, and `ADMIN_MOBILE` in `backend/.env`, then run `npm run seed:admin` inside `backend`. After login, create officers from `Admin > Manage Users`.

## Cloudinary Notes

Complaint proof images are optional. Supported formats are `jpg`, `jpeg`, `png`, and `webp`, with a maximum size of 5MB. If Cloudinary variables are missing, complaint creation without images still works.
