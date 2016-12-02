Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 02 Dec 2016 17:34:39 +0100
Message-ID: <1800526.pyWDsWJuoq@bentobox>
In-Reply-To: <20161130195327.GA10274@mwanda>
References: <20161130195327.GA10274@mwanda>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4029282.6HqC7cBLMm";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [bug report] batman-adv: make the TT CRC logic
	VLAN specific
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
Cc: Dan Carpenter <dan.carpenter@oracle.com>

--nextPart4029282.6HqC7cBLMm
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Mittwoch, 30. November 2016 22:53:27 CET Dan Carpenter wrote:
> Hello Antonio Quartulli,
> 
> The patch 7ea7b4a14275: "batman-adv: make the TT CRC logic VLAN
> specific" from Jul 30, 2013, leads to the following static checker
> warning:
[...]
> 	net/batman-adv/translation-table.c:3313 batadv_send_my_tt_response()
> 	error: uninitialized symbol 'tt_change'.

Thank you very much for your excellent report. Antonio seems to be busy
at the moment but Simon already forwarded [1] your suggestion to David.

Small question - what static checker reported that? I would usually guess
smatch when I see your name but at least it was not reproducible with the
current smatch from http://repo.or.cz/w/smatch.git

Kind regards,
	Sven

[1] https://patchwork.ozlabs.org/patch/702031/

--nextPart4029282.6HqC7cBLMm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlhBop8ACgkQXYcKB8Em
e0ZqVw//fM7q16aWyKFj7rFocG4YXf65ljJ9rTkkU9WxZpA1XoDihet6QGp5zDL0
z9+Fv91An5MHOBKTlYkNW1vEORI+ht3Ui143uSzkxhqe+LSTZOqJ4SzMs6pqPs4W
bBeh0lv1EJlj8dOb2E7XiiWqgqNGRKEn9XLD8OiN9XYKPucpg8wtP6GBf2Z9BKSn
6kHgUkRF/IciceIso7wUMDLwEFK3n2wIMXV97cbgkHzb6DMKpBTztogwP51zxPbF
BOwedzvoYUZxpNN2T6Ax364+vbKoVR7482i8wDyBgiozAJrwLjTjImJjxVwKl6GU
ecISAhJDQgVxK/s9aTTZ8fUGTTSW5oviwVhxp9+EMQtoyeQIgYDoU4nUIIapQGIy
BNxnhSVuCUK2X/mMV5jv9QSaX8Qp8Gjx32qMNBuSC/OfMdi5KifCpDrnwXyv6NJm
JqHxyvMdBbQXNAXxs3cXT2CAfgW7YEnRcU0g+9adBd2uDz+ShEIkdSq3P69Gujg+
LGd1IFedGsYxVuF9KLmY3f1QGehVu0fng9BQ9HNxp+a4XgT1CXL8ECK7R39ne7Up
L+WtllEt29iT4B570I1luo+3sueAHAODyWLStbSjlloXLmd+LiVH38vAf3o4C/uG
CcehXve3ZZOlblKsRssyGVgy5Bhq8UOz95G1olSzq5mzRu8fVQA=
=FuwC
-----END PGP SIGNATURE-----

--nextPart4029282.6HqC7cBLMm--

