Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 16 Feb 2014 14:25:53 +0800
Message-ID: <14662086.VEm2uN4R2D@diderot>
In-Reply-To: <1392482874-9024-4-git-send-email-linus.luessing@web.de>
References: <1392482874-9024-1-git-send-email-linus.luessing@web.de>
 <1392482874-9024-4-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2048688.bbKLsernt0";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv14 3/6] batman-adv: Announce new
	capability via multicast TVLV
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
To: b.a.t.m.a.n@lists.open-mesh.org


--nextPart2048688.bbKLsernt0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Saturday 15 February 2014 17:47:51 Linus L=FCssing wrote:
> If the soft interface of a node is not part of a bridge then a node
> announces a new multicast TVLV: The existence of this TVLV
> signalizes that this node is announcing all of its multicast listener=
s
> via the translation table infrastructure.
>=20
> Signed-off-by: Linus L=FCssing <linus.luessing@web.de>
> ---
>  main.c           |    1 +
>  multicast.c      |  121
> +++++++++++++++++++++++++++++++++++++++++++++++++++---
> multicast.h      |   14 +++++++
>  originator.c     |    6 +++
>  packet.h         |   12 ++++++
>  soft-interface.c |    4 ++
>  types.h          |   13 ++++++
>  7 files changed, 166 insertions(+), 5 deletions(-)

Applied in revision 77ec494.

Thanks,
Marek

--nextPart2048688.bbKLsernt0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTAFnxAAoJEFNVTo/uthzAQakH/0S7DbYHt980ArZBXVhOC5Dq
hiyyfPrNVuhHYcweNpd4Ye5YNX7Vo+hmZ5BSWl8xjq//wuq96mDY+bHWadWgYfte
KBj5OobQEbe9BygvzQP6z/suF1QQExtPJVjaE11NCfFT408k8voVw7fquL0DHLy7
2/UzWegUrjX/ce4Wy3GZsVsr6kyea/74jaIlB8NViDRo45JLvLWADavAMt0gRDDc
Ws/RoIJKWLvF7OmIVGHDIBK7Vz4uCkuI1qGWTuJYVIz6JsVHFnCHlR50eDwjYmwK
jsjSt1Zb6LC7ATCTuG217Ws31MKQZyVbQZU9ayZNjQnIWEtSABAhvOm5q3dDmE8=
=PTgp
-----END PGP SIGNATURE-----

--nextPart2048688.bbKLsernt0--

