Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 16 Dec 2013 22:26:06 +0800
Message-ID: <1647680.AFshXubeme@diderot>
In-Reply-To: <1387110415-1062-1-git-send-email-antonio@meshcoding.com>
References: <1387110415-1062-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8280486.STZ0jV5xuq";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH next] batman-adv: fix alignment for
	batadv_tvlv_tt_change
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


--nextPart8280486.STZ0jV5xuq
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday 15 December 2013 13:26:55 Antonio Quartulli wrote:
> Make struct batadv_tvlv_tt_change 4 bytes long to avoid
> padding on any architecture.
> 
> Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
> ---
>  packet.h            | 4 ++--
>  translation-table.c | 6 ++++--
>  2 files changed, 6 insertions(+), 4 deletions(-)

Applied in revision 6639da5.

Thanks,
Marek

--nextPart8280486.STZ0jV5xuq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSrw2HAAoJEFNVTo/uthzA49UH/AjdVLAEeePtl79X2ymnHLOX
0uM8syDBUgUR8DM2GZ/iU2/MUuqzjQfbt9aKuZ2mR9CAVZ9eIAjX42RS8umVS62O
uoI0Y0No2rDa/nBV72HUP7yIYPRWVsLcGSyboufq5fISSvpS/KJL3ScHKAyYQ2sP
Qgo2kPXZAeUnDrioVklVuZiRBCDTioU86k/8jENVHrynqRTx35laf7zBma5uKF33
lYhTZZOOhK3I1/NDDFmMirffsMC/C1OwAL804bxVTImoI4FM6AS6EFSrztd9NhMQ
YPbMu/7FmR/EFxt94rqh6UBHPZYgKU/n+8Hv+c3+CGFEiiIu3j3vnDbnh+3Ilgg=
=9cC4
-----END PGP SIGNATURE-----

--nextPart8280486.STZ0jV5xuq--

