Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Thu, 17 Jun 2010 00:42:11 +0200
References: <1276727961-18719-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1276727961-18719-1-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3742246.RTeytbrdfV";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201006170042.13864.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: use rx_handler_data pointer
	to store net_bridge_port pointer
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
Cc: b.a.t.m.a.n@lists.open-mesh.net

--nextPart3742246.RTeytbrdfV
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Sven Eckelmann wrote:
> From: Jiri Pirko <jpirko@redhat.com>
>=20
> Register net_bridge_port pointer as rx_handler data pointer. As br_port is
> removed from struct net_device, another netdev priv_flag is added to
> indicate the device serves as a bridge port. Also rcuized pointers are now
> correctly dereferenced in br_fdb.c and in netfilter parts.
>=20
> Signed-off-by: Jiri Pirko <jpirko@redhat.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
> ---

This patch was already merged by David S. Miller <davem@davemloft.net> on T=
ue=20
Jun 15 20:48:58 CEST 2010 (probably for 2.6.36).

I have merged it into maint (not into trunk), but somebody has to think abo=
ut=20
a way to to get it working on older kernels. This patch has to made on top =
of=20
that patch to get it integrated into the next kernel merge window.


Best regards,
	Sven

--nextPart3742246.RTeytbrdfV
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMGVNEAAoJEF2HCgfBJntGZJcP/0bM+U7PPz3fDHF6jjXlal+t
XTbNOV+Wv4vv+Ck4IXrn54TX7jqgd7snZc+NX3XdcEqdfvoQFTsOdjkUnJhVVZOr
IOHSpUIL973c6VC8W07J7r488d4bWvlvdanCgO6wwLo08grpT80bWbDtQmU5cFgT
B3J0mZwE6RWHvZgedOyumH40/ix+897Iu/84IQzQU9euFHU7OyVY3sBk1Pkx2ZBs
gSuy6z+I/R6T2xW+C2550SrOgKSjwgoqe75Hd0Iq+egnZ7uHf6RFstheVuaVho8v
yatg4mPPJPAohf5DtAUTyK7kjXuRVoZ2in1FtoDqY2gK9FaXYgUn0p2ZXZUZOrQf
yg602j2VLLuZPCx8AG75mEFeIjapp7WQe9K82orF0EXB4ISwc4tJUa6uyekOKSQE
IgFs5fgqoj4sEGOhS4j5Ogvls3umK6VsbYBlZxVySbJ0hv+nxiowCas5xywgilaC
4Qsh19u1h2du4bWEJCkn/rxvZmExbdwDHRZoFzeF/zInl21l+7PI2DSVU6eJsSq1
q32oOlBm72aBhGYFJs8m6Asu5ZWB20rAdQEc1Fe8r1asYsdtRDDgo0HqAHoFd9Ch
DiIhUB9MBLD02fJXijgD39eWvBDefWy5WxUPqkuvyiIVb3iqN3L8rsb3M7Blf1g9
ltRaElnNePfPpgeVsiqI
=C/tE
-----END PGP SIGNATURE-----

--nextPart3742246.RTeytbrdfV--
