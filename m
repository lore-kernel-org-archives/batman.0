Return-Path: <gtolon@inti.gob.ar>
Message-ID: <4FA2A5F0.5090905@inti.gob.ar>
Date: Thu, 03 May 2012 12:36:16 -0300
From: gtolon@inti.gob.ar
MIME-Version: 1.0
References: <AE90C24D6B3A694183C094C60CF0A2F6026B6EF3@saturn3.aculab.com>	<4F994681.9040300@inti.gob.ar>	<CAJuY50ygkeQgr=CXUpZGJdR8AXQMq3gtEs0WvM5cQeE=ARf3MQ@mail.gmail.com>	<201204262326.06705.lindner_marek@yahoo.de>	<CAJuY50z3PfkDj0R3VUViZA_RqWk-jfwQSXp4LrgSsaAY+H2_iA@mail.gmail.com>	<4F9AE2E6.3090909@inti.gob.ar>	<CAHD-aqK3iQ9TEDjHx0F-HXU7dR8OUhJQSLZkU=dsVRcSBqJBHQ@mail.gmail.com>
	<CAJuY50y+mJ4AvBEEb-Fi9uPUom+KPgyGrxSiwnRqiyA2H0hUGQ@mail.gmail.com>
In-Reply-To: <CAJuY50y+mJ4AvBEEb-Fi9uPUom+KPgyGrxSiwnRqiyA2H0hUGQ@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] Traffic Control in batman-adv
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
To: b.a.t.m.a.n@lists.open-mesh.org

Guido and 3zl, thanks for the replies!

Regarding packet marking, i think it's a good idea, but when i tryed it=20
i had some issues with the interaction between iptables/ebtables and the=20
bridge, i'll read more about that.

I've heard about gargoyle, didn't know it was based on backfire. That=20
active congestion check sounds great!

In this link there's an abstract about that assolo method, interesting:

http://www.computer.org/portal/web/csdl/doi/10.1109/ICIMP.2009.28


Best regards

Gabriel




El 27/04/2012 07:34 p.m., 3zl Trizonelabs escribi=F3:
> measuring bandwidth we test with "assolo" packet in afrimesh repos
> (builds ok with trunk)
>
> maybe also have a look at
>
>
> http://wiki.openwrt.org/doc/howto/packet.scheduler/packet.scheduler.theory
>
>    TBF with netem discussed here
>                      https://forum.openwrt.org/viewtopic.php?pid=3D161108
>
> regards
> 3zl
>
