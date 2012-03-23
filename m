Return-Path: <andrew@lunn.ch>
Date: Fri, 23 Mar 2012 07:41:28 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20120323064128.GC5662@lunn.ch>
References: <201203222250.31309.lindner_marek@yahoo.de>
	<1332453075-27999-1-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1332453075-27999-1-git-send-email-lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [RFC 1/5] batman-adv: ELP - adding basic
 infrastructure
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

> +static int bat_v_elp_iface_enable(struct hard_iface *hard_iface)
> +{
> +	struct batman_elp_packet *elp_packet;
> +	unsigned long random_seqno;

...

> +	/* randomize initial seqno to avoid collision */
> +	get_random_bytes(&random_seqno, sizeof(unsigned long));
> +	atomic_set(&hard_iface->elp_seqno, (uint32_t)random_seqno);

Hi Marek

Why not just make random_seqno a uint32_t and avoid the cast?

    Andrew
