Return-Path: <daniele.furlan@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20110228123720.GG4698@lunn.ch>
References: <AANLkTim+tN9NKUUHJqcaaxS-RpWeLQqrUoB0D+=sA0J7@mail.gmail.com>
	<20110228123720.GG4698@lunn.ch>
Date: Mon, 28 Feb 2011 14:07:36 +0100
Message-ID: <AANLkTikdyLe01RSdet=Y1bZgjnCAUCcbdvJdXyUDSVw=@mail.gmail.com>
From: Daniele Furlan <daniele.furlan@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] OGM overhead and routing metric proposal
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

2011/2/28 Andrew Lunn <andrew@lunn.ch>:
>> In attachment you will also find a draft/proposals of a new routing
>> approach. It is based on the collection of more link parameters (the
>> current TQ, bit-rate and node-load) to write in OGM at each hop. This
>> permit to develop a more thorough metric and can open new room of
>> improvement such multi-path routing.
>
> Hi Daniele
>
> Do you have any suggestions how to collect this bit-rate information?
> Do you suggest measuring it, or asking the wireless LAN driver? =A0Is
> there an API in the kernel to allow access to this information?
>
I'm not a kernel guru but i find out that the new core mac80211 and
cfg80211 (http://linuxwireless.org/) offers the possibility to obtain
a per-station bit-rate information that should be driver independent.
The measurement is an alternative but I think it is more complex to
implement. The load measurement instead is more difficult and at this
moment have not idea of how to do it!!

> Also, how do you see this interacting with the hidden node problem? In
> order to reduce the hidden node problem, you ideally want to use the
> lowest coding rate and transmit power possible to get your packets
> through. Currently this is not being done. Current wireless systems
> optimize for maximum bandwidth between two nodes, which may not be the
> optimum for the complete mesh bandwidth, due to inter node
> interference.
>
I have not mentioned the hidden node problem. But I think this problem
is very difficult to remove, the only best practice to reduce the
problem is to force the RTS/CTS mechanism to be active. Other
phenomena such as capture effect instead are intrinsic in the wireless
networking and are very difficult to eliminate. The optimization of
bandwidth in my opinion does not influence the protocol because if the
link is bad, rate adaption mechanism will reduce the bit-rate and I
can read this information from the driver.

Anyhow collecting more information about link can help much in
evaluating the best route I think, and offer a big opportunity to
experiment new metrics.

> Will you be at the WBMv4 next Month?
>
I'm afraid but I cannot be at WMBv4, I hope I can come to the next
WBM, maybe with a working implementation :)

> =A0 =A0 Andrew
>



--=20
Daniele Furlan
