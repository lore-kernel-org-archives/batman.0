Return-Path: <dandenson@gmail.com>
MIME-Version: 1.0
In-Reply-To: <4F77B50B.6030402@codigosur.org>
References: <CAA_JP8X+vPn39-QK-zPjdd1Mtn4PCTjigpV4fFM6sTVUmBiLTg@mail.gmail.com>
	<CAHD-aqKN_+5fwg65Udpr6jxt5tFsu5XXsMWkk75ujPK3bJcqJw@mail.gmail.com>
	<CAA_JP8UxNW18xWZe62ySY=H27HDnZY1YBQV-7ZGUHYnSS-ZSHw@mail.gmail.com>
	<CAHD-aqK_CGbc8u5GuEBJyFzrk2rTHHTw=bAiWjFafAW9xOqWiw@mail.gmail.com>
	<BBFA727B-FECF-4C04-BCD1-3C76CBD010DE@gmail.com>
	<CAHD-aqLOLFq5LOYa94BffAzzD2uMSeKOtwaa_PG1+d8E2vrriw@mail.gmail.com>
	<CAA_JP8XtADXO=J6rKdQNTz3vGeLr0+a1fJSsyS9Lb=-zttWgug@mail.gmail.com>
	<4F77AFDD.7050909@codigosur.org> <4F77B50B.6030402@codigosur.org>
Date: Sat, 31 Mar 2012 20:10:40 -0600
Message-ID: <CAA_JP8XaxJ02w0c9UsHNbaEzUt=vQAZoM4bT97dtFaqBxatPyA@mail.gmail.com>
From: dan <dandenson@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] [OT] ruci / Was: link alternation when radios
 are not on batman-adv router?
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

2012/3/31 Nicol=E1s Ech=E1niz <nicoechaniz@codigosur.org>:
> on status between repo and nodes.
> 5) can always revert nodes or the whole network to any previous state
> (provided by mercurial), as long as you keep a useful commit

Thanks for the comments and suggestion.  I will definitely check this out.

I think I am going to use the mikrotik rb751 flashed to openwrt for
the supernode tests.  They have 5 ethernet ports that can be addressed
individually as well as wireless that I can bridge in for client
access.  Picostations for the standard nodes and for the radio
interfaces on the supernode.  I'll do 2.4Ghz for all local meshing and
5Ghz for the links between supernodes and the backhauls.
