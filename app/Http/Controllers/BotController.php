<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Telegram\Bot\Api;

class BotController extends Controller
{
    protected $telegram;

    public function __construct()
    {
        $this->telegram = new Api(env('TELEGRAM_BOT_TOKEN'));
    }

    // Handle incoming updates
    public function handle(Request $request)
    {
        $update = $this->telegram->getWebhookUpdates();

        $chatId = $update['message']['chat']['id'] ?? null;
        $text = $update['message']['text'] ?? '';

        if ($chatId && $text) {
            $responseText = $this->processMessage($text);
            $this->telegram->sendMessage([
                'chat_id' => $chatId,
                'text' => $responseText,
            ]);
        }

        return response()->json(['status' => 'success']);
    }

    // Process user messages
    protected function processMessage($message)
    {
        switch (strtolower($message)) {
            case '/start':
                return 'Welcome to the bot! How can I assist you today?';
            case 'hello':
                return 'Hi there!';
            default:
                return 'Sorry, I didn’t understand that.';
        }
    }
}
