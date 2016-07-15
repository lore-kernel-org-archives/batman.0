Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 15 Jul 2016 16:38:09 +0800
Message-ID: <6738075.DuRfZKd46c@voltaire>
In-Reply-To: <1467236695-6180-1-git-send-email-sven@narfation.org>
References: <1467236695-6180-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3432749.RGqWutpC3b";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Place kref_get near use
	of reference
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

--nextPart3432749.RGqWutpC3b
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, June 29, 2016 23:44:54 Sven Eckelmann wrote:
>  net/batman-adv/bat_iv_ogm.c            | 7 ++++---
>  net/batman-adv/bat_v_ogm.c             | 5 ++---
>  net/batman-adv/bridge_loop_avoidance.c | 9 ++++-----
>  net/batman-adv/distributed-arp-table.c | 2 +-
>  net/batman-adv/gateway_client.c        | 8 ++++++--
>  net/batman-adv/hard-interface.c        | 6 ++----
>  net/batman-adv/network-coding.c        | 9 ++++-----
>  net/batman-adv/originator.c            | 8 ++++----
>  net/batman-adv/soft-interface.c        | 4 ++++
>  net/batman-adv/translation-table.c     | 6 +++---
>  net/batman-adv/tvlv.c                  | 9 +++++++++
>  11 files changed, 43 insertions(+), 30 deletions(-)

Could you please split this patch into smaller changes ? Mostly (not always) 
along files ?

Thanks,
Marek

--nextPart3432749.RGqWutpC3b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXiKDxAAoJEFNVTo/uthzA1QkH/i0lA+LNsVG7TgsLqOyh9Q2H
//qh57/1tGl/BDH75VJpZ/uVm5Vp9iNFgwed4CkYHnwvdPbUVKKyuabDMFP31Q/P
rhJ2ehf+SlCl4aSqDvE5hw7O8I5rBfqjNqFqQCW+kJui9YSg/v40WBz6e5eaJhlL
FnDKuGCxOlGHhVFr1FiW0DPWH4nNrDUiYCfnsl4XVm2tzs1eWwqLtYYFQXxHFxgW
0122N0phgpsejnc+h35goUHCD3aiqMA99QWZS87XQKblsQ8AlOArNT7AjW/T0xdu
greU8J4BTm8AvjHBnmFIdli9yoge4x+Jj9aiO4kvLJ8zG6e9Qg6AZR1uO6JbcS4=
=1Chp
-----END PGP SIGNATURE-----

--nextPart3432749.RGqWutpC3b--

