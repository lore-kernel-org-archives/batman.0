Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 7 Mar 2011 10:01:36 +0100
References: <1299328122-21468-1-git-send-email-sven@narfation.org>
	<20110306.181432.104062354.davem@davemloft.net>
In-Reply-To: <20110306.181432.104062354.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2761221.4oCbEjV3Ee";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201103071001.39111.sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] pull request: batman-adv 2011-03-05
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
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

--nextPart2761221.4oCbEjV3Ee
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

On Monday 07 March 2011 03:14:32 David Miller wrote:
> Can you like sync with me when you have less than 20+ patches queued
> up?
>=20
> It's too much at once to reasonably review, and makes regressions take
> longer to bisect when people hit them.

I'll try. The problem is that most of it is one work package (the removal o=
f=20
orig_hash) which I got in this amount of patches.

What do you think about another pull request which only has some of the=20
cleanup/fixes and leave the rest for the time after 2.6.39-rc1 - so it may =
get=20
into 2.6.40?

Best regards,
	Sven

--nextPart2761221.4oCbEjV3Ee
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJNdJ7xAAoJEF2HCgfBJntGPqcQAJlA9kI1b2V42Go3Oha8FS2P
tMEXBpxWx7dP1hyEFTlkwQ/JqUPrVcSUNbr5i21st0SPJuYcMFFlY+umB8C7PKeX
RllJ2dnKZnMe7XeugfNbTy74wbafDSO+SAPr7+Dg2985S4pBozoONg/EwygrQ5hs
EWbUWenaWbxYleJOcGSRSaki4Bdd8PsTGBUC3A3hHH7q8L4/1knxck8TTNz3lt+q
E0Cmh01C1fU53KmEL4iTua++4JxaTiHznO1WEEmzsBqRbYLZeCuCeEYQ/RQj6d7C
uxZRXc+IAQep8z4r5W/OBt2iGjIzyzx2ld1N1/jILNa8ohSjCY+PvWPk7JniYlfe
Wc9Tb6hBbChzhPIxWop/PJoIJxJmWYBseJgzeQn8pwE8CHI4VhH00GlqGSQKJhmk
gWxikJmvSjP+RGuaVGG/rXnKH+a3nIMJ9xjFhHzNiezbnH5LjDnL7Il0mHtXhhL2
ynE8lr/yzMy5NSiQ1uiF/r8VpoR+IQNDGeD2xEZh81R2xX7CahJr4+nAyy0uCZH5
ko5ismzFJLUvxTxqxkJmB27XW6qHFJeWzXTGETsY47++HKwQ1TFqhmX2mPcN26CQ
FB/UNvGx2O4ERxaW/kTrPLXQc1bfNEcpUDN2VjJwzQcchqsjULPULAGmEkYIjfqN
xGV0I8MUJdCOBH3lYw8R
=C431
-----END PGP SIGNATURE-----

--nextPart2761221.4oCbEjV3Ee--
