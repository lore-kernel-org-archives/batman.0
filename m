Date: Thu, 3 Apr 2008 15:34:45 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Subject: Re: [B.A.T.M.A.N.] Node with two wireless interfaces - to bridge them
	or not?
Message-ID: <20080403133445.GA29070@hrz.tu-chemnitz.de>
References: <003a01c894a2$8f7ebe00$ae7c3a00$@com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
In-Reply-To: <003a01c894a2$8f7ebe00$ae7c3a00$@com>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: pele@balorda.com, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Pele,

bridging multiple interfaces is probably not a good idea, because as
soon as you have a cycle there will be bridging loops. The frames will
cycle until they are droppend and there is no TTL to stop them! :)
In Ethernet, a solution for this is STP [1], which will cut off (one of)=20
the links in the loop, but probably the good ones, so that is not what=20
you want. That is what the mesh is supposed to do. But bridging would
not bring you any performance increase anyway, so i'd suggest to=20
stick with your current setup.
(if you want to have only IP per interface for some reason, you can also
have a look at batman-advanced).
To increase multi-hop bandwidth you should better try the standard wifi=20
ways to reduce interferences/packet loss. E.g. try to switch off rts,=20
switch on fragmentation, limit baserate etc.=20

Best regards
	Simon

[1] http://de.wikipedia.org/wiki/Spanning_Tree_Protocol

On Wed, Apr 02, 2008 at 11:18:38AM +0200, Predrag Balorda wrote:
> I have one node that has two wireless interfaces. I was thinking to incre=
ase
> somewhat the multi-hop bandwidth loss and what is the best way of doing t=
hat.
> Currently I have ath0 with two nodes on there and ath1 with another two n=
odes
> but I'm not bridging those two interfaces. The thing is, they are on the =
same
> subnet so is there any point in keeping them "separate", any performance
> advantage, or should I just make a bridge and add the two ath's to it and=
 just
> have a single IP and run batman on that one bridge or leave it as it is, =
with
> two IPs from the same subnet and run batman ath0 /w ath1 /w as I do curre=
ntly?
>=20
> Pele
>=20
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH9Nz1rzg/fFk7axYRAiUjAKCS6B1g2GBcH1lIq9GSpkLpb8BKgQCg6auQ
gLRUiAWppesRPlupXEw32R4=
=pKGT
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
