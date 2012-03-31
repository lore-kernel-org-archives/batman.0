Return-Path: <dandenson@gmail.com>
References: <CAA_JP8X+vPn39-QK-zPjdd1Mtn4PCTjigpV4fFM6sTVUmBiLTg@mail.gmail.com>
	<CAHD-aqKN_+5fwg65Udpr6jxt5tFsu5XXsMWkk75ujPK3bJcqJw@mail.gmail.com>
	<CAA_JP8UxNW18xWZe62ySY=H27HDnZY1YBQV-7ZGUHYnSS-ZSHw@mail.gmail.com>
	<CAHD-aqK_CGbc8u5GuEBJyFzrk2rTHHTw=bAiWjFafAW9xOqWiw@mail.gmail.com>
From: Dan Denson <dandenson@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
In-Reply-To: <CAHD-aqK_CGbc8u5GuEBJyFzrk2rTHHTw=bAiWjFafAW9xOqWiw@mail.gmail.com>
Message-Id: <BBFA727B-FECF-4C04-BCD1-3C76CBD010DE@gmail.com>
Date: Sat, 31 Mar 2012 09:45:21 -0600
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (1.0)
Subject: Re: [B.A.T.M.A.N.] link alternation when radios are not on
	batman-adv router?
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


=20
> batman-adv makes no difference between ethernet or radio interfaces,
> they are all simply just interfaces that somehow link to other
> batman-adv nodes (with some -or zero- packet loss)
> so link alternation would work the same: if packet comes in through
> radio, and batman-adv can reach the destination through the ethernet
> port (it doesn't matter if that implies hopping through more
> batman-adv nodes) it will prefer sending it through this "alternate"
> path (alternate in the sense it doesn't use the same interface the
> packet came in)

So how does hop count come into play or does it? Is it just the connection q=
uality that is considered?

> A long thread earlier this month was particularly clarifying on the subjec=
t.
> https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2012-March/006351.html
>=20
Thanks, I'll check that out

> Yes. in addition you might also be interested in interface bonding,
> which is not enabled by default but can be activated after
> understanding a few caveats. it's documented on batctl manpage online.

I read up on bonding, I think that leaving the dynamic interface alternation=
 is more ideal but I think I'll play with it.

>=20
> If picostations are only connected point-to-point to each other, and
> there are no other clients sending traffic to them (except the
> supernodes), then interface alternating won't take advantage of the
> "faster dual link connection"
> You must use interface bonding to achieve that.
>=20
> Interface alternating would be useful, for example, if picostation2
> from supernode2 was receiving a radio transmission from a distant
> supernode3 (not pictured) destined at supernode1. Then, instead of
> trying to relay the packets through that same picostation2, it would
> use picostation1 to send them and avoid reusing the same interface.
>=20
> Cheers!
>=20
> Guido

 I think I understand. Basically, so long as two interfaces both have a path=
 the to destination of acceptable quality, it will send the packets out the i=
nterface that did not receive the packets. Hop count doesn't have a direct e=
ffect, we don't really care about hop count, only about link quality.

Is that the case?


If hop count doesn't really matter, how do I identify my high quality, high c=
apacity backhauls?=
