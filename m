Return-Path: <andrew@lunn.ch>
Date: Fri, 4 Dec 2009 22:29:25 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20091204212925.GD29768@lunn.ch>
References: <20091204101245.GB32517@lunn.ch>
 <4B194EDE.2070703@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B194EDE.2070703@gmail.com>
Subject: Re: [B.A.T.M.A.N.] [patch] batman-adv: Use printk(%pM) for MAC
 addresses
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

> >-		bat_dbg(DBG_ROUTES, "Deleting route towards: %s\n",
> >-			orig_str);
> >+		bat_dbg(DBG_ROUTES, "Deleting route towards: %pMs\n",
> >+			orig_node->orig);
> 
> There is an extra "s" after the the replacement %pM.

Thanks
	Andrew
