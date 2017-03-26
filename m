Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 26 Mar 2017 11:14:22 +0200
Message-ID: <1842913.ZZCfD9UzWp@sven-edge>
In-Reply-To: <20170217101708.19336-6-linus.luessing@c0d3.blue>
References: <20170217101708.19336-1-linus.luessing@c0d3.blue>
 <20170217101708.19336-6-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1743670.cS6KVZ5Akb";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 5/6] batman-adv: restructure
	rebroadcast counter into forw_packet API
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

--nextPart1743670.cS6KVZ5Akb
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Freitag, 17. Februar 2017 11:17:07 CEST Linus L=FCssing wrote:
> This patch refactors the num_packets counter of a forw_packet in the
> following three ways:
>=20
> 1) Removed dual-use of forw_packet::num_packets:
>    -> now for aggregation purposes only
> 2) Using forw_packet::skb::cb::num_bcasts instead:
>    -> for easier access in aggregation code later
> 3) make access to num_bcasts private to batadv_forw_packet_*()
>=20
> Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>
> ---
>  net/batman-adv/distributed-arp-table.c |  2 +-
>  net/batman-adv/main.c                  |  3 ++
>  net/batman-adv/send.c                  | 50 ++++++++++++++++++++++++++++=
++++--
>  net/batman-adv/send.h                  |  1 +
>  net/batman-adv/soft-interface.c        |  3 ++
>  net/batman-adv/types.h                 |  4 ++-
>  6 files changed, 58 insertions(+), 5 deletions(-)

Added this patch as c5d596e8b96e97da64c8aea759ddc016bca760a1 [1]. Have added
it out of order to have at least the non-controversial "cleanup" patches
integrated. The other patches can therefore use the provided functionality
and you don't have to resent these patches anymore.

Thanks,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/c5d596e8b96e97da64c8aea=
759ddc016bca760a1

--nextPart1743670.cS6KVZ5Akb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAljXhm4ACgkQXYcKB8Em
e0ZkbRAAp4k5RFp7Y+/QzABS9QIpZtf3LpbUHPsCNvG+C+KHoq+ssYBYQyzmfylO
X58KkPfqVDLUYXQr0UZFtb59sJnl1gI9/6dd5qDrN6Jcbv5N4CIL6UHAdBIBxyDs
Go76xhBA9gYdHNaxQYn1DJ3IYirl0bkYseP3/LN5fK9EnSGegcnxIa56ZhZM9Eq2
9S1nlCHlINIoGy2bYU4ZsUXHooh2jWNQXnnYcCsARFCp5ZkWi0jYFD1N15XNhrks
7h+FFsgz+rqosnS2RCW0+nJgloAkiYvOSzfs7H7mpdQ2JfR3toIhm632BkdiMpVH
dqTI2TilzAuXOLFbzXcuPff46SHlzbemCoRknIUwDEe471+ZijCYOWeyYtNx59i3
XH7fs8uaAr32oRbFZsBdE83Bdyeo/W+t8L6o+J9rFQ7JAJRkzPwY1z72uPnit3F7
4J6AQzHci2d0T+SDRKuKS4QFpLIpQFFED90WFBr8Ylw3jwwZ5aIIEbkgXcyFE4nE
RbdejV/4GYsEzs7h7ptWNEDvhCwz7cSgDGzWqizPuL44BhLgr+NgyFFsxHrCqRCc
a8bktwlweUhkYEeov1vunjLv9RC6od3b0/QqoD93JX2Cmj5o+PMuBOtx7/eM6f1h
Zx7/EiAFCOBt68Dw+2UqhwXlLcwxq4gB3g+1OlmJqXqccnLAhsw=
=IRZx
-----END PGP SIGNATURE-----

--nextPart1743670.cS6KVZ5Akb--

