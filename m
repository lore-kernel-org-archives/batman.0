Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH] batman-adv: Remove redundant 'flush_workqueue()' calls
Date: Tue, 11 Jan 2022 08:39:28 +0100
Message-ID: <2319423.e3pCTlsKIc@ripper>
In-Reply-To: 
 <2c2454cd728f427cada2c24cdb1ef2609dec5efc.1641850318.git.christophe.jaillet@wanadoo.fr>
References: 
 <2c2454cd728f427cada2c24cdb1ef2609dec5efc.1641850318.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart9182710.2x64NcNEKf";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <a@unstable.cc>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org

 
--nextPart9182710.2x64NcNEKf
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <a@unstable.cc>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org
Subject: Re: [PATCH] batman-adv: Remove redundant 'flush_workqueue()' calls
Date: Tue, 11 Jan 2022 08:39:28 +0100
Message-ID: <2319423.e3pCTlsKIc@ripper>
In-Reply-To: <2c2454cd728f427cada2c24cdb1ef2609dec5efc.1641850318.git.christophe.jaillet@wanadoo.fr>
References: <2c2454cd728f427cada2c24cdb1ef2609dec5efc.1641850318.git.christophe.jaillet@wanadoo.fr>

On Monday, 10 January 2022 22:32:27 CET Christophe JAILLET wrote:
> 'destroy_workqueue()' already drains the queue before destroying it, so
> there is no need to flush it explicitly.
> 
> Remove the redundant 'flush_workqueue()' calls.

Thanks, it was now applied.

Kind regards,
	Sven
--nextPart9182710.2x64NcNEKf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmHdNDAACgkQXYcKB8Em
e0YCVw/9GGMIG69XboEwP5yhE4wjK+9i0YJpqwircVrS4cArq5CDTuh5P0d5iDg9
kxify02fI9/cmH56Qo569usjYj9Q8bEzbfsncKjztQi3oS2fw0Axub47Z1CPuuTR
BL80s02jBLLNj2ssznucgSmcE2P1RMJ+kc4Xj2SLMiDS3k/o5V3sNS3u/jkCbo9p
z4Hf20BJdNeIpyxn9lXbNDJ9n0vMG74Bkowm+p+p03zxnOy9Xx2tZUyn+FKnewqe
gEkJ9gPPkKsVxrMnXPJmQ6rrYyrAzW6e9v0H7udQ/r7hEt1OxhWQ4cGtb+Dpn3Bz
vwbn3eECzo7gn+UX1vlFkuWTOzgPnekO99C4DC4eTg05TTzBkHlIBbsYpGyisLdL
yVjppq883QNqcwShCiJoRQ9jcCfJoMh2+6PlXaa+i3P9LVqOUQqEB6BGz2+KL9wd
Rei2i/48S8wH7ZPrHU7cifVV7aJkBPwEEKrfNwcQoSUguETnVu20blRqZaeBYfHA
aEwkI6cLLUb7kgNgC+dBVSz/eveXM1xqyIM170CUZ6TxSL56ldTYSFMGyyJTeFm2
b3Sxu+5Kia39DYYwW0nJipUD1eP9b64dfgy5gCEBTqLMVsTbbGf08CaOr+lmqZkz
NZLMkWKfaOFCMhyAGOhGV0rxNbQcgCoOh4wXFrKWnXYhBoSjYbI=
=94G+
-----END PGP SIGNATURE-----

--nextPart9182710.2x64NcNEKf--


