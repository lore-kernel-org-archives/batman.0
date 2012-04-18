Return-Path: <davem@davemloft.net>
Date: Tue, 17 Apr 2012 22:45:27 -0400 (EDT)
Message-Id: <20120417.224527.288514574622832184.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1334663907-22725-4-git-send-email-ordex@autistici.org>
References: <1334663907-22725-1-git-send-email-ordex@autistici.org>
	<1334663907-22725-4-git-send-email-ordex@autistici.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH 03/11] batman-adv: randomize initial
 seqno to avoid collision
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
To: ordex@autistici.org
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, lindner_marek@yahoo.de

From: Antonio Quartulli <ordex@autistici.org>
Date: Tue, 17 Apr 2012 13:58:19 +0200

> @@ -33,6 +33,11 @@
>  static void bat_iv_ogm_iface_enable(struct hard_iface *hard_iface)
>  {
>  	struct batman_ogm_packet *batman_ogm_packet;
> +	unsigned long random_seqno;
> +
> +	/* randomize initial seqno to avoid collision */
> +	get_random_bytes(&random_seqno, sizeof(unsigned long));
> +	atomic_set(&hard_iface->seqno, (uint32_t)random_seqno);

This is silly.

Just use "uint32_t" for the type of random_seqno and the sizeof passed
to get_random_bytes.

And here comes the magic part.

Amazing, no ugly and pointless casts needed!
