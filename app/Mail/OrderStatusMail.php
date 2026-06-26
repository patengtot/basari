<?php

namespace App\Mail;

use App\Models\Order;
use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Mail\Mailables\Content;
use Illuminate\Mail\Mailables\Envelope;
use Illuminate\Queue\SerializesModels;

class OrderStatusMail extends Mailable
{
    use Queueable, SerializesModels;

    public function __construct(public Order $order, public string $statusLabel)
    {
        // Set locale sesuai preferensi user
        if ($order->user && $order->user->locale) {
            app()->setLocale($order->user->locale);
        }
    }

    public function envelope(): Envelope
    {
        $subject = app()->getLocale() === 'en'
            ? 'Order Update ' . $this->order->invoice_number . ' — Basari.id'
            : 'Update Pesanan ' . $this->order->invoice_number . ' — Basari.id';

        return new Envelope(subject: $subject);
    }

    public function content(): Content
    {
        return new Content(
            view: 'emails.order-status',
        );
    }
}