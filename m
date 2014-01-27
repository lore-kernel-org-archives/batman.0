Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 27 Jan 2014 15:49:30 +0800
Message-ID: <1468082.ByqQ7DSZZ5@diderot>
In-Reply-To: <1390347731-2270-1-git-send-email-antonio@meshcoding.com>
References: <1390347731-2270-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7562817.y9rTgayNjP";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: prefer ether_addr_copy to
	memcpy
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
Cc: Antonio Quartulli <antonio@meshcoding.com>


--nextPart7562817.y9rTgayNjP
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 22 January 2014 00:42:11 Antonio Quartulli wrote:
> On some architectures ether_addr_copy() is slightly faster
> than memcpy() therefore use the former when possible.
> 
> Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
> ---
>  bat_iv_ogm.c            | 10 +++++-----
>  bridge_loop_avoidance.c | 30 +++++++++++++++---------------
>  compat.h                |  1 +
>  distributed-arp-table.c |  4 ++--
>  fragmentation.c         |  4 ++--
>  gateway_client.c        |  2 +-
>  icmp_socket.c           | 11 ++++++-----
>  main.c                  |  4 ++--
>  network-coding.c        | 24 ++++++++++++------------
>  originator.c            |  4 ++--
>  routing.c               | 17 ++++++++---------
>  send.c                  |  8 ++++----
>  soft-interface.c        |  8 ++++----
>  translation-table.c     | 15 +++++++--------
>  14 files changed, 71 insertions(+), 71 deletions(-)

Applied in revision 513b2d1.

Thanks,
Marek

--nextPart7562817.y9rTgayNjP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJS5g+KAAoJEFNVTo/uthzAm1kH/RkIelf39mhzoCAMAj4a0wrT
iXerDAR9ucEkPnPsF+sORbGPqR3JS4pPZ2m9pxpYw02xtQAkGwNOGkX9ksjo35pe
mEvkGl2nlAHK+opWDCWyyhznPALO4NEWJfnJZWz6ruXppuapc8AsVkhsFOIOOBal
i+ca18FJzDUNz5YNLgSEBy8Z1jocTTDuvKRCOf5XvM9KFTKzOzzGZi8l1ApuQMvU
IOtMuyc52k8apGfQ+PHoe2QPpIrdi/JFa7BmsNwWZDJRqk2onakXJwd57SQfXTmV
IDnqeFqyNVAtIez2wBtkECpFpGb8lnpML9F6R6kYQ877gPZgy9msEahH804DoAE=
=7Fca
-----END PGP SIGNATURE-----

--nextPart7562817.y9rTgayNjP--

