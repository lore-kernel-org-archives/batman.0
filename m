Return-Path: <mmitar@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20120416110259.GD24938@ritirata.org>
References: <CAKLmikNxzz_zNwui4xejaAgvXXsHrTUGCPG+UT-cSH5iP3cEJw@mail.gmail.com>
	<20120413055947.GH7664@lunn.ch>
	<CAKLmikPJBmk=Xoom0a1D2OFfx6o8OtSk7D4PdT3TDXDx9iyO1A@mail.gmail.com>
	<201204161237.37008.lindner_marek@yahoo.de>
	<CAKLmikMRRkrvB3Kgga51hJ=GygEto_KqLCp9TwTPseyK4gJsOw@mail.gmail.com>
	<20120416110259.GD24938@ritirata.org>
Date: Mon, 16 Apr 2012 14:37:22 +0200
Message-ID: <CAKLmikOufm+8yugkkmOmdAM7ENi7q6GffT7p0+iADjoCgt2XGw@mail.gmail.com>
From: Mitar <mmitar@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [B.A.T.M.A.N.] Migration to Batman
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

Hi!

On Mon, Apr 16, 2012 at 1:03 PM, Antonio Quartulli <ordex@autistici.org> wrote:
> We are not talking about another "wireless oriented" routing protocol, which
> would need to measure link quality (cost) and announce it. We are talking about
> something like OSPF/BGP/RIP which can be configured to announce routes only
> (actually I think this is the standard way they work and this is also the reason
> why they are not suitable for wireless networks).

I admit I am not familiar how those protocols work, but I imagine they
need to check if node is available/reachable in some regular
intervals? Or it is that node is just announcing its routes in regular
intervals and once it stops, after some timeout other daemons remove
the route?

Yes, I am aware that wireless cost is unneeded. But reachability
checking should still be done?

BTW, if multiple nodes are announcing the same subnet/prefix, how does
the L3 routing protocol daemon knows which one to select? From its
point of view everything is one hope away, but in reality there could
be huge differences?

For DHCP you sniff packets. But could be there some general way?


Mitar
