const functions = require("firebase-functions");
const { GoogleGenerativeAI } = require("@google/generative-ai");
const genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY);

exports.askGemini = functions.https.onCall(async (data, context) => {
  const model = genAI.getGenerativeModel({ model: "gemini-1.5-flash" });
  const prompt = `You are AfyaFeed AI. General health info only. Add disclaimer. 
  Question: ${data.question}`;
  const result = await model.generateContent(prompt);
  return { answer: result.response.text() };
});
