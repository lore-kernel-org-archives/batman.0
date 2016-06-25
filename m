Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 25 Jun 2016 12:04:51 +0200
Message-ID: <1889511.W6T9spajgp@sven-edge>
In-Reply-To: <1465557064-24406-3-git-send-email-apape@phoenixcontact.com>
References: <1465557064-24406-1-git-send-email-apape@phoenixcontact.com>
 <1465557064-24406-3-git-send-email-apape@phoenixcontact.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1750005.FPuxttRndY";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v5 2/6] batman-adv: speed up dat by
	snooping received ip traffic
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
Cc: mareklindner@neomailbox.ch

--nextPart1750005.FPuxttRndY
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 10 June 2016 13:11:00 Andreas Pape wrote:
> Speeding up dat address lookup is achieved by snooping all incoming ip
> traffic. This especially increases the propability in bla setups that
> a gateway into a common backbone network already has a fitting dat entry
> to answer incoming ARP requests directly coming from the backbone
> network thus further reducing ARP traffic in the mesh.
> 
> Signed-off-by: Andreas Pape <apape@phoenixcontact.com>
> ---

Marking this as rejected in patchwork due to the conceptual problems pointed 
out by Matthias + Linus [1].

@Marek, I hope this helps to reduce the number of patches you have to go 
through in patchwork. But please feel free to change it back when you think 
differently about it.

Kind regards,
	Sven

[1] https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2016-June/015738.html

--nextPart1750005.FPuxttRndY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXbldDAAoJEF2HCgfBJntGfOcQAIl++NTsm0QRbG0/qq2iRd2S
mMhF7LGJTg0L9NOsbezFhCEMKA2qq7/qA7/3IaEF8lYB5KzptcM4Z7q92gAO9Id4
jsBPRJGbM7fEy2F8CHQDisqNRHWC2QtxrdiZy3VOTL7gAt1BwXWtyY5yXubDXpSm
1rJCjMrNjNp3fqePaPvuDJvNmnT80u2gnjXKEbHzugmCTdGDfzqWh5VuAqDLJbRw
UvQG5vig/EOq4MRowG8Ov6YzMnJVcW3hCL7KC6Kwc3x6O+ogyvuCOqvH5jlNGI9c
f9IWZvcOSd1eb3RN+RRlOwrNvSN1l9ze3C2/qUxrAGSRd1TfGRtq4UDeotmIsqA7
zpv5mRArpS1ZaAY/MvpLeuS7yPms7QPrkCfKhVkkv34QDQWmmmcaHTISblgT8Llr
eXUbsB+LLBFZieZjCBxsiOOj9+i/ah69PG19q+dwLwVeV24D8xrmwKSzMBf5MCbt
VfUsjisvFuJIUQeFQwzURPYNfL5sJlcYRUil4KWXTBljT8phlWR4P4uovOwps+fF
anoriNRBNYm4Hseqckh+LAgbEARcoqo2hC5xGSVTyRjsYdCYuAlTEtTnENVXt5hY
zr8cjq5JiosteVWcYjmUSDFOiybdDqh7qZXP5izLpCOYDvEYksAnNcH8Mnj2e8Wx
AzRa07KwPzc+OxRLB3r1
=J4ZP
-----END PGP SIGNATURE-----

--nextPart1750005.FPuxttRndY--

