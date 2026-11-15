# Vercel Deployment Guide

Since your system doesn't have Git or Node.js installed, here are two ways to deploy:

## Option 1: Drag & Drop (Easiest - No CLI needed)

1. Go to **https://vercel.com/new**
2. Sign up / log in with GitHub
3. Click **"Browse"** or drag the `hanan-portfolio.zip` file onto the page
4. Vercel will detect it's a static site
5. Click **Deploy**
6. Done! You'll get a `*.vercel.app` URL

## Option 2: GitHub + Vercel (Recommended for updates)

### Prerequisites (install once):
- **Git**: https://git-scm.com/download/win
- **Node.js**: https://nodejs.org/ (includes npm/npx)

### Steps:
```bash
# 1. Create GitHub repo at https://github.com/new
#    Name: hanan-portfolio (or your choice)

# 2. In your project folder:
cd D:\Bullshit\hanan-portfolio
git init
git add .
git commit -m "Initial commit"

# 3. Connect to GitHub (replace YOUR_USERNAME):
git remote add origin https://github.com/YOUR_USERNAME/hanan-portfolio.git
git branch -M main
git push -u origin main

# 4. Deploy to Vercel:
#    Go to https://vercel.com/new
#    Import your GitHub repo
#    Click Deploy
```

### Future updates:
```bash
cd D:\Bullshit\hanan-portfolio
# Make changes...
git add .
git commit -m "Update: description"
git push
# Vercel auto-deploys on push
```

## Custom Domain (Optional)
In Vercel dashboard → Settings → Domains → Add your domain

## Project Structure
```
hanan-portfolio/
├── index.html      # Main page
├── styles.css      # Styling
├── script.js       # GitHub stars fetch
├── vercel.json     # Vercel config
└── DEPLOY.md       # This file
```

## Features Included
- ✅ Contact section with `hananalihaider78@gmail.com`
- ✅ "Made by Hanan Ali Haider" in footer
- ✅ GitHub Star button → `https://github.com/Hanan-Ali-Haider/Peak-Cut`
- ✅ Instagram Follow button → `https://www.instagram.com/toothlessborgir`
- ✅ Live star count from GitHub API
- ✅ Responsive, dark theme, modern design
- ✅ Security headers via vercel.json