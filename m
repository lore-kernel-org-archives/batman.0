Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 16 Feb 2014 14:30:38 +0800
Message-ID: <5422268.oz0seJLFlf@diderot>
In-Reply-To: <1392482874-9024-6-git-send-email-linus.luessing@web.de>
References: <1392482874-9024-1-git-send-email-linus.luessing@web.de>
 <1392482874-9024-6-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2110560.PHeQN6oX8v";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv14 5/6] batman-adv: Add IPv4
	link-local/IPv6-ll-all-nodes multicast support
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


--nextPart2110560.PHeQN6oX8v
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Saturday 15 February 2014 17:47:53 Linus L=FCssing wrote:
> With this patch a node may additionally perform the dropping or
> unicasting behaviour for a link-local IPv4 and link-local-all-nodes
> IPv6 multicast packet, too.
>=20
> The extra counter and BATADV_MCAST_WANT_ALL_UNSNOOPABLES flag is need=
ed
> because with a future bridge snooping support integration a node with=
 a
> bridge on top of its soft interface is not able to reliably detect it=
s
> multicast listeners for IPv4 link-local and the IPv6
> link-local-all-nodes addresses anymore (see RFC4541, section 2.1.2.2
> and section 3).
>=20
> Even though this new flag does make "no difference" now, it'll ensure=

> a seamless integration of multicast bridge support without needing to=

> break compatibility later.
>=20
> Also note, that even with multicast bridge support it won't be possib=
le
> to optimize 224.0.0.x and ff02::1 towards nodes with bridges, they wi=
ll
> always receive these ranges.
>=20
> Signed-off-by: Linus L=FCssing <linus.luessing@web.de>
> ---
>  main.c           |    6 +++
>  main.h           |    1 +
>  multicast.c      |  135
> ++++++++++++++++++++++++++++++++++++++++++++++++++----
> packet.h         |    9 ++++
>  soft-interface.c |    1 +
>  types.h          |   12 +++++
>  6 files changed, 156 insertions(+), 8 deletions(-)

Applied in revision 1c09034.

Thanks,
Marek

--nextPart2110560.PHeQN6oX8v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTAFsOAAoJEFNVTo/uthzA/X8H/izJ2dX2dlUf4Ud2/zmFKRuV
dL8V79AOIOfFUzGWTciyN/pPT0YS8VnHtTtFyAoPn7f+vDcxXlrwYH1VMTM+BPBM
VyKOTo4IQRbGllP4Jdszs5LbluAzW633RreFALj61c/iSSPFiUBeyrC2pf+0LKJe
c6fqk4WADpLjjA74WCMahtvgwv8Wqh/55A8xPOwkepJtOd+18CCoYHB+5wJgNNZK
13t4PmhFNby+X/jywKebd+aixia4HUrU0IKeurDkZVJVs+caq1X6v6mj4eMgi681
zm0HLjkJRIm/3HFisR1ZKWyBGaxeHQr6ojYAfW+UuTgxDsLSornFB6SCziTagto=
=CH1n
-----END PGP SIGNATURE-----

--nextPart2110560.PHeQN6oX8v--

