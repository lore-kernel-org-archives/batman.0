Return-Path: <andrew@lunn.ch>
Date: Thu, 3 Dec 2009 06:53:27 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20091203055327.GA29768@lunn.ch>
References: <20091203002407.GA10048@Linus-Debian> <4B172691.8010707@gmail.com>
	<200912031048.17909.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200912031048.17909.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] Updating orig_str for debug
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

> you are probably right but I know that Andrew has a patch in his
> pipeline which will remove these addr_to_string() calls entirely
> (printk can handle mac addresses for us). Until then we can live
> with this workaround. :)

I've been holding off on this patch because of Simon's big lock
removal patch. The two will probably clash.

However the deadlocks Linus just posted suggests Simon's patch is
still in the experimental stage. My patch should be low risk, so maybe
it can go in first. I will submit a patch ASAP.

   Andrew

