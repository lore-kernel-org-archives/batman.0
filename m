Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 25 Nov 2011 09:50:41 +0100
Message-ID: <1462592.m5CKka3Otj@sven-laptop.home.narfation.org>
In-Reply-To: <201111250908.48180.lindner_marek@yahoo.de>
References: <1322044544-15153-1-git-send-email-ordex@autistici.org>
	<201111250908.48180.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1963323.TkPCovYzH8";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: add biggest_unsigned_int(x)
	macro
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
Cc: Marek Lindner <lindner_marek@yahoo.de>


--nextPart1963323.TkPCovYzH8
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="iso-8859-15"

On Friday 25 November 2011 09:08:47 Marek Lindner wrote:
[...]
> > +/* Returns the biggest unsigned integer with the sizeof x */
> > +#define biggest_unsigned_int(x) (~(x)0)
> > +
> 
> The final conclusion of the IRC discussion might have escaped me but wasn't
> there supposed to be a cast somewhere ?

There is a cast. The part "(x)" of "(~(x)0)" is the cast. And I don't think 
that there was a final conclusion. I am not really convinced that this should 
be part of batman-adv. Just look at include/linux/kernel.h for similar 
functionality (but with predefined types). Maybe this would be the correct 
position for such a macro? (I don't know it... just thinking out loud).

Kind regards,
	Sven
--nextPart1963323.TkPCovYzH8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJOz1bhAAoJEF2HCgfBJntGou4QANRojyKdVaFR8bc09qtU7pgg
/mJwOv9z8Ee9rqnWpsMQr8cHcVqbdH4g3XBX9jva1wJhR5i2RoOTNyOczzetRPPq
MM80CSw/F+ocUeFeuc9nJlqgi8N9qQW/nGgYL5CS7AeFj/8it0YL7jlLq8u6LeQo
9Ylci6a0Jw5ILa9wVPaoQBvL4hNBvyiNhURdNCBd2Su7v1HPFdzDikbVwmA2z+Fa
ROLWujY8q0fpatNWWZnKCTLWdZQh+L+8tbOFor9RWfJXqCp6y3Dim6XI+/4PqCYt
CeW23Re6nVBsYz9tRk65vHgNcpobpCYoxdSCOPMGuRelkcV4Du8by3exInAxvb1/
gO6uiWNVPrA898xf38NSgcOPGVfRWQGscdZq09qmxwVYoWXoTfd9xoHy/2OxhBdV
MH8vJ2WEtLgrT04q+h4tMlAtO81ipxa1tURcTX88do/bkMoQXTxT3EGZ5+QKfyeq
/F5rQ/O6rlJvQCKMPLR4pqqUV4TNNnczKZlqIjvVlTsZTRcwwmscW5vWf68ud6QM
TLaQ69yJm6AiMFusJfKFN4qcmK/6ux8xSLKG6lgjGRLNy+T/U76cmGmnK8nuwk2l
fSFN3KBAZz1XR+lTJcDSHy+wceLiRXlnoxk93Kj33JFsJRBY6FMm89Pn+dOYP2kT
u6sG9LNdtwL3NZQzpyDn
=SQ+O
-----END PGP SIGNATURE-----

--nextPart1963323.TkPCovYzH8--

