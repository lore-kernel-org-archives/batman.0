Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 18 Sep 2015 16:13:05 +0800
Message-ID: <4817897.SOAbMYHa4j@voltaire>
In-Reply-To: <1442336448-23306-1-git-send-email-sven@narfation.org>
References: <1442336448-23306-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3114328.r19NPoAUMT";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2] batman-adv: Fix kerneldoc parsing of
	return description
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

--nextPart3114328.r19NPoAUMT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, September 15, 2015 19:00:48 Sven Eckelmann wrote:
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v2:
>  - More comments changed
> 
>  net/batman-adv/bat_iv_ogm.c            | 18 +++----
>  net/batman-adv/bitarray.c              |  2 +-
>  net/batman-adv/bitarray.h              | 11 +++--
>  net/batman-adv/bridge_loop_avoidance.c | 68 ++++++++++++++++++--------
>  net/batman-adv/distributed-arp-table.c | 37 +++++++-------
>  net/batman-adv/fragmentation.c         | 17 ++++---
>  net/batman-adv/fragmentation.h         |  2 +-
>  net/batman-adv/gateway_client.c        | 14 +++---
>  net/batman-adv/gateway_common.c        |  2 +-
>  net/batman-adv/hard-interface.c        |  7 +--
>  net/batman-adv/hash.h                  | 22 +++++----
>  net/batman-adv/main.c                  | 26 +++++-----
>  net/batman-adv/main.h                  | 13 +++--
>  net/batman-adv/multicast.c             | 35 +++++++-------
>  net/batman-adv/network-coding.c        | 42 ++++++++--------
>  net/batman-adv/originator.c            | 48 +++++++++++--------
>  net/batman-adv/routing.c               | 30 +++++++-----
>  net/batman-adv/send.c                  | 24 +++++-----
>  net/batman-adv/send.h                  |  4 +-
>  net/batman-adv/soft-interface.c        | 14 +++---
>  net/batman-adv/sysfs.c                 | 10 ++--
>  net/batman-adv/translation-table.c     | 88
> ++++++++++++++++++++-------------- 22 files changed, 305 insertions(+), 229
> deletions(-)

Applied in revision b615fba.

Thanks,
Marek

--nextPart3114328.r19NPoAUMT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJV+8eRAAoJEFNVTo/uthzAVcgIAKST+0Vz95edTdhSeL4nL1l+
WO2BTceoYBy007G/J7GC+iSNN2N6cN0toUl3eQlMrfQ+gIv7kwkfxkXVvdVtmLfj
Lj5akjlcrsg9ZZTVv1Xxlnf1M6sPCFrsfdKJ/KahkTBe4UvJmObmb8lQtvBUB5Md
hQPtHzCiOPuVwKuLa6GcO450m2X0KGkklVX2hSOhIkaejU6aIcz81s5keJsewqaf
b71UPFNm0MByHBdCVcymO62M5SY64BOekN230VlA/LyxkJo8AO9ehrYG3SXlmvgN
pUYsY2wSYg9RFXGjjXmit6bnbEU86x6Cu5MTdqSe4SNnRf38VCVCvcHASoCSGNo=
=reC5
-----END PGP SIGNATURE-----

--nextPart3114328.r19NPoAUMT--

