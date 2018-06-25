Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 25 Jun 2018 17:15:05 +0200
Message-ID: <2051232.3bxOfNrTxA@bentobox>
In-Reply-To: <VI1PR02MB36318EDC28705CFBFFF167809A4A0@VI1PR02MB3631.eurprd02.prod.outlook.com>
References: <1529491616-23222-1-git-send-email-omer.efrat@tandemg.com>
 <2698334.cOteLZxmq0@bentobox>
 <VI1PR02MB36318EDC28705CFBFFF167809A4A0@VI1PR02MB3631.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1559518.IcFyxG2UGy";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v4 3/5] batman-adv: use BIT_ULL for
 NL80211_STA_INFO_* attribute types
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Omer Efrat <omer.efrat@tandemg.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart1559518.IcFyxG2UGy
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Montag, 25. Juni 2018 14:31:19 CEST Omer Efrat wrote:
> Sven Eckelmann wrote:
> >Please fix the alignment:
> >
> >* Found wrong alignment at net/batman-adv/bat_v_elp.c:118, was 27 but expected 23
> 
> checkpatch script doesn't catch this error.
> how do I see this?

I saw it with my eyes. But the script bracket_align.py [1] prints the actual 
message.

Kind regards,
	Sven

[1] https://git.open-mesh.org/build_test.git/blob/HEAD:/testhelpers/bracket_align.py
--nextPart1559518.IcFyxG2UGy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlsxBvkACgkQXYcKB8Em
e0ZBzA//aDuVebWbK3MqKBk25PBygGE1YWWMXsnX3zXK0pOyVHjzgDXe7+ZouGiQ
jwJUJU2LEY5YZ29tuuYXXi/J22KzaME0ea3wxabNuK+biqxzu42Zyz3GBr+Y+23g
+Ch7Zs9v7utfjclLgF2ET+bT62u4tl6V4Tqdfyb8l88+hLVJMSUjCLVCYP5hxugh
V/zjfbwoBve8ALWEOR4oGyq0Q85cXYRnWmyAtPChh7omN5NHjCkNmx60zKyWPwx8
RyC0SgBAcSNzKytI9pgpI1aHdk1m8L9k2QYH/Hvb2ZFh7yfGGGWDyIwOBSTmwsz4
sujygPyNFD3dHCCo2+LxQkK2cf1ysuR/4cuN+VbDDGqHtbPZKk4uKHg16Aoe0WT8
Tqoe+tKiIV4aTuvQCxBQnObFh9OJn80oy+uT72FsZvq1EcgbFflZcwy+EiPUy/pw
6SujalpInnIy9WtzqhtGr1SbQL/cIQJbE/Cc/NPqtViQDDpzNjaMXLE6iIIjlyNi
/CZc+Cm5hMCCnxHKYaTLIFqF6m197uqLpVWoNuVZRwhyCVRm2arcsvBTuEsrR4N+
TovHCypLCkUPp2ZtQoBKRPQ5KILYHk58IDP6q6Uo6SR4iP0keEnQKFxhCHF5MlFJ
NZLZ3VsBDWuhko75SmwEQeZkDP/+3mwT8uEihTd6MxdurkpzKPM=
=nHuS
-----END PGP SIGNATURE-----

--nextPart1559518.IcFyxG2UGy--

