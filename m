Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 20 May 2016 16:58:01 +0800
Message-ID: <5391263.p0XQNe6lIm@voltaire>
In-Reply-To: <1463303266-25979-3-git-send-email-sven@narfation.org>
References: <1463303266-25979-1-git-send-email-sven@narfation.org>
 <1463303266-25979-3-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1908374.1M1rE0Eovv";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v3 3/6] batman-adv: split tvlv into a
	separate file
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

--nextPart1908374.1M1rE0Eovv
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, May 15, 2016 11:07:43 Sven Eckelmann wrote:
> From: Markus Pargmann <mpa@pengutronix.de>
> 
> The tvlv functionality in main.c is mostly unrelated to the rest of the
> content. It still takes up a large portion of this source file (~45%, 588
> lines). Moving it to a separate file makes it better visible as a main
> component of the batman-adv implementation and hides it less in the other
> helper functions in main.c
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> [sven@narfation.org: fix conflicts with current version, fix includes,
> rewrote commit message]
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v3:
>  - Patch was resurrected from https://patchwork.open-mesh.org/patch/4244/
>  - rewrote commit message
>  - fixed conflicts
>  - fixed includes
> ---
>  net/batman-adv/Makefile                |   1 +
>  net/batman-adv/bat_iv_ogm.c            |   1 +
>  net/batman-adv/bat_v_ogm.c             |   1 +
>  net/batman-adv/distributed-arp-table.c |   1 +
>  net/batman-adv/gateway_common.c        |   1 +
>  net/batman-adv/main.c                  | 591
> -------------------------------
> net/batman-adv/main.h                  |  34 --
>  net/batman-adv/multicast.c             |   1 +
>  net/batman-adv/network-coding.c        |   1 +
>  net/batman-adv/routing.c               |   1 +
>  net/batman-adv/translation-table.c     |   1 +
>  net/batman-adv/tvlv.c                  | 630
> +++++++++++++++++++++++++++++++++
> net/batman-adv/tvlv.h                  |  61 ++++
>  13 files changed, 700 insertions(+), 625 deletions(-)
>  create mode 100644 net/batman-adv/tvlv.c
>  create mode 100644 net/batman-adv/tvlv.h

Applied in revision 65326e3.

Thanks,
Marek

--nextPart1908374.1M1rE0Eovv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXPtGZAAoJEFNVTo/uthzAMjEIAJxS7aHPzz38PWhv6SaxC9Wi
VuZAghywqRl6PGYPMe6Hc9+6VRZ9RF3xIfQeJTlCPbzDCuvPwRl2uGBzs9szIHx5
jfElQzKPvP5oHqi9Hd+gofdsQMsEDMO5AljsghSSBLorfW8JUuDuVbDMaZjxX9FQ
xmy43CA/XMpK8pPJj7QXKm38dl2i1Juhc6OYzGH8sy0lymbSlUgptrVFmk4IU608
5/lB3WzE9TtZsr8doXWFCpIZGe5usD05vvrmMsdp7C0QejeEDVCiwmgDuTU40cOh
/VT8PECDH80McVDbbRXmwgFPFMWcyvEaLIF57ETMa76HUEbW4CsDzfw+1W4FvNc=
=+eJt
-----END PGP SIGNATURE-----

--nextPart1908374.1M1rE0Eovv--

