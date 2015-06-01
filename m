Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 01 Jun 2015 19:56:10 +0200
Message-ID: <3154893.LhzU0btcuo@prime>
In-Reply-To: <1433072160-3260-1-git-send-email-sven@narfation.org>
References: <1433072160-3260-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2401668.Dz6xNyv9jV";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/6] alfred: Reduce MAX_PAYLOAD by the
	size of the UDP header
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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


--nextPart2401668.Dz6xNyv9jV
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Sunday 31 May 2015 13:35:55 Sven Eckelmann wrote:
> The len field in the UDP header is 16 bit long. It can therefore store a
> value of up to (2 ** 16 - 1). This value is currently used for MAX_PAYLOAD.
> But the UDP len field not only stores the payload length but also the udp
> header itself. Thus the length of MAX_PAYLOAD has to be reduced by the
> size of udphdr to make sure that the payload can still be sent.
> 
> Reported-by: Hans-Werner Hilse <hwhilse@gmail.com>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Applied the whole series with the alternative wording for Patch 2.

Thanks!
    Simon
--nextPart2401668.Dz6xNyv9jV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlVsnL4ACgkQrzg/fFk7axaifQCg4gWcQJn6vjVQIRubgWSSMe9U
qDIAn3c+eEZhwm+f1vQKDAmVC/oSdNZq
=SauC
-----END PGP SIGNATURE-----

--nextPart2401668.Dz6xNyv9jV--

