Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 07 Jul 2015 16:45:25 +0800
Message-ID: <2114095.OehcXO4okb@voltaire>
In-Reply-To: <1435940999-3829-3-git-send-email-linus.luessing@c0d3.blue>
References: <1435940999-3829-1-git-send-email-linus.luessing@c0d3.blue>
 <1435940999-3829-3-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7494816.ytdMllJhYn";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 maint 2/4] batman-adv: Fix broken NC
	capability check
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


--nextPart7494816.ytdMllJhYn
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Friday, July 03, 2015 18:29:57 Linus L=FCssing wrote:
> The introduction of set_bit() and clear_bit() calls in batman-adv
> wrongly passed bitmasks and not the bit numbers to these functions.
> This leads to broken capability checks.
>=20
> Fixing this by making the capability enum a non-bitmasked one and by
> that passing non-masked values to set_bit()/clear_bit().
>=20
> Fixes: 586df9e2537b ("batman-adv: Make NC capability changes atomic")=

> Reported-by: Def <def@laposte.net>
> Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>
> ---
>  network-coding.c |    2 +-
>  types.h          |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Applied in revision 188ac4f.

Thanks,
Marek

--nextPart7494816.ytdMllJhYn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVm5GlAAoJEFNVTo/uthzAvFIH/0s0FAoeJN64m7mVW6N/Jv5k
LDqA1V2Xeh+W2g5zPoZXOvT0Ig3edbZjOagXVSGM/LOgSlGhLXTv3Cno1yBIeuyv
qPuM+ryUeVSn2UyFuJNiO2uF4O0C+OxNTG0gnHQQY9SEBJaCNnKQVPLb4FwVWRDC
yar/yn1nbclG790jdUmb/zLAyjflxQA6czlSyZhMVeMMoCxmc+WZLPQ07Yb/rWDj
+K2kM4JfrLd5XCRmAWqv76iUx+s5T9wpecj3n9Ez3ZGFrn/macrF1x5JvUOFZFIL
mSPAGWFSBmTYVRFmoSN+jFmRqBXEny/0Ul6Q6mvyaKlLDOb4V/zNfL3wQxgPOuo=
=6/px
-----END PGP SIGNATURE-----

--nextPart7494816.ytdMllJhYn--

