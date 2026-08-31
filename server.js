const express = require('express');
const path = require('path');
const app = express();

const PORT = process.env.PORT || 3000;

app.use(express.json());

// public ফোল্ডারের ফাইলসমূহ সার্ভ করা
app.use(express.static(path.join(__dirname, 'public')));

// ব্যাকএন্ড এপিআই রাউট
app.get('/api/check', (req, res) => {
  res.json({
    status: 'success',
    message: 'Backend API response from the same domain!'
  });
});

// মূল URL-এ গেলে index.html ফাইল পাঠানো
app.get('*', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});