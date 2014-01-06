Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 06 Jan 2014 16:42:05 +0800
Message-ID: <92608201.UqxXi7mTSg@diderot>
In-Reply-To: <1388960736-3873-2-git-send-email-antonio@meshcoding.com>
References: <1388960736-3873-1-git-send-email-antonio@meshcoding.com>
 <1388960736-3873-2-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3412759.pEXQB2nvfU";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 next 2/3] batctl: implement
	vlan-to-link helper functions
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


--nextPart3412759.pEXQB2nvfU
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday 05 January 2014 23:25:35 Antonio Quartulli wrote:
> This functions can be used to convert a vlan interface
> into the real one and to extract the vlan identifier.
> 
> Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
> ---
>  functions.c | 159
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ functions.h
> |   1 +
>  2 files changed, 160 insertions(+)

Applied in revision d29288f.

Thanks,
Marek

--nextPart3412759.pEXQB2nvfU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSymxdAAoJEFNVTo/uthzA8UgH/1nRDrMk2RVvvX1QtGw1rvoe
Rz8kJwY7s2hnSiev9hBUgWFcPokOSLJiXXZLgUFzm+yFCzjTvL8S1Ft1W3Wk/C/v
lbV85L9Onj2ydpn93UNv2B7dHh0xTQsJrhRhBRjLpubEj+rhN1FTN2DCwDTwWaJ2
B0mZIYWag3VxiXlBPHCMmUOWvchgKSjvgMOXHrH3Ljq68bsuNU/iFutRq4XitUAm
xAgrs8L3b9BZJDfjMv9BM19vn4pVSNaNM0rAXV2EDz7d/3ZTovoNcDsQl+9ixw5X
Z1aeCj0yWLrTrXyjKFc1FpnzKSPDVOUpdh99z6Nk0Nkv4N8OUKKi4diFAbBcjws=
=SKSI
-----END PGP SIGNATURE-----

--nextPart3412759.pEXQB2nvfU--

