# Cyber Intelligence and Security Organization (CISO)

[](https://github.com/CSUSB-CISO/ciso-site-v2/tree/testing#cyber-intelligence-and-security-organization-ciso)

## Testing Branch

[](https://github.com/CSUSB-CISO/ciso-site-v2/tree/testing#testing-branch)

## Introduction

[](https://github.com/CSUSB-CISO/ciso-site-v2/tree/testing#introduction)

This testing branch is designed specifically for testing additions made within the development branch with prod Firebase database and storage bucket that are hosted by Google. In general you should only be using this branch once all preliminary testing with dummy data has been conducted. The purpose of this branch is to ensure the prod rebuild on vercel will not encounter some unexpected errors etc.

**Very Important!!! You must check if the emulators are connected within this file src/lib/firebase/config.js**

The following lines should be commented out since we want to connect to the real db

```ts
connectAuthEmulator(auth, "http://127.0.0.1:9099");
connectFirestoreEmulator(db, "127.0.0.1", 8080);
connectStorageEmulator(storage, "127.0.0.1", 9199);
```

## Authentication

[](https://github.com/CSUSB-CISO/ciso-site-v2/tree/testing#authentication)

Our server uses Google's API to authenticate users. For development, a local version is called which has a different appearance compared to what you would see in production. This visual difference serves as a good indicator to determine if you forgot to start the emulators.

More detailed information on specific API calls and implementation will be provided in future updates.

### Auth Context

[](https://github.com/CSUSB-CISO/ciso-site-v2/tree/testing#auth-context)

User object and roles are made super simple because I'm him. I made an auth context provider which wraps both of our route groups (user) and (admin). The wrapper essentially grabs our user object and role from the server and makes it accessible to any child components through the hook _useUserSession_. This is the best practice in react because we have a centralized auth logic that helps to prevent conflicting auth states throughout the app. File is here: src/context/AuthContext.tsx

#### Updates for Auth

[](https://github.com/CSUSB-CISO/ciso-site-v2/tree/testing#updates-for-auth)

- [] Refresh auth token after specified amount of time (currently idt token expires)
- [] Give every user a role upon account creation (user | admin) admin role should be set by current admins in the future

## Starting the Server for Development

[](https://github.com/CSUSB-CISO/ciso-site-v2/tree/testing#starting-the-server-for-development)

### Step 1: Install node modules

[](https://github.com/CSUSB-CISO/ciso-site-v2/tree/testing#step-1-install-node-modules)

```
npm install
```

### Step 2: Start Firebase Emulators

[](https://github.com/CSUSB-CISO/ciso-site-v2/tree/testing#step-2-start-firebase-emulators)

```
firebase emulators:start --import=./emulator_data/
```

### Step 3: Build auth-service-worker.js

[](https://github.com/CSUSB-CISO/ciso-site-v2/tree/testing#step-3-build-auth-service-workerjs)

```
npm run build-service-worker
```

### Step 4: Start Node Server in Development Mode

[](https://github.com/CSUSB-CISO/ciso-site-v2/tree/testing#step-4-start-node-server-in-development-mode)

```
npm run dev
```

### Alternative: Production-like Environment

[](https://github.com/CSUSB-CISO/ciso-site-v2/tree/testing#alternative-production-like-environment)

If you want to test the application in an environment that more closely resembles production:

```
npm run build
npm run start
```

This approach will build the application and run it in a way that more accurately reflects how it will behave in production.

## Additional Resourcesd

[](https://github.com/CSUSB-CISO/ciso-site-v2/tree/testing#additional-resources)

- [Nextjs Docs](https://nextjs.org/docs)
- [Firebase Emulator Docs](https://firebase.google.com/docs/emulator-suite)
- [Material Tailwind](https://www.material-tailwind.com/docs/react/installation)
- [Prod Commit URL](https://github.com/ciso-csusb-CIO/ciso-site-v2)