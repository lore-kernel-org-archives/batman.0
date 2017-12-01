Return-Path: <keescook@google.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20171201104756.4476-2-sven@narfation.org>
References: <20171201104756.4476-1-sven@narfation.org>
 <20171201104756.4476-2-sven@narfation.org>
From: Kees Cook <keescook@chromium.org>
Date: Fri, 1 Dec 2017 08:40:29 -0800
Message-ID: <CAGXu5jKVo_8s+eBGMqBJ7Z-UpaU5aqpXFiP62ebhyV6EaoN5QA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Fix kernel-doc for timer
 functions
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Thomas Gleixner <tglx@linutronix.de>, Julia Lawall <julia.lawall@lip6.fr>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>

On Fri, Dec 1, 2017 at 2:47 AM, Sven Eckelmann <sven@narfation.org> wrote:
> The commit e99e88a9d2b0 ("treewide: setup_timer() -> timer_setup()")
> changed the argument name and type of the timer function but didn't adjust
> the kernel-doc of these functions.
>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> Cc: Kees Cook <keescook@chromium.org>

Acked-by: Kees Cook <keescook@chromium.org>

I wonder if there is a way for Coccinelle to change kernel-doc?

-Kees

> ---
>  net/batman-adv/tp_meter.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
> index 15cd213..ebc4e22 100644
> --- a/net/batman-adv/tp_meter.c
> +++ b/net/batman-adv/tp_meter.c
> @@ -482,7 +482,7 @@ static void batadv_tp_reset_sender_timer(struct batadv_tp_vars *tp_vars)
>
>  /**
>   * batadv_tp_sender_timeout - timer that fires in case of packet loss
> - * @arg: address of the related tp_vars
> + * @t: address to timer_list inside tp_vars
>   *
>   * If fired it means that there was packet loss.
>   * Switch to Slow Start, set the ss_threshold to half of the current cwnd and
> @@ -1106,7 +1106,7 @@ static void batadv_tp_reset_receiver_timer(struct batadv_tp_vars *tp_vars)
>  /**
>   * batadv_tp_receiver_shutdown - stop a tp meter receiver when timeout is
>   *  reached without received ack
> - * @arg: address of the related tp_vars
> + * @t: address to timer_list inside tp_vars
>   */
>  static void batadv_tp_receiver_shutdown(struct timer_list *t)
>  {
> --
> 2.11.0
>



-- 
Kees Cook
Pixel Security
