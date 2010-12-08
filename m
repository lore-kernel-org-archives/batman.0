Return-Path: <andrew@lunn.ch>
Date: Wed, 8 Dec 2010 09:18:59 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20101208081859.GB11450@lunn.ch>
References: <20101207221351.GA19474@Sellars>
	<1291761150-29818-1-git-send-email-linus.luessing@saxnet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1291761150-29818-1-git-send-email-linus.luessing@saxnet.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 01/20] batman-adv: Add packet structures
 for multicast optimizations
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
Cc: Linus L??ssing <linus.luessing@saxnet.de>

> +struct mcast_packet {
> +	uint8_t  packet_type;    /* BAT_MCAST */
> +	uint8_t  version;        /* batman version field */
> +	uint8_t  orig[6];
> +	uint8_t  ttl;
> +	uint32_t seqno;
> +} __attribute__((packed));

It would be better to put seqno before ttl, so that it is 32bit aligned. 

   Andrew
