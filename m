Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 07 Dec 2011 08:20:44 +0100
Message-ID: <17412563.ZlIdMgf0hc@sven-laptop.home.narfation.org>
In-Reply-To: <201112062053.53909.onelektra@gmx.net>
References: <1323197832-1791-1-git-send-email-sven@narfation.org>
	<201112062053.53909.onelektra@gmx.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3951456.qBW26Na3qy";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] [PATCH] batmand: Don't override CPPFLAGS set by
	user
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org


--nextPart3951456.qBW26Na3qy
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Tuesday 06 December 2011 20:53:53 elektra wrote:
> > Users or build servers may want to enable preprocessor specific options
> > 
> >  like -D_FORTIFY_SOURCE=2 that are usually placed in CPPFLAGS. The
> >  batmand makefile should not override these options to add own
> >  preprocessor variables.
> > 
> > Signed-off-by: Sven Eckelmann <sven@narfation.org>
> 
> Applied in 9cd7382.

It would be nice not to remove my authorship in git. It is enough to just save
the mail in a textfile (mbox) and run `git am patch123.mbox` or `git am -s
patch123.mbox` (this adds your Signed-off-by after my Signed-of-by). Now it
looks [1] like you are the author and committer of the patch.... but you
should only be the committer.

Kind regards,
	Sven

[1] http://git.open-mesh.org/?p=batmand.git;a=commitdiff;h=9cd7382f815fbebe25381d5ad5da4cd5074f20cc
--nextPart3951456.qBW26Na3qy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJO3xPMAAoJEF2HCgfBJntGNW4QAJw9662SVx3AR3boz0MsycPk
cn1NywtwYNC14Hgtdh4/yHJUnTZXwzLiHMZmCq2y0k4AlL9sgadHhTTsgzMe3a9+
pdrWCrfxFU8Hjz8r2DadsCFXhn/fwmxzhwWk8+W0ij5PSVQnCfd1C4J1IDSi1iob
dgXKnQh+5vltJxwiGwsvZphMusChA2ixjRqLzHWSlngqdd3WzZhsMM/sOP05mVs7
FbBmd8wQbVN1wdOdFApaOWODdMCtPwpZcjPd0N+G57ID0WV10E34+FuQAxwg+XlU
AT4n4JSQ1wNfkjaufvIQdjlYrjOgH4DSzAyAIb3+gHjXiLi7EI7ekXIO091Drk4I
zAQPXEg+P8+BJBjCbDOgR7fdMS9IlWrPDAYpHpGD8McbDna/p/NPalkalTXDc0Hc
Z2phdZ/mE7Qgs5jlLBEoCGxtMrR1LU5kzfbxKOLTC5EMBZPcXrATwtFbdpq734Q+
NUDjcaO6paiO6GONGbbiDfiy50LDpKO51+LTmEq/qpY4LO49C2lg1h0SGuOCdkcf
spOqQNlysR+RYWj3HEdTR2xDScUgLU7m29v8YpP6Njyvlquajw8Uw/6rG5/wJSIS
gukAa29//lEI7JFw12lqpo4Ie8bhdwYxIX/GoTvBmr4Im//UMYk3trAZ7W5vEkZ2
Q4Kegm169WAEbEWUiq2b
=dpJz
-----END PGP SIGNATURE-----

--nextPart3951456.qBW26Na3qy--

