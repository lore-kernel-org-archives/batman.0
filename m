Return-Path: <gregkh@linuxfoundation.org>
Date: Sat, 23 Jul 2022 17:19:47 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 5.15] batman-adv: Use netif_rx_any_context() any.
Message-ID: <YtwRk2OVuALT3khr@kroah.com>
References: <YtbW7Ca3t4/3qB7k@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtbW7Ca3t4/3qB7k@linutronix.de>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Antonio Quartulli <a@unstable.cc>, Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org, "David S. Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>

On Tue, Jul 19, 2022 at 06:08:12PM +0200, Sebastian Andrzej Siewior wrote:
> This reverts the stable commit
>    e65d78b12fbc0 ("batman-adv: Use netif_rx().")
> 
> The commit message says:
> 
> | Since commit
> |    baebdf48c3600 ("net: dev: Makes sure netif_rx() can be invoked in any context.")
> |
> | the function netif_rx() can be used in preemptible/thread context as
> | well as in interrupt context.
> 
> This commit (baebdf48c3600) has not been backported to the 5.15 stable
> series and therefore, the commit which builds upon it, must not be
> backported either.
> 
> Revert the backport and use netif_rx_any_context() again.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  net/batman-adv/bridge_loop_avoidance.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Now queued up, thanks.

greg k-h
