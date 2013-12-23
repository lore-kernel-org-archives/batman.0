Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 23 Dec 2013 20:17:20 +0800
Message-ID: <1844581.p5rM2dVbDD@diderot>
In-Reply-To: <1387758485-3568-1-git-send-email-antonio@meshcoding.com>
References: <1387758485-3568-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4022746.bAjF2yOADC";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint 1/2] Revert "batman-adv: free
	nf_bridge member on locally delivered skb"
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


--nextPart4022746.bAjF2yOADC
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 23 December 2013 01:28:04 Antonio Quartulli wrote:
> This reverts commit 9048eb62124f47f66d12eb1d706ab5fb265553f7.
> 
> This fix can be implemented using the nf_Reset() helper
> instead of partly reimplementing it with a batman-adv
> private function.
> 
> Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
> ---
>  soft-interface.c |  8 --------
>  soft-interface.h | 16 ----------------
>  2 files changed, 24 deletions(-)

Applied in revision 6bd723.

Thanks,
Marek

--nextPart4022746.bAjF2yOADC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSuCnYAAoJEFNVTo/uthzAsGEIAMTswVwgAzRpecRChTafecU2
XZOk0ND7I3kqiM0XMZJgeF4ojrCmoFJecrHv445tJl8RuBQubZfDIn9wJQ6yMUVR
hUNLoczvraw/ynhJD7P8XjbnMDSKOBPql1y/TQ9TiDE6r0qaKTBp4eRisu3DyM7n
1ektUup1cQ0RlOrMH4/aHTh3e8fawII4nXcpPIOnjk6/mzxYPcc+4A52mZQZ/VXG
6ZF/yZ2ss7rG8e9QTYoJgJy4lWepIAi3heT6RQNC4Ym7K3Papzat31rr/DrSzltn
eITPNYggNfw64CM4M4/YHQHTemScWqW80MvdP6cbdm4GtJ3NZ9ZtbJYYJj0TZmw=
=V8Mv
-----END PGP SIGNATURE-----

--nextPart4022746.bAjF2yOADC--

