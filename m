Return-Path: <linus.luessing@web.de>
Date: Sun, 30 Aug 2009 03:59:03 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20090830015903.GA26116@Linus-Debian>
References: <20090830013647.GA26017@Linus-Debian>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
In-Reply-To: <20090830013647.GA26017@Linus-Debian>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] [patch] adding subgraph-feature to vis-output in
 dot-file-format
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
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.net>


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

And if someone prefers a visual example, a simple setup like
node1 <-> node2 <-> node3 results into a dot-file like this:

digraph {
        "22:05:f9:aa:77:1f" -> "a2:14:84:e5:e5:46" [label=3D"1.15"]
        "22:05:f9:aa:77:1f" -> "00:ff:5b:62:9c:a3" [label=3D"HNA"]
        subgraph "cluster_22:05:f9:aa:77:1f" {
                "22:05:f9:aa:77:1f" [peripheries=3D2]
        }  =20
        "6a:25:1f:a0:14:72" -> "4e:18:87:ef:80:12" [label=3D"1.0"]
        "6a:25:1f:a0:14:72" -> "00:ff:2c:c8:bd:d5" [label=3D"HNA"]
        subgraph "cluster_6a:25:1f:a0:14:72" {
                "6a:25:1f:a0:14:72" [peripheries=3D2]
        }  =20
        "a2:14:84:e5:e5:46" -> "22:05:f9:aa:77:1f" [label=3D"1.0"]
        "4e:18:87:ef:80:12" -> "6a:25:1f:a0:14:72" [label=3D"1.15"]
        "a2:14:84:e5:e5:46" -> "00:ff:5e:e0:23:15" [label=3D"HNA"]
        subgraph "cluster_a2:14:84:e5:e5:46" {
                "a2:14:84:e5:e5:46" [peripheries=3D2]
                "4e:18:87:ef:80:12"
        }  =20
}

Which can then be parsed to a nice svg with fdp (or dot):
http://krtek.asta.uni-luebeck.de:8080/~tux/batman-vis-with-subgraph.svg

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQIcBAEBAgAGBQJKmdznAAoJEBKw7u43QNpfiLwQAJVvKrB7YLnA7MKWZPGb337K
vTfQMQsg+m2M+W2Uf207qpO2xXFotFb0r8+r7pDB3reLnmg71cw4cyWbxqWHqYZx
xtqNsytiOztzhZsWKqfZd0pe/PchiWRurGQz3p4WlzI0KURVdpmecYnJ+HqeNUUa
E2CJ8M12ulON1FRYVqtwZwER8ZgOVeLcYrVvHKCNDke7wqwLtXTRcgFimXTcyFpn
Apz5OI61TeCjeLlni5AUCIlgdnufXdxMMuJkmF/4bw4w9Rl2A5zrMUBHIqGHuI17
9TYINGqFS++mGpGULICwlzU1ZWauOpPwm7G+u2sKBNAU3g1tHGGjLET2V6cxLEyw
IFJ4oPhutUqFLDgs6Aak+fKg0f20bFV3FZU5aUa6X0TRjIguBWd8gwbdQxsujvp7
kPjIBsK9R+E9b8wDfnmmMFbHO2hUHkbPew5pBgRIjZY/vqrHPIo1aKMQKrZi5Rrn
EV620+ycS0SbWjR9XBHlfEZ3YAUdS3pQMMuRlp0pyMUwFvsIZ2WJ5Oxo6615KgBn
0xF7S93gxzj1qqioBcn4WlaIlH09dMCdAIOPMyfjwtfH5SI81g2GrxZrbj0XI98P
pRLyZIXT+ZltVOrVuBGH2DvS6srXhaUrxoU0A0syPOMMNzaJyS2+vQYXUjqWTQdb
KC3m30FkIQm5hbC/SKVX
=Dzt5
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
