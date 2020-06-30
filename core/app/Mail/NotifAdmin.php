<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;

class NotifAdmin extends Mailable
{
    use Queueable, SerializesModels;
    public $sukses;
    /**
     * Create a new message instance.
     *
     * @return void
     */
    public function __construct($sukses)
    {
        $this->sukses = $sukses;
    }

    /**
     * Build the message.
     *
     * @return $this
     */
    public function build()
    {
        return $this->view('email/NotifAdmin');
    }
}
