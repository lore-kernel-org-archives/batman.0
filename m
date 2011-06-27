Return-Path: <andrew@lunn.ch>
Date: Mon, 27 Jun 2011 07:33:19 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20110627053319.GH12315@lunn.ch>
References: <1309091169-27226-1-git-send-email-ordex@autistici.org>
	<1309127157-32507-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1309127157-32507-1-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: pass a unique flag arg
 instead of a sequence of bool ones
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

Hi Antonio

> +	/* NOPURGE flag has not to go on the wire */
> +	flags &= ~TT_CLIENT_NOPURGE;
>  
> +	tt_change_node->change.flags = flags;

I don't remember the packet format. But i assume flags on the wire is
a u8? How about making TT_CLIENT_NOPURGE 1<<8 or bigger, so it is
automatically not sent on the wire? It will also make it easier
sometime in the future when you want to use the bit on the wire that
TT_CLIENT_NOPURGE is currently taking.

You might also want to change the function parameters flags from int
to uint, so avoiding sign extension problems.

   Andrew
