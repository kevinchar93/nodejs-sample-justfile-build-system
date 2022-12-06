# Dependencies
FROM node:16.8-alpine as deps
ENV NODE_ENV=development
ENV PATH $PATH:/app/node_modules/.bin

WORKDIR /app

COPY package*.json ./

# CI and release builds should use npm ci to fully respect the lockfile.
# Local development may use npm install for opportunistic package updates.
RUN npm ci

COPY . .

# Build
FROM deps as build
ENV NODE_ENV=production

# Use build tools, installed as development packages, to produce a release build.
RUN npm run build

# Reduce installed packages to production-only.
RUN npm prune --production

# Executable
FROM node:16.8-alpine as exec
ENV NODE_ENV=production
ENV PATH $PATH:/app/node_modules/.bin

WORKDIR /app

# Include only the release build and production packages.
COPY --from=build /app/node_modules node_modules
COPY --from=build /app/.next .next

CMD ["next", "start"]