Return-Path: <andrew@lunn.ch>
Date: Mon, 4 Jan 2010 21:58:27 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20100104205827.GB9585@lunn.ch>
References: <201001042344.02273.lindner_marek@yahoo.de>
	<591bc9931001041223m13d96837o4d4f95afa08e42e2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <591bc9931001041223m13d96837o4d4f95afa08e42e2@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] batman-adv gateway support
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

> Would it be possible to decide via a more general mechanism, maybe via a
> BPF filter, which packets get sent to the gateway?  For instance, it would
> be nice to be able to say that all ARP requests for *.*.*.1 also got sent to
> the gateway direct :-)  This would also make adding IPv6 support trivial,
> it'd just be another (or a more complex) BPF filter.

BPF for outgoing packets? Different. I've only ever seen it used for
filtering incoming packets. ARP requests for *.*.*.1? I don't get
that. There should only be one host in the subnet which matches
*.*.*.1/24, so its going to reply anyway. What are you trying to
achieve here?

Also, how would you handle the gateway sending back an ICMP redirect
because it is the wrong gateway for a given destination, or not a
gateway at all? In the network i use most, *.*.*.5/24 happens to be
the gateway, not *.*.*.1. 

    Andrew
