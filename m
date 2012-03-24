Return-Path: <andrew@lunn.ch>
Date: Sat, 24 Mar 2012 21:39:45 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20120324203945.GI5662@lunn.ch>
References: <201203222250.31309.lindner_marek@yahoo.de>
	<1332453075-27999-1-git-send-email-lindner_marek@yahoo.de>
	<1332453075-27999-5-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1332453075-27999-5-git-send-email-lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [RFC 5/5] batman-adv: ELP - add configurable
 minimum ELP packet length (def: 300B)
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

> +	if (skb->len < min_len) {
> +		memset(elp_neigh_entry, 0, min_len - skb->len);
> +		skb_put(skb, min_len - skb->len);
> +	}
> +

Hi Marek

I don't know the skbuf code too well, maybe you know it better than
me.

Is this memset needed? The skb is a copy of the template ELP packet
created then the soft interface is created. So if the contents of the
template is set to 0, should we be able to skip this zeroing here?

	 Thanks
		Andrew

