Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 11 Dec 2013 10:28:31 +0800
Message-ID: <4704613.YrgyhfTcIu@diderot>
In-Reply-To: <1386700740-2752-1-git-send-email-antonio@meshcoding.com>
References: <1386700740-2752-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5194080.nhlrTB09fj";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 next] batadv: Slight optimization of
	batadv_compare_eth
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


--nextPart5194080.nhlrTB09fj
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 10 December 2013 19:39:00 Antonio Quartulli wrote:
> Use the newly added generic routine ether_addr_equal_unaligned
> to test if possibly unaligned to u16 Ethernet addresses are equal.
> 
> This slightly improves comparison time for systems with
> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> [antonio@meshcoding.com: added compat code for linux <3.14]
> Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
> ---
>  compat.h | 6 ++++++
>  main.h   | 2 +-
>  2 files changed, 7 insertions(+), 1 deletion(-)

Applied in revision 91890af.

Thanks,
Marek

--nextPart5194080.nhlrTB09fj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSp83SAAoJEFNVTo/uthzAPWgIAJzhUcMP2NMmehIvAtaHi1ey
u9yMa+MAW4DshGH/jrCQJmcKxS3sRJ2cbH8roGRqT4h8OljHpPBNQS7p4IW9xSbV
TJcgUzl4CNMxIqO5MoIA2ZNht/7K2VoYo8VrA6fKFFPqHjgW86wOFJwDa6p9SOX1
8cAQlhli2k7Sy7XDFwPt8X4PW1+iJY2jC4P9GQaPWmneMl3DXiqmgh/+CPgPwsux
HsFS3RcOgxv8fZPX0r85bE/8Y7kBI1wrcASHdg0RqyIcqW0gQ4P6Mu+tTMr/Mh0A
dj5djTxm7cv0taiwEknJPctUbvWLPe38nNpAlXvXnqjAnyCi1NXxcWX5ZLeA4iU=
=0Qos
-----END PGP SIGNATURE-----

--nextPart5194080.nhlrTB09fj--

