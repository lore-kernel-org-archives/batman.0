Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 07 May 2012 13:28:24 +0200
Message-ID: <1722532.vrPSvYzAq4@bentobox>
In-Reply-To: <4FA7AD9B.2030604@universe-factory.net>
References: <4FA54C09.6000303@universe-factory.net>
	<201205071440.21129.lindner_marek@yahoo.de>
	<4FA7AD9B.2030604@universe-factory.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5369625.Nmrx6pmteG";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: fix visualization output
	without neighbors on the primary interface
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


--nextPart5369625.Nmrx6pmteG
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, May 07, 2012 01:10:19 PM Matthias Schiffer wrote:
> On 05/07/2012 08:40 AM, Marek Lindner wrote:
> > If you wish to replace the mac addresses with readable name you can
> > simply use a bat-hosts file to tell batctl which mac address should be
> > replaced. Check the bat-hosts section in our batctl online manpage:
> > http://downloads.open-mesh.org/batman/manpages/batctl.8.html
> 
> I know about bat-hosts, but this only works when the host displaying the
> data knows all the MAC address/hostname mappings. For community meshs
> like Freifunk networks it would be much nicer to allow each host to
> supply its own hostname for vis in my opinion. I think one possibility
> to add this without breaking compatiblity would be adding a hostname
> record after the neighbor entries in the vis packets.
> 
> It would be nice to convert the reserved field in the vis packet
> stucture to a flags field for things like this, but AFAICS the current
> code never sets this to zero, but this is a byte of uninitialized memory
> that is sent over the network - but again, I might be overlooking things
> as I'm not yet familar with the code.

Please don't think too much about the current packet types... there will be 
changes anyway [1,2]

And maybe you could also use the DHT implementation [3] for your distributed 
dns [4] (when you don't want to use already available stuff [5])

Kind regards,
	Sven

[1] http://www.open-mesh.org/wiki/batman-adv/BackwardsCompatibility
[2] http://www.open-mesh.org/wiki/batman-adv/Packet-types
[3] http://www.open-mesh.org/wiki/batman-adv/DistributedArpTable
[4] https://projects.universe-factory.net/projects/ngmrp/wiki
[5] http://www.multicastdns.org/

--nextPart5369625.Nmrx6pmteG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJPp7HYAAoJEF2HCgfBJntGYz4P+gIAuxftYApiHozDkR/Q/oo2
vVF5ohsF7ZptIQUBs0ox3rbcUaObCS9MOh/vOs/ersWWCA1wW6HczERHP9fIbRaV
OPZ3i0dt2hEwK6MnmG/1s/Ds+2ijguP3DC/hVkaOXrVX79kFrKyH6XVqQqSXpj2z
iLPCpQzNKA/s2at3VngcBaICumVvsZKqgo4L39vcKz+gV56eccB+THsieZFJxjQ1
ARuPGfk3las/k8s2qrOK6shGfmO8usGDB2cFCBru24H3TgSeePTict00zd+r5NdN
IAg+eiM2VueQtSC+aBa9Yr9Pd8Xh/z7yIh3S5GeZ8KktKMO7/j+1oneFLZA/1btv
6R5dciT0g5narjcAe1WA+ed+7AFgkjHMRxEpyzLFyIctaaxB3q5Jv5rbu6rZdGom
ZaZUysy7QcbebfhGLYiFVhfZODNhn+DuSd9893yB3hUfCCeHmDbS0ZEIQhqEDjBo
NIuRI0LLR/JSqH6j9Iaetez9BKFPC+ts+fzd0SQ5HWgFyR68gor+1TvhBjyW0XVp
RYseaN//9HrkgEbD7UfiLRUtspO27BEg8XTcHP8L1L05iz7UXeq6kJl13OGgMKEG
/egUgrx2rmLqiZVQ+FAkctztjrplAyU4h6onEGHOGXpMM7d6hrpLMOUGInYP+2pl
+qjzGupgFxdndBu8itjO
=YO6I
-----END PGP SIGNATURE-----

--nextPart5369625.Nmrx6pmteG--

