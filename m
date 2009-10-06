Return-Path: <andrew@lunn.ch>
Date: Tue, 6 Oct 2009 12:54:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20091006105436.GB6646@lunn.ch>
References: <d9bba8670910050221m476d31eaodcdb8e9cdfbe8fa3@mail.gmail.com>
	<200910052324.55426.sven.eckelmann@gmx.de>
	<d9bba8670910060226i3068db6awc4f126c9b6c51b1a@mail.gmail.com>
	<200910061143.08021.sven.eckelmann@gmx.de>
	<d9bba8670910060333i45d91b8eyc5fb1f1b05b94194@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9bba8670910060333i45d91b8eyc5fb1f1b05b94194@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] batman-adv and TCP problem
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

On Tue, Oct 06, 2009 at 12:33:55PM +0200, a wrote:
> Dear Sven, Marek
> 
> you can find as attachment the dump on eth2 of GW (tcpdump -ni eth2 -s 0 -w
> gw.cap);
> the output of batctl td -p 4 eth1 is:
> 
> 10:29:15.510000 BAT 52:54:00:00:20:01 > 52:54:00:00:30:01: UCAST, ttl 50, IP
> 192.168.100.2.9001 > 192.168.20.4.45417: TCP, flags [...PA.], length 6

192.168.100.2->192.168.20.4

> 10:29:18.000000 BAT 52:54:00:00:30:01 > 52:54:00:00:20:01: UCAST, ttl 50, IP
> 192.168.20.4.38246 > 192.168.100.2.9002: TCP, flags [.S....], length 12

192.168.20.4->192.168.100.2

> 10:29:18.010000 BAT 52:54:00:00:20:01 > 52:54:00:00:30:01: UCAST, ttl 50, IP
> 192.168.100.2.9002 > 192.168.20.4.38246: TCP, flags [.S..A.], length 12

192.168.100.2-> 192.168.20.4

However you said:

> IP addresses:
> - B1 - bat0: 192.168.10.1/24 - default gateway: 192.168.10.2
> - GW: bat0: 192.168.10.2/24, eth1: 192.168.20.2/24
> - EX: eth0: 192.168.20.3/24 - default gateway: 192.168.20.3

i.e, none of these IP addresses match!

Maybe you should give us all the networking details. 

      Andrew
