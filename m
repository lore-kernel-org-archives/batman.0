Return-Path: <ordex@autistici.org>
Date: Thu, 28 Feb 2013 12:13:30 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130228111330.GC4530@ritirata.org>
References: <1362049727-16411-1-git-send-email-siwu@hrz.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Fig2xvG2VGoz8o/s"
Content-Disposition: inline
In-Reply-To: <1362049727-16411-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: change compat code to remove
	sparse warning
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
To: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>


--Fig2xvG2VGoz8o/s
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 28, 2013 at 12:08:47 +0100, Simon Wunderlich wrote:
> The latest compat patch fixing rtnl ops compile errors from 2.6.32
> ("batman-adv: add compat support for the new netlink ops") fixes
> the compilation, but leaves some sparse errors:
> batman-adv/soft-interface.c:573:10: warning: Initializer entry defined tw=
ice
> batman-adv/soft-interface.c:574:10: also defined here
>=20
> This patch uses another approach by moving the initializers in a dummy
> struct instead. This also removes the sparse errors.
>=20
> Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

Acked-by: Antonio Quartulli <ordex@autistici.org>


Thank you Simon!
Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--Fig2xvG2VGoz8o/s
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRLzvaAAoJEADl0hg6qKeO3HQP/3HIkOwqVRe19A30vAcSmIJO
PmrX2RbI3NxJS2SUa8t+3VaigdOymSh0Ybu5Qi9SRYvF0DX7JtFlvXHyD3A3pyGy
2VPtQigZKq0uDHBzvtvLvmlXofbG0jnuTPZ47OzWYPsts4I9FND/oF9LBqejzKSv
6QUhLUyCFk50IisGDUMLSC0bblMEDmjyLJFZNvlhgYssT7+RVTI5xldAnBtgeT4F
JKLVnLbHw5Q2vwYwaetMxtSBBDrdQWAG3H3GoCLqPmepuI0ROLPJvNhqPgOP0kAj
hAAGYrYoNFD9K8GotycKzGnYxQunhzMdQDe1otrhuLaAv1WG3VQqHCWIAtNB301s
UVrUfQbeONgurtaGdl30OmdroIhp2vTlG/NlDx5e4+woqeOXMcNSZQLKDl7C+3IM
rHqPt+/BAax2uzYZECLhwQLhI0pLCqvYz/FTZ9URWRJq2kdMiEIZ4MICjojRmTbI
ajEu/GF4wfk29H8OoI/OqLBI6dJbA9nGWTTWaaN9/ATxr46xuFQb8nPEk3rg1aFY
TZ/N7jFAknZeSKDxR+fghBgtXRjRLKduK9C59enupLZsEJnrgtzMNFARZ3qqmCiI
aIGBymTRr1/TAbE1mbDs2B70WmAMIJrp6hqgWyhMnPyoka+fsZ1VBSQ/UXW1i8Uy
UPr6kvvBca5kwmq4X4MD
=YKXB
-----END PGP SIGNATURE-----

--Fig2xvG2VGoz8o/s--
