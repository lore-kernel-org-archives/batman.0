Return-Path: <andrew@lunn.ch>
Date: Thu, 31 Dec 2009 12:17:55 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20091231111755.GA1884@lunn.ch>
References: <20091227172356.GA11615@pandem0nium>
	<20091228151008.GA15872@pandem0nium>
	<20091229154328.GA17851@WGT634U>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091229154328.GA17851@WGT634U>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 no pgp] batman-adv: receive
	packets	directly using skbs
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

> I try to summarize where each lock is used so we can decide if it is ok to
> revert some of them to spin_lock again. This should also resolve a request I
> got from Andrew some time ago.

Hi Sven

Thanks for this.

[...]

> So it is complete correct to use irqsave everywhere (as you have commited it
> now).

This also means we don't need to worry about the order we take
spinlocks in resulting in deadlocks. Since we disable interrupts, it
is not possible for some other thread to be holding a lock we need.

   Andrew
