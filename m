Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 29 Feb 2016 10:23:42 +0800
Message-ID: <9978680.AHfZt94x15@voltaire>
In-Reply-To: <1456652670-18226-1-git-send-email-sven@narfation.org>
References: <1456652670-18226-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4761695.IrILrCov5q";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: ELP - use new
	ethtool_link_get_ksettings API
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
Cc: Antonio Quartulli <a@unstable.cc>

--nextPart4761695.IrILrCov5q
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, February 28, 2016 10:44:30 Sven Eckelmann wrote:
> From: Antonio Quartulli <a@unstable.cc>
> 
> The ethtool API is changing in linux-4.6 and the B.A.T.M.A.N. V
> code has to be changed accordingly.
> 
> Fixes: 5c3245172c01 ("batman-adv: ELP - compute the metric based on the
> estimated throughput") Signed-off-by: Antonio Quartulli <a@unstable.cc>
> [sven@narfation.org: Added compat code for __ethtool_get_link_ksettings]
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> resend of "RFC v2" as patch with my Signed-off-by added
> 
>  compat-include/linux/ethtool.h | 62
> ++++++++++++++++++++++++++++++++++++++++++ net/batman-adv/bat_v_elp.c     |
> 12 ++++----
>  2 files changed, 68 insertions(+), 6 deletions(-)
>  create mode 100644 compat-include/linux/ethtool.h

Applied in revision 3515604.

Thanks,
Marek

--nextPart4761695.IrILrCov5q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJW06uuAAoJEFNVTo/uthzAGnkH/0N3pXU4epHVDkHeNikFFlc/
lE9nd6CTByec+4tRm1kt7lVbz6j/99v7XPKsxrLn28h5UvTkxq1UOmk8/x4iN5bK
OPpo+3qZxahElZlddGCToHmNCy9BUxp1bT8RxlzJp/DHvnEAIq8rDQrSZTSDyxTt
y7lyQaunYxmYKSLXtAz85t+I/gD7nlxSzGIXhPDJ1VcUXtdL5OZPm2eTcoGZCWml
/EgtBNaldr4+ROQGubIb+gZ7otNjmVqvlCvDCWVTKZimnZTbpGd1DlzmCTooWIHM
kzCJOXGGkFhEUuH+pPt1XJHfGb4LcI/Mwy4Ay3FeSzg6a90smc3NourbcW3Y/v0=
=s2Ng
-----END PGP SIGNATURE-----

--nextPart4761695.IrILrCov5q--

