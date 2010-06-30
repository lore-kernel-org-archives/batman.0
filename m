Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Wed, 30 Jun 2010 12:21:08 +0200
References: <1277867781-10472-1-git-send-email-linus.luessing@web.de>
In-Reply-To: <1277867781-10472-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1354505.bf3h8iF8XO";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201006301221.09773.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Add last-seen in originator
	table
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

--nextPart1354505.bf3h8iF8XO
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Linus L=FCssing wrote:
> From: mesh-node <mesh-node@mesh-node1.(none)>
I think the person who applies this should remove the From and the next emp=
ty=20
line... or do you have a secret dwarf named mesh-node who works for you? :D


> Right now, there is no easy/intuitive way to find out whether a node
> might have vanished. This commit adds the time when a node was last seen
> to the originator table output, so that a common user is able to tell
> whether a node might have gone without having to wait PURGE_TIMEOUT
> seconds until that node gets "garbe-collected".

The rest looks good, but was a little bit irritated about the change of the=
=20
table header (which makes sense to split it in two lines, but didn't expect=
ed=20
that this patch does that).

Best regards,
	Sven

--nextPart1354505.bf3h8iF8XO
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMKxqVAAoJEF2HCgfBJntGgSMP/3gdIFCmdsJS1NzRWIyXC3q9
Sxg9bEIJQksUSM9LgPRQYVUpRR0P+PVlAQFc9ol0kbeMptPSol/r+wWiXCExDC0Q
Hn4ybOIQWPp7iTQc+ChGNos9AjU51VMKN0hCC9gGwjOPu1tM5odNY3NW//25avvv
28o89PoG19IuLgJBQAL7xxkTdb/etUAbelETbaBBwXX4uj78Bnw9YqHADxRhuqn1
EDbBZT9vKtN7R6VwAVgZCOIM8k0UkyGlOxUBfgO8yzvwc7pRI1SLDAOmfHf+En/R
XB/Bel2aNuwQDhStPxOqiTeL691uSmI/e/becTbh0gm2yjDY9haXQWyRkBdsJFeo
/qW6BNmA73BLhspQkZjxfp4RuDRe70d6gu43WdSwtD3UNz2+7DJK0aJJJP+ZLTGy
9aNrp49ZrtVJz5W5HvRrM/oJgmg+l7SlzJjt2lrrn7XqvStNuJDs0yTw9riXnwpS
BqbVXQC1FRxUgf2tjhuLdUWZykNW67RrE2q7tuj5ELr+lTP16m9ZI+rOCjMOgn1O
bS4rekRfIiUxmNm99UIhfOPToj76+K73yhmmj4P+c1oYSiho/v7Rj5SixqA3jkra
v0/XmVjSWhNSrqCZDatPVo9xjYqyElKRtxZYrPv+caR9htXiCoJYFPYF/RpgCJvd
FKQ18hwuhXulmqwSt+hM
=hGgu
-----END PGP SIGNATURE-----

--nextPart1354505.bf3h8iF8XO--
