Return-Path: <hw@haveyouseenthiscat.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 11 Jun 2015 14:43:36 +0200
From: Hans-Werner Hilse <hw@haveyouseenthiscat.de>
In-Reply-To: <1434025163.1056.73.camel@nord-west.org>
References: <1434025163.1056.73.camel@nord-west.org>
Message-ID: <2dca4d7a596a3a7f250b2ef62cf9c3ec@hilses.de>
Subject: Re: [B.A.T.M.A.N.] Mesh hickups with 2014.3
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hi,

Am 2015-06-11 14:19, schrieb Bjoern Franke:

> - gateway gets alfreddata from router

Continuously? So that directions seems fine then.

> - router pingable via batctl
> - ping via linklocal, ULA and public-IPv6 from gateway to router not
> possible

What does "not possible" mean? There's no reply?

> - other routers in the same mesh can ping it via ULA etc (connected via
> the same fastd-VPN)

So it's just the gateway that can't reach the "router"?

> Public-IPv6 is announced from a gateway via radvd into the mesh.

So even in that direction, NDP is fine. Seems only ICMPv6 echo requests 
are somewhat different then?

> Unfortunately we are out of ideas where we can search for the reason.

Look what's actually on the wire on both ends? Tcpdump and batctl 
tcpdump?

-hwh

