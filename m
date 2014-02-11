Return-Path: <andrew@lunn.ch>
Date: Tue, 11 Feb 2014 16:32:24 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20140211153224.GB24633@lunn.ch>
References: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
 <1392122903-805-5-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1392122903-805-5-git-send-email-antonio@meshcoding.com>
Subject: Re: [B.A.T.M.A.N.] [RFC 04/23] batman-adv: ELP - creating neighbor
 structures
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: Marek Lindner <lindner_marek@yahoo.de>, Antonio Quartulli <antonio@open-mesh.com>

On Tue, Feb 11, 2014 at 01:48:04PM +0100, Antonio Quartulli wrote:
> From: Linus Luessing <linus.luessing@web.de>
> 
> Initially developed by Linus during a 6 months trainee study
> period in Ascom (Switzerland) AG.
> 
> Signed-off-by: Linus Luessing <linus.luessing@web.de>
> Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> ---
>  bat_v.c     |  18 +++++-
>  bat_v_elp.c | 204 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  bat_v_elp.h |   6 ++
>  main.h      |   2 +
>  types.h     |  53 ++++++++++++++++
>  5 files changed, 281 insertions(+), 2 deletions(-)
> 
> diff --git a/bat_v.c b/bat_v.c
> index 7247d7f..bed5e00 100644
> --- a/bat_v.c
> +++ b/bat_v.c
> @@ -61,5 +61,21 @@ static struct batadv_algo_ops batadv_batman_v __read_mostly = {
>  
>  int __init batadv_v_init(void)
>  {
> -	return batadv_algo_register(&batadv_batman_v);
> +	int ret;
> +
> +	/* batman v echo location protocol packet  */
> +	ret = batadv_recv_handler_register(BATADV_ELP,
> +					   batadv_v_elp_packet_recv);
> +	if (ret < 0)
> +		goto elp_unregister;
> +
> +	ret = batadv_algo_register(&batadv_batman_v);
> +
> +	return ret;
> +
> +elp_unregister:
> +	if (ret < 0)
> +		batadv_recv_handler_unregister(BATADV_ELP);

No need to check ret here. If we are here, it has to be < 0.

It also seems odd to me you are unregistering the handler when the
registration of the handler fails!

I suspect the first if (ret < 0) should be followed by a plain return
ret; and there should be a second test for the return value of
batadv_algo_register() which should goto the label and unregister the
handler.

	Andrew
