Return-Path: <sven.eckelmann@open-mesh.com>
From: Sven Eckelmann <sven.eckelmann@open-mesh.com>
Date: Thu, 29 Sep 2016 18:22:58 +0200
Message-ID: <5061493.MOEdlbWcnQ@sven-edge>
In-Reply-To: <20160817210759.19357-2-linus.luessing@c0d3.blue>
References: <20160817210759.19357-1-linus.luessing@c0d3.blue>
 <20160817210759.19357-2-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2078511.ViLt0p73xK";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 1/2] batman-adv: fix race conditions
	on interface removal
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

--nextPart2078511.ViLt0p73xK
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Mittwoch, 17. August 2016 23:07:58 CEST Linus L=FCssing wrote:
> +               WARN_ONCE(hlist_fake(&forw_packet->bm_list),
> +                         "Oh oh... the kernel OOPs are on our tail now..=
=2E Jim won't bail us out this time!\n");

The include to define WARN_ONCE is missing. Can you please add
"#include <linux/bug.h>" while resending the patch?

Thanks,
	Sven
--nextPart2078511.ViLt0p73xK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJX7T/iAAoJEF2HCgfBJntGMM4P+wePrbiWYGAbZQr3ae8bEV0v
NXZx7ciGeY8nLNFwFN+to7tMsw+u4XGrmvtyeV/OFBt02MZWM78lu5k2eHlJMzIU
stGoXsFzYDjJaNk0QRn86ryGVYUUaGvJ/gxeqZKapdYaFEmCp1wlDJ4K9XUGIlVL
uvSEU9rYLKD4jFanFWv/S3NU8ETiHOxVRd+DyzH+NhLFjCbDMCHgEicyY2GcW5hS
Ok9FMo1K7D8foUqqy5RHQmpkJB1r9mW0+cuwp2xKgHGaGZFfNMurihyUXu8m+ndA
+PRK+l93dAxFS1mIhtWutGe2tjA+Ig3XtFKFHIfOG8Qh/3jXyex9119WxzrE5uog
j+oRxdplN97gGNCOZtOd0zc0AOG1PSNQQ14xSZQc7eiZra7npSiu5HxvkoVBIcC1
437j3JSrbz5E/sATJFIrxMaSI5OttccI0nVEfcSecUFNfCtcbuyythe4UB3CscrU
dVeVnkioKmPZIBGSWP/5icAcwbXbQwz2e1Gr1R/RcL9iwZaS++7mmsDSqEE1t63V
UCmTX/qkA2rhbUHUg8Jy1go/EY1bhr2/1uc+O5lLaoRYg5X2/Wr1j7bcyJAXmvzW
WjYBEOwY7ysYaSI4Oy37VzRC/KY5buUjf+AhbA6a122V2Lq+N4N4YQhato8KQJ8Y
3RM6VY/uCf+DRgWJPb46
=iyvu
-----END PGP SIGNATURE-----

--nextPart2078511.ViLt0p73xK--

