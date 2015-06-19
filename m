Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 19 Jun 2015 17:34:49 +0800
Message-ID: <1831074.NdRWzKrIfh@voltaire>
In-Reply-To: <1434646404-19291-1-git-send-email-sven@narfation.org>
References: <1434646404-19291-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1667417.GR41cBz4oq";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/6] batman-adv: Remove batadv_ types
	forward declarations
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


--nextPart1667417.GR41cBz4oq
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, June 18, 2015 18:53:19 Sven Eckelmann wrote:
> main.h is included in every file and is the only way to access types.h.
> This makes forward declarations for all types defined in types.h
> unnecessary.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/bridge_loop_avoidance.h | 3 ---
>  net/batman-adv/debugfs.h               | 1 -
>  net/batman-adv/gateway_common.h        | 1 -
>  net/batman-adv/icmp_socket.h           | 1 -
>  net/batman-adv/multicast.h             | 2 --
>  net/batman-adv/network-coding.h        | 4 ----
>  net/batman-adv/routing.h               | 4 ----
>  net/batman-adv/send.h                  | 3 ---
>  net/batman-adv/soft-interface.h        | 4 ----
>  net/batman-adv/sysfs.h                 | 2 --
>  net/batman-adv/translation-table.h     | 2 --
>  11 files changed, 27 deletions(-)

Applied in revision 31b0151.

Thanks,
Marek

--nextPart1667417.GR41cBz4oq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVg+I6AAoJEFNVTo/uthzA3NoIAKnkbm6YKBwD+NXDeL7HEhUc
HPx5W4XQ3H9lzci0sIFKo/zBGhdOyzHT6ec3vOUnmn3pOZaMRtIx+3nTTs/5d1xU
fymGwiVqWXbsAikn2e1VprVwVE09+jSv2Lq7H2bpr6BuRwYtbfwojVs/7979Qx2u
vkuTuWSB2tKgHFBb3evxEiQIct6bat7ovn/YgKIZt65+vuLoWyE8emmqKa3q11Es
Y6YlHax+7i4xtbUolC12nVLDArWyVbz4Zac5S8JXGMWhUOJwzM30zgy44ixzqUTe
kZKh3Ig2uh7TdsnClOtOjAvcqylJT0ZbOE/GrNxotGp5EZEFwwTVaf+AaPCqUH8=
=hWVk
-----END PGP SIGNATURE-----

--nextPart1667417.GR41cBz4oq--

