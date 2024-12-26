<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Telegram\Bot\Api;

class TelegramBotController extends Controller
{
    protected $telegram;

    public function __construct()
    {
        $this->telegram = new Api(config('telegram.bot_token'));
    }

    public function webhook(Request $request)
    {
        $update = $this->telegram->getWebhookUpdate();

        // Get incoming message
        $message = $update->getMessage();
        $chatId = $message->getChat()->getId();
        $text = $message->getText();

        // Respond to the message
        if ($text == '/start') {
            $this->telegram->sendMessage([
                'chat_id' => $chatId,
                'text' => 'Welcome to the bot!'
            ]);
        }

        return response()->json(['status' => 'ok']);
    }


    public function setWebhook()
    {
        $this->telegram->setWebhook(['url' => 'https://yourdomain.com/webhook']);
    }

}

