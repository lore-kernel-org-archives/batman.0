Return-Path: <andrew@lunn.ch>
Date: Tue, 6 Oct 2009 16:02:18 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20091006140218.GF6646@lunn.ch>
References: <200910061328.04894.holger@layer-acht.org>
	<200910061355.49409.sven.eckelmann@gmx.de>
	<200910062127.42925.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200910062127.42925.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Fwd: Re: Debian extra modules
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

> The postifx setup is quite simple at the moment: It rejects all unknown / 
> unregistered mail. Greylisting is not in place yet. I quickly ran pflogsumm to 
> give you an impression:
> 
> Per-Day Traffic Summary
>     date          received  delivered   deferred    bounced     rejected
>     --------------------------------------------------------------------
>     Sep 27 2009       110        107        153         16       4874
>     Sep 28 2009       170        855        298         56       6894
>     Sep 29 2009       229       1235        379         90       6757
>     Sep 30 2009       176        525        420         38       7477
>     Oct  1 2009       187        222        377         20       7913
>     Oct  2 2009       132        132        414         17       8086
>     Oct  3 2009       112        117        374         18       7790
>     Oct  4 2009       128        658        294         42       6158 
>     Oct  5 2009       243       1634        509         97       7657

I don't understand these figures. Ah, this is for the complete mail
server. That explains why there was say 128 received on Oct 4, yet
only a handful in the list archive.

> But I tend to agree with you: We might have to face the fact that we
> have to improve the SPAM filter on our end and open the list. As a
> first step we could install greylisting and have a bunch of
> moderators to see how that goes.

Do you at least have spamassassin running? It would be interesting to
see how many of the rejected emails spamassassin also decided were
spam. Could you configure postfix to keep a copy of the rejected. I
can then manually perform some tests with spamassassin and see how
good it is.

      Andrew
