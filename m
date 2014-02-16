Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 16 Feb 2014 14:28:41 +0800
Message-ID: <4941912.0bnlJBaeNa@diderot>
In-Reply-To: <1392482874-9024-5-git-send-email-linus.luessing@web.de>
References: <1392482874-9024-1-git-send-email-linus.luessing@web.de>
 <1392482874-9024-5-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1568497.tz7A91YHVc";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv14 4/6] batman-adv: Modified forwarding
	behaviour for multicast packets
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


--nextPart1568497.tz7A91YHVc
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Saturday 15 February 2014 17:47:52 Linus L=FCssing wrote:
> With this patch a multicast packet is not always simply flooded anymo=
re,
> the behaviour for the following cases is changed to reduce
> unnecessary overhead:
>=20
> If all nodes within the horizon of a certain node have signalized
> multicast listener announcement capability then an IPv6 multicast pac=
ket
> with a destination of IPv6 link-local scope (excluding ff02::1) comin=
g
> from the upstream of this node...
>=20
> * ...is dropped if there is no according multicast listener in the
>   translation table,
> * ...is forwarded via unicast if there is a single node with interest=
ed
>   multicast listeners
> * ...and otherwise still gets flooded.
>=20
> Signed-off-by: Linus L=FCssing <linus.luessing@web.de>
> ---
>  multicast.c          |  127
> ++++++++++++++++++++++++++++++++++++++++++++++++++
> multicast.h          |   25 ++++++++++
>  send.c               |   10 ++--
>  send.h               |    5 ++
>  soft-interface.c     |   20 +++++++-
>  sysfs-class-net-mesh |    9 ++++
>  sysfs.c              |    6 +++
>  translation-table.c  |   92 ++++++++++++++++++++++++++++--------
>  translation-table.h  |    2 +
>  types.h              |    7 +++
>  10 files changed, 277 insertions(+), 26 deletions(-)

Applied in revision 405cc1e.

Thanks,
Marek

--nextPart1568497.tz7A91YHVc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTAFqZAAoJEFNVTo/uthzASBwH/1l0fCjs53sR0oF2tT5TUEk7
NhzUV/TbgenIVbkmP7MSzSM76LQIvgVO0MOKrO9IM/LtadWwQqx9wQ5j7E1VMt42
lUUrXtykZUSHzPBEqtZkOFoBno9Wv1d0Syh6gh7xxFTTSY4DBgFocmyuexpLFq1Y
cQwhUkv0bUh2UWjRMrMuBAFb2EG6etlpONzYvKv5F8hq1qxVAzm5//JayiYPQvIq
GeeorgmSDpKQ2xBtRb0jhIkvvi2tcma54Y7tVpRj4/2qSKGC820llbnogRB8/csY
KOEB4fjF3xQR8+evaykihVHd6loY5vKck6awSOagPbQ9HsDwPG1UUsbFggni/qA=
=NJLO
-----END PGP SIGNATURE-----

--nextPart1568497.tz7A91YHVc--

