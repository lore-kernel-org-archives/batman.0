Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 1 May 2010 20:10:18 +0200
References: <1272719410-406-1-git-send-email-andrew@lunn.ch>
	<201005011837.42615.sven.eckelmann@gmx.de>
	<201005020113.40372.lindner_marek@yahoo.de>
In-Reply-To: <201005020113.40372.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1466969.sG4W56TQzi";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201005012010.34029.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/4] batman-adv: Import sparse fixes from
	mainline.
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

--nextPart1466969.sG4W56TQzi
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Marek Lindner wrote:
> On Sunday 02 May 2010 00:34:56 Sven Eckelmann wrote:
> > This has not real something to do with this patch (which is good), but
> > to_net_dev was added in v2.6.20-236-g43cb76d and the README still states
> >=20
> >  that  we are compatible with linux 2.6.20. I think we must change that
> >  to 2.6.25 (explanation below).
>=20
> I ran into a bat_sysfs issue today regarding  kobject_create_and_add() on
> 2.6.21 and made a fix for it. With that patch it compiles fine but it nee=
ds
> some more testing though. I did not see any complaints about to_net_dev.
> It seems to be there: include/linux/netdevice.h line 538.
> We still might have some issues on 2.6.20 ..

Yes, v2.6.20-236-g43cb76d was merged into v2.6.21-rc1.

I started to create a compat lib with the new kobject stuff, but as you hav=
e=20
done it already... nice reaction time ;)

The v2.6.20 stuff seems even more tricky as the data stored in the structs =
was=20
changed too. The new stuff looks nice, but it gets really ugly if we want t=
o=20
support both.

Best regards.
	Sven

--nextPart1466969.sG4W56TQzi
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJL3G6LAAoJEF2HCgfBJntGPhcQAJLtYKc4raMXl3XMPZIx04T3
nAbqYkGia90ebTwMNLBSEdQC4N+B4A4RSEEty6qLx2xpA1CtK+gu9SWNX2QskPq7
+3Y4st9vLySSQEfoXv+ssTaTOK+a84tVJSqjkLhSjB1LqxqFB9BYJT0MpiukaWDg
RhgTEL3blvybI4KtQh0C1SJftVVnl8QYLxral61X10S/jsJqvlh5vCw8XBS3jxxZ
gNUmZq94rzvXnKOh9M3vhPUUA/yFq8YoItSGIrzqRr5B+7GJ4CT9Z14KeKIftsyn
rHuu4fTS7GF1++XCUoEEXYIsglHKEhOGg2VrfH0+2Ld424goTgnrC1hUwsTVDPA8
621adb55lOBxAOqkvC6TQXQPdZNP/lN8GYQRVg9WnHoe9giywY7C9qQmO8VI09vN
oRS8WGSPjzdbTdXEUnAyJ7zwvLWnhabkLn/xwmA/9qU+V2j7muIg/WmcbHLzH2be
m+i4Teu7taEaVI0pIro5EFim4BWmo84Ph0KhiZtFKgc/O+0DuaZIqaPa0fJn6j9A
7JenrWx6eDkVdQOU15nJcpw/+zR2qz/ay+/IAwRdXom5M0yhdwYDyjaoVd3sZPoA
peqa9srGfWQxYWMs7WoS6i1GagM8XWnROrbyVpYe6kx1Doq+S/GlHpBvUhavKjXn
aGgjoa9VW6nd6hQXOe6S
=H8YS
-----END PGP SIGNATURE-----

--nextPart1466969.sG4W56TQzi--
