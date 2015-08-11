Return-Path: <antonio@meshcoding.com>
References: <1438779107-12665-1-git-send-email-antonio@meshcoding.com>
 <1438779107-12665-3-git-send-email-antonio@meshcoding.com>
 <063D6719AE5E284EB5DD2968C1650D6D1CB737B7@AcuExch.aculab.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Message-ID: <55CA2605.1070201@meshcoding.com>
Date: Tue, 11 Aug 2015 18:42:45 +0200
MIME-Version: 1.0
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D1CB737B7@AcuExch.aculab.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="07cHLHPAhjOK66dSWoq1BMb18TfC1RMaG"
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/4] batman-adv: fix kernel crash due to
 missing NULL checks
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: David Laight <David.Laight@ACULAB.COM>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>, Marek Lindner <mareklindner@neomailbox.ch>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--07cHLHPAhjOK66dSWoq1BMb18TfC1RMaG
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 05/08/15 15:15, David Laight wrote:
> So is this test just hiding anoter bug somewhere??

Hi David and thanks for your feedback.

The point is that we got several bug reports of kernel crashes due to
NULL pointer deferences in these lines and fter having debugged this
problem for quite a while we preferred to move on and propose this patch.=


Still, I am personally debugging this part of the code to understand if
we really have something wrong or if this NULL pointer is something we
should expect (and therefore check).

For the time being we think this patch is better than having horrible
kernel crashes, but I hope to come to a definitive conclusion soon.

Cheers,


--=20
Antonio Quartulli


--07cHLHPAhjOK66dSWoq1BMb18TfC1RMaG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVyiYJAAoJEOb/4TMchkvfxR4P/0/RZbf9gwyMmM3gPzCAcXEL
jFbg+R/lf0pORZO9OPrSvwS2wJKOKxnJZMc8oeCq3hx7h9BvPwM5dl2pefNFO8ZS
9Tf7HGVgQ5xH6JCfFwS0ILZxnnqTHOnSvyyzb4l+SXZqQSvbvLycmkBckSG1JnG2
SKMEav0APSDWLvo2VhpLRzWMHmzalZCJAXsSB/S3mo+Oun8QcMMgIRpWqUKizekS
wkyGYjq6lGz6cW1/vQKDS9hCudDiRSlyataIQ1Bg4zR03ob1h1GYYcR6PWKDe/v/
1ZV7SimOX10VJdtihq9arLSfZV7RqybwqsnCLahskIds2RRrB9RyM+i1bmT7x1IC
F6atCb7ymXu4ciGU7J93QpC1m3GpZEj26rQZIbePloTQIphfgNhCP5bhTvKe9sQX
mnSKi0Tou0MKkDcQeNmXxQQwRfT52JadKIzBJMXuzDOZLrTh+g6g3fDBEbMAEYGX
Te0NKn6jlVUyC6oTC/Labq2jlv5AjurMP5JhEogSP3Y7apSilrplQIVHjgXYQKiy
PFCkZjNcXHrGL4pLf9lXJc8qq0VP6NxibX565cZpo7PFBAcQdWTeQ7mNYXGvKfFy
LdVkgT2oafuOU5Sroe81CLXK/kp0X3TLFkigYo//ihPrd9Ah5h6WmlnsMz8TJ3+a
CMMDDYF9cWEBUALLmXip
=jJc+
-----END PGP SIGNATURE-----

--07cHLHPAhjOK66dSWoq1BMb18TfC1RMaG--
