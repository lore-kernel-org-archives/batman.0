Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 11 Feb 2014 20:04:45 +0800
Message-ID: <2217082.vixKCQPpGW@diderot>
In-Reply-To: <1391874306-15627-1-git-send-email-sw@simonwunderlich.de>
References: <1391874306-15627-1-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2158839.0WmD5mxy0W";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH-maint] batman-adv: fix potential
	orig_node reference leak
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


--nextPart2158839.0WmD5mxy0W
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday 08 February 2014 16:45:06 Simon Wunderlich wrote:
> Since batadv_orig_node_new() sets the refcount to two, assuming that
> the calling function will use a reference for putting the orig_node into
> a hash or similar, both references must be freed if initialization of
> the orig_node fails. Otherwise that object may be leaked in that error
> case.
> 
> Reported-by: Antonio Quartulli <antonio@meshcoding.com>
> Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
> ---
>  bat_iv_ogm.c |    2 ++
>  1 file changed, 2 insertions(+)

Applied in revision cb4d66e.

Thanks,
Marek

--nextPart2158839.0WmD5mxy0W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJS+hHdAAoJEFNVTo/uthzAtucIALRKHbz5QGdUvxmXVP2k8gXv
5huxa0BGqOYAPcuc7hFUaIe2sm0z7Lr1TbmuFSl66hPv+Qzbd4qv896wk22LjaoO
yuA/WPSM6QeFBLogc4VMXcY23HNCQmqWgOagSnfTOl9WTxqpzM+c3XNFO5ryvvwr
yEaMYYbGATdz2mH1eUJcLlMkkyVakaK0SL3Ig/pCIciL/C5XJttOHbllmgKlwKlt
CYNPbv+JD1MuKrGnUntEbBU5NsdEuKbrmXoLPrbU/WEnQ0TDiM4RSrp3L92Vwp/l
SyPJr27N1K4b0vjmq+qhmBT2fN+F13+8y7RP74QU2JXZbENIaHtKlqqiqRq6dkE=
=2za5
-----END PGP SIGNATURE-----

--nextPart2158839.0WmD5mxy0W--

