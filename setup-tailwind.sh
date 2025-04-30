#!/bin/bash

echo "Installing Tailwind CSS and CLI..."
npm install -D tailwindcss @tailwindcss/cli

# Create the tailwind.config.js file manually
echo "Creating tailwind.config.js..."
cat <<EOL > tailwind.config.js
module.exports = {
  content: [
    "./index.html",
    "./templates/**/*.html",
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}
EOL

# Create the Tailwind CSS input file using @import
echo "Creating input.css..."
cat <<EOL > ./input.css
@import "tailwindcss";
EOL

# Create a basic index.html with Tailwind classes
echo "Creating index.html with Tailwind examples..."
cat <<EOL > ./index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tailwind CSS Example</title>
    <link href="./output.css" rel="stylesheet">
</head>
<body class="bg-gray-100 min-h-screen">
    <div class="container mx-auto px-4 py-8">
        <header class="bg-white shadow rounded-lg p-6 mb-8">
            <h1 class="text-3xl font-bold text-gray-800">Welcome to Tailwind CSS</h1>
            <p class="text-gray-600 mt-2">A utility-first CSS framework for rapidly building custom designs.</p>
        </header>

        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            <div class="bg-white rounded-lg shadow p-6">
                <h2 class="text-xl font-semibold text-gray-800 mb-2">Responsive Design</h2>
                <p class="text-gray-600">Build responsive designs easily with Tailwind's intuitive class naming.</p>
                <button class="mt-4 bg-blue-500 hover:bg-blue-600 text-white font-medium py-2 px-4 rounded transition-colors">Learn More</button>
            </div>

            <div class="bg-white rounded-lg shadow p-6">
                <h2 class="text-xl font-semibold text-gray-800 mb-2">Customizable</h2>
                <p class="text-gray-600">Tailor Tailwind to your design needs by extending the configuration.</p>
                <button class="mt-4 bg-green-500 hover:bg-green-600 text-white font-medium py-2 px-4 rounded transition-colors">Explore</button>
            </div>

            <div class="bg-white rounded-lg shadow p-6">
                <h2 class="text-xl font-semibold text-gray-800 mb-2">Performance</h2>
                <p class="text-gray-600">Ship only the CSS you use for optimal performance and load times.</p>
                <button class="mt-4 bg-purple-500 hover:bg-purple-600 text-white font-medium py-2 px-4 rounded transition-colors">Get Started</button>
            </div>
        </div>
    </div>
</body>
</html>
EOL

# Set up the build script in package.json
echo "Setting up the build and dev scripts in package.json..."

if grep -q '"scripts"' package.json; then
  sed -i 's/"scripts": {/"scripts": {\n    "dev": "npx tailwindcss -i .\/input.css -o .\/output.css --watch",\n    "build": "npx tailwindcss -i .\/input.css -o .\/output.css --minify",/' package.json
else
  sed -i '/"name"/ a\  "scripts": {\n    "dev": "npx tailwindcss -i ./input.css -o ./output.css --watch",\n    "build": "npx tailwindcss -i ./input.css -o ./output.css --minify"\n  },' package.json
fi

echo "Tailwind setup complete!"
echo "Run 'npm run dev' to start development mode (with live reloading)."
echo "Run 'npm run build' to generate the production-ready minified CSS."
