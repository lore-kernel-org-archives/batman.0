Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 14 Jun 2018 13:20:17 +0200
Message-ID: <7318287.kp0SrnPS43@bentobox>
In-Reply-To: <1528974316.26847.0.camel@sipsolutions.net>
References: <1528971137-432-1-git-send-email-omer.efrat@tandemg.com>
 <1567584.jbsRn7ofiA@bentobox> <1528974316.26847.0.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart12333062.RVHHb7DxTn";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 3/5] batman: use BIT_ULL for
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
To: Johannes Berg <johannes@sipsolutions.net>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Omer Efrat <omer.efrat@tandemg.com>, netdev@vger.kernel.org, linux-wireless@vger.kernel.org

--nextPart12333062.RVHHb7DxTn
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Donnerstag, 14. Juni 2018 13:05:16 CEST Johannes Berg wrote:
[...]
> > in commit 739960f128e5 ("cfg80211/nl80211: Add support for 
> > NL80211_STA_INFO_RX_DURATION")
> 
> Yeah, which actually means this patch isn't needed?
> 
> BIT(NL80211_STA_INFO_EXPECTED_THROUGHPUT) is fine since
> NL80211_STA_INFO_EXPECTED_THROUGHPUT is actually == 27.

Hadn't verified this before but this would make sense. So no fixes here - just 
some "cleanup" patch to make these tests more consistent. Thanks for checking.

@Omer: If you want it as cleanup patch then make it clear in the patch that 
the warning you've showed here is not actually not something which you will 
see in in the modified code.

Kind regards,
	Sven
--nextPart12333062.RVHHb7DxTn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlsiT3EACgkQXYcKB8Em
e0Yw5g//Y9BvteNqSuGyeGLS37NzzUcYYp1zxqyECjxwo9X01HxakgH4warxqL1N
DCaIjXKRWLoFgd33As/dD7D38LSOIcyWp6Jd1Caku2GnAb3tt2lHwOsj5890hUJu
OkQ+w3OaVQgTTRUrKhJ8BlEikClyC344mxca5wZdE3v7XnnCl7a/nn3mD9V0BGUI
v4L9pfDK9L2wPkaPSUIKxTrRzxQXOBPhVNRUiPcOoKipA7h4PwMcWxFmf5gqnYkN
JSJz1Xv3wWcz21nT3xIjdC2grhYlLQkA8Q7x8ENU7xrC3vPTQv07CFnSIhMFJz5O
bHpsUXKucMBGb7Hev4w68D2I2PTIAHpQ65Z1qRqOk6jvfGjwHaq5qoQ6jiScpU20
E1/1pjp+2xEwj2KoETfdVd988weez/TeYMkuuNgH9Nb8Wj6nLlznbTNVjKb+RS8b
g1zJqtZjYKSP8uOOS4b3GTFa3F4dKf+4OjddHEVC2BExY3nMT6qQ5smY4lwVKtK8
q2Ez8wwiNKfN2OC3SdGHCXbUYHt+pOOtV9Yrr9rYNxyXfCGhUtvI0TNcqMoYa3vb
KqdmRwmslerdYw3ih5PnTrtRQDYwKnUwEyTR3+eBS1r/Kyuw1Apa/EPgMd3oV3zd
fG6JEWeSZIlMoP/AsjCqJA162XoKja8rJZawCq+vZuWxjzZMS9Y=
=kTAX
-----END PGP SIGNATURE-----

--nextPart12333062.RVHHb7DxTn--

