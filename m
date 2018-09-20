Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 20 Sep 2018 08:37:07 +0200
Message-ID: <17473475.hfVQGVbU65@bentobox>
In-Reply-To: <CAA93jw70qSL-5w+bVr-BX40ay=7qK2XX5X6VPW=kk31VOiHEVA@mail.gmail.com>
References: <20180919123238.23742-1-sw@simonwunderlich.de>
 <20180919123238.23742-6-sw@simonwunderlich.de>
 <CAA93jw70qSL-5w+bVr-BX40ay=7qK2XX5X6VPW=kk31VOiHEVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8496795.8zSgYJXtOf";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] a dumb question about batman
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

--nextPart8496795.8zSgYJXtOf
Content-Type: multipart/mixed; boundary="nextPart1652330.y59fu75kVj"
Content-Transfer-Encoding: 7Bit

This is a multi-part message in MIME format.

--nextPart1652330.y59fu75kVj
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

[please avoid replying to a unrelated message when starting a new topic]

On Mittwoch, 19. September 2018 09:47:09 CEST Dave Taht wrote:
> What does the frame look like nowadays? Does it have an IP header?

Depends on what you are talking about. batman-adv is still raw ethernet. The 
encapsulated traffic ("tunnelled traffic) is

1. ethernet header
2. batman-adv header
3. encapsulated ethernet header
4. the rest (IP, ...)

I have attached some small examples which you can open with wireshark. I think 
the v15 support was added in 2014 - so you should be able to dissect these 
packets with the wireshark version from a recent Linux distribution.

And the (stagnating) batmand uses IPv4 for the announcements. And it only 
modifies IPv4 routing tables. For IPv4+IPv6 support, you have to check out 
bmx.

Kind regards,
	Sven
--nextPart1652330.y59fu75kVj
Content-Disposition: attachment; filename="batadv-v15.tar.xz"
Content-Transfer-Encoding: base64
Content-Type: application/x-xz-compressed-tar; name="batadv-v15.tar.xz"

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


--nextPart1652330.y59fu75kVj
Content-Disposition: attachment; filename="batmand.tar.xz"
Content-Transfer-Encoding: base64
Content-Type: application/x-xz-compressed-tar; name="batmand.tar.xz"

/Td6WFoAAATm1rRGAgAhARwAAAAQz1jM4Cf/AkddADEYSu+NAGVYN9gIGZzqK0EA4XpaDKc+uHB0
EUeNmLq2DRrs8VCS/R71V0em9vDoVarFM5FXvjif/2NstV25icfXPqhCOwS9627lhvCg7TuF4HFO
TbZ4QQY37z5kBXbvuWgfbbdjmAzahd798B4tqm+wSWgJg0yIhVnDCQyAczwBhwEBoxvL7rCPYOAz
89MNQpQ/aH1uyG8dzs2TOHmxQNbaaJf+YPinJNKM6azcPZVfANghGMKM7HY1AYCN/vNZpNrPE6Fk
/7fr/62+UMTTp7AVp1PC7Xvj25cUv1vqYIzfZPMDPOawmYDWkGdagrOe0AjPj5qkwECwuCjTiHuc
OhGQtZ5t+LCBz8fRRm+P4sozE8JChTyOYdTBwymajSela9YYdZtu/y1OEaWLqBSH3PajJRi2JasB
uJqOQ6S8AUD8JtWA6Oe62ukZU9u6PdXD9JE5ooSrN0HWaNkTfkNL0875BK7KOdROImijWK71MuMy
P7uP6Q9WuEO+Diqwt7vyTbUbeopWPSzHR0u+DGQ/rEjj1GRVcvas1Dg8U1rQV2f5U7wfuWYrSHoM
Df/Gnsk6avztkWYaGD39SLtKWdljn+PEdatgGBcpfu3yQSilYcKX/Ga9AEY9zW4VGSv+e4my4SK7
PaWlKKJvatJ5Q3OHvuzTF3nL6VcEpwJlKZyOkfH5kI6D5SYWfBQw9gFXy6liLh3g9JKQCQ/3kAly
exInB/J/l/8aJgPNVm2HlUl6LXfQ9sUQpUP3V3iUTfbSgN4zjXOjdczaggAAABXwfnS6Ge1eAAHj
BIBQAAC6g+AnscRn+wIAAAAABFla


--nextPart1652330.y59fu75kVj--

--nextPart8496795.8zSgYJXtOf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlujQBMACgkQXYcKB8Em
e0ZlwBAAn6h2BLVBL2BNfYmrGiREHgX9Xxyj/fnLNIpq5JyoOtNPLGXYJsRVJhLf
7Qf5QD5KmxMUfNo/dtOWGaVc9rzxxvBnPqsPyeyz2n8pAlai4cFtRxgXLrj+A0Xu
2E6oDymxnlqi3l1/IR+gjXbWGM92VfOedMZiWkTmnB53nF9O7zBisyf9RfM8KNx8
6D8FVp1owdxSwNra2kiV7TL4gQsgNrdZgL521ZhC0iwSpWyvspXJ3e4LYqFaYBth
Sjyya+a/dtrckozblkb6MCHwDPezAApC7IcaatomJFS/TiKO8WkDy37ZjX6peuxy
70d/HeIQQDtJDrVqh5xpnFHGCxX0Map7+qFstdBhszPkQnnz1Fwt8isobwuDMgtE
hFjkvHWpShkh6lV09Nf4pvAK65akdt9Fvk3aV1iAlKB8lmltSePvDw/fX2I4IqT1
awPRVlE3fxhrt59jnO31nMXP22RmBosRamSqjwLVL1iYa0FV0x7nLmnn5WDH1Skv
RBEZubVub5NY2+RU51rQEHMgWkYZ7wjk/AS2uPuA0jhJORtRLgkpqXM/4qfkszXb
mp9IQP+VHNHyxQ5HUCongqLv4nJnHXqezb8NOKeQrR1d81voZ2l8c3IOGwjQ9k+L
4cu+l83ifkqneMOgRra8w8/zsc+4SeQL6QHEvk8pLEWQPD2DhyM=
=78VU
-----END PGP SIGNATURE-----

--nextPart8496795.8zSgYJXtOf--

