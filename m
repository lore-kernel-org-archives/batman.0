Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH v3 0/4] batctl: Add JSON debug commands
Date: Fri, 14 May 2021 18:18:21 +0200
Message-ID: <23505348.pnZsyTnv5I@sven-desktop>
In-Reply-To: <20210513142812.1707215-1-asarmanow@gmail.com>
References: <20210513142812.1707215-1-asarmanow@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4421445.FzZahCnmo4"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: Alexander Sarmanow <asarmanow@gmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org

 
--nextPart4421445.FzZahCnmo4
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: Alexander Sarmanow <asarmanow@gmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org, sw@simonwunderlich.de
Subject: Re: [PATCH v3 0/4] batctl: Add JSON debug commands
Date: Fri, 14 May 2021 18:18:21 +0200
Message-ID: <23505348.pnZsyTnv5I@sven-desktop>
In-Reply-To: <20210513142812.1707215-1-asarmanow@gmail.com>
References: <20210513142812.1707215-1-asarmanow@gmail.com>

On Thursday, 13 May 2021 16:28:08 CEST Alexander Sarmanow wrote:
> Following JSON debug commands will be added: originators_json,
> neighbors_json, translocal_json, transglobal_json.

Seems like this patchset is full of duplicated code which would have belonged 
as shared code in an earlier patch.

At the same time, a lot of functionality (batadv genl query commands) is 
missing - even stuff which was present in an earlier version of the patchset.

Kind regards,
	Sven
--nextPart4421445.FzZahCnmo4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmCeos0ACgkQXYcKB8Em
e0ZSGRAAvM1qLSukY4jNUKnyYAwmyubbFEskRZoZmJo7QPGrkrh7mGUIirSh3bNO
JqA198L+DUqWOcA4Ue4CfH1CeazUHzmjdzQIWVsKlsPyQRvKFdVGoq1tS4dNOM/z
BLuYotfGuixuv9vK7kS2EHfByzToPgSzgkwe+GEW+hvnk7S60ryMuyphLnqThFe9
lSRL6CtRxPFfBgwPD4Pu2jk3H16L5Gp1QFzEpFkggG2NqefVtKBu4GxPv19S1LUv
yyqJcWM4AUVcoeaRxh5h1V2VklZvHNhyptuS6VwN7ocdng9rzjL6e0RaoscUoQ0U
18sdKhP1rD2kfbCj7D4hfhdz70DxKucx7ULR4GCPxOF6+WxDRKYS7ZnJH8X81fvm
dJnbadXAYmBLwKsYZhm6POC9gRKi5hSlkWaqG3sM44haDR4sWgjCr6BimvwSOvK+
DoHbOd0sLXQKAGdQ8cLFsnMUjvdKc9P/lQ99XoyhfdDGpXQq8f1l0qfcPZMfM10N
YQarzbokHBMSIXvRSSnPOeR2olx/ZXii3diZQco0w5gDXyjiM8mwJSEN3ZiMbHme
1OpM5v6IpfdpoL79fwk4ho0hq2uZTNG7BoQXv072pWPgSrkXBcCUV7RO2RSZgiSu
jMrA77O7hDAAgaeGk4xdzw2oYRGmvq4a8n18X7qrAuDFOTpBn0s=
=zUr0
-----END PGP SIGNATURE-----

--nextPart4421445.FzZahCnmo4--


