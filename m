Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 05 Jan 2018 09:43:59 +0100
Message-ID: <14031954.75OLCfGoXO@sven-edge>
In-Reply-To: <1726572.H7yRIExqUN@sven-edge>
References: <609290bb4d6430ba6261347d43d53809a495afb9.1461267645.git.joe@perches.com>
 <1726572.H7yRIExqUN@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1584430.oQkvVxNo2U";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] checkpatch: Add test for keywords not starting
 on tabstops
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
Cc: Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org

--nextPart1584430.oQkvVxNo2U
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Freitag, 5. Januar 2018 09:30:27 CET Sven Eckelmann wrote:
> On Donnerstag, 21. April 2016 12:41:37 CET Joe Perches wrote:
> > It's somewhat common and in general a defect for c90 keywords to
> > not start on a tabstop.
> >
> > Add a test for this condition and warn when it occurs.
> 
> This seems to create some new false positives:
> 
>     WARNING: Statements should start on a tabstop
>     #919: FILE: ./net/batman-adv/sysfs.c:919:
>     +                                     char ifname[IFNAMSIZ])
>     
>     total: 0 errors, 1 warnings, 0 checks, 1251 lines checked
[...]

Grml, just noticed that I've replied to the wrong mail. This was of course introduced by 
http://lkml.kernel.org/r/1b5f97673f36595956ad43329f77bf1a5546d2ff.1513976662.git.joe@perches.com 
and not by this patch.

Kind regards,
	Sven
--nextPart1584430.oQkvVxNo2U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlpPOs8ACgkQXYcKB8Em
e0YPYA/+JqXB50n4oZ8ADwKNOb5qJJV7NpdZupgxW9iCUgwwhHqGEnYz1YQrUr00
WV+1rPkA1kD85xkpXeYm4Y8ep6WX0uAM+T1zKR28kdsQc7Ud7EouRcYvin/Z9fNl
NJPHOCKWTURb5i+F2frFGR6/+MDbBsfkq2h+O3TC3v8VLgb1eUV7Tt6Qp4azcKHq
Fvhxv/XkJ4NiFANs03FQBNJNxmer4eNAHqbAQJiu6rsvh6iP88BH3ZpZS2z1qsjD
Co2FRh1K6oFkCKTa6POi308DOuCt4NHcg68XRWh8bJpTOe4H7uFDLHSi5fHwl0BP
zGSVG+ARrnbNCrohAj2lHKdLO17f5SNd3rNQx+fjLzk9QPdwlVmR185kIuQzH42x
Vd1oUq8LGQfJVw7A5ULs1JFebhMTZbiaxUTeDzViSbDypCX4eKMmoDTlL9Vw7+gS
o0F2W2cNswxQbBALDAQwU36/h63n7Ea+orLmDk+zrGp8OQ7hxXIVKqa5HPNjq/Qa
2dT4iunkkvZ8x2RIcHuukUOfjR8mZpDaZUMBOM1yzCuVxyzYj0h6Xsh3QJmfS/1V
L6m2uX1AbPlJk8BWaGSuoHzc+Sap/FZZv14dRcsNB5oSrEnLyuD/l22uAOxBWWgk
c1qH140WjZb3elUna6l/0nJJhR43FjZhl32JQyMBVm5T0wOTE8g=
=lRgS
-----END PGP SIGNATURE-----

--nextPart1584430.oQkvVxNo2U--

