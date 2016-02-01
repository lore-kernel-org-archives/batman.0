Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 01 Feb 2016 09:39:33 +0800
Message-ID: <8558486.MmMlQ1Pu2K@voltaire>
In-Reply-To: <20160201004623.GK22112@prodigo.lan>
References: <1454257280-19649-1-git-send-email-mareklindner@neomailbox.ch>
 <1454257280-19649-2-git-send-email-mareklindner@neomailbox.ch>
 <20160201004623.GK22112@prodigo.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1779525.ODFYOHCDqY";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH next 2/3] batman-adv: convert wifi driver
	throughput to multiples of 100kbps
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

--nextPart1779525.ODFYOHCDqY
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, February 01, 2016 08:46:23 Antonio Quartulli wrote:
> On Mon, Feb 01, 2016 at 12:21:19AM +0800, Marek Lindner wrote:
> > Fixes: 5c324517 ("ELP - compute the metric based on the estimated
> > throughput")>
> > 
> >
> > Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
> 
> Maybe before merging this patch you add a one line commit message here
> saying that expected_throughput is supposed to be expressed in kbps,
> therefore this fix is required ?

As we haven't sent the offending patch upstream yet, you can simply merge all 
3 fixes into "ELP - compute the metric based on the estimated throughput" and 
be done with it. This patch isn't for stable ...

Cheers,
Marek

--nextPart1779525.ODFYOHCDqY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWrrdVAAoJEFNVTo/uthzAmyYH/iTq5k3SMfK91TEI4cXCdZpv
+XcjxtM8IvYt4gEdxbYOx/ipEQJWe9/fV0GhRCVqYmqhCTgzVlcYsvIj7hbi+DZ7
//FxTxT5uRCR0wIdK+Jzm2hIMfxP74xI+r3qbQNzny+0u/gRpF0PEzkkTIcX9gAd
eFeG3CMNCJFo96bRn34ly9UoAo50/pcmZNfT23LbOCk2PTy4e10f7JdYLxAU0P0j
ZqvzVQ84qc2QlR5JJ2l7taII2pi8esislhMt/5ZSwoasItR/CouM6dKjSLj/q5lh
jmLn0hLethJO2gLg8WewKKMEjYTeHL1EpwXuyRnfpnKQnI/UyTkakjfop3rqESY=
=J7ED
-----END PGP SIGNATURE-----

--nextPart1779525.ODFYOHCDqY--

