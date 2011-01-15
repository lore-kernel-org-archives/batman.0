Return-Path: <andrew@lunn.ch>
Date: Sat, 15 Jan 2011 14:53:13 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20110115135313.GQ23716@lunn.ch>
References: <1294966794-17780-1-git-send-email-linus.luessing@ascom.ch>
	<1294966794-17780-4-git-send-email-linus.luessing@ascom.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1294966794-17780-4-git-send-email-linus.luessing@ascom.ch>
Subject: Re: [B.A.T.M.A.N.] [PATCH 03/11] batman-adv: Send neighbor
 discovery packets
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: Linus L??ssing <linus.luessing@ascom.ch>

> diff --git a/batman-adv/ndp.c b/batman-adv/ndp.c
> index 60631b0..3269d67 100644
> --- a/batman-adv/ndp.c
> +++ b/batman-adv/ndp.c
> @@ -49,10 +49,21 @@ static void ndp_send(struct work_struct *work)
>  	struct batman_if *batman_if = container_of(work, struct batman_if,
>  							ndp_wq.work);
>  	struct bat_priv *bat_priv = netdev_priv(batman_if->soft_iface);
> +	struct batman_packet_ndp *ndp_packet;
> +	struct sk_buff *skb;
> +
> +	skb = skb_copy(batman_if->ndp_skb, GFP_ATOMIC);
> +	ndp_packet = (struct batman_packet_ndp *)skb->data;

Hi Linus

You should check the returned skb. It could be NULL if the system is
out of memory.

    Andrew
