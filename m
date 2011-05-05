Return-Path: <andrew@lunn.ch>
Date: Thu, 5 May 2011 15:46:49 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20110505134649.GD1528@lunn.ch>
References: <1304579589-5222-1-git-send-email-ordex@autistici.org>
	<1304579589-5222-4-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1304579589-5222-4-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH 3/3] batman-adv: improved gateway
 tq-based selection
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

On Thu, May 05, 2011 at 09:13:09AM +0200, Antonio Quartulli wrote:
> +	/* If old_gw != NULL then this packet is unicast.
> +	 * So, at this point it can only be a renewal packet (because it is the
> +	 * only dhcp client message sent as unicast) and we have to decide
> +	 * whether to drop it or not */

What about the release message? Is that not also unicast? 

> +	if (old_gw && curr_gw->orig_node != old_gw) {
> +		/* If the dhcp packet has been sent to a different gw, we have
> +		 * to evaluate whether the old gw is still enough reliable */

still reliable enough.

      Andrew
