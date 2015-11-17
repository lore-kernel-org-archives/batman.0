Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 17 Nov 2015 09:15:30 +0800
Message-ID: <2931985.8ZHTxnqmTu@voltaire>
In-Reply-To: <CAJuY50zf45s0Tst+2R4NtciE22kRqONJUUJAADA_7TvMH47XdQ@mail.gmail.com>
References: <CAJuY50zf45s0Tst+2R4NtciE22kRqONJUUJAADA_7TvMH47XdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart65806959.bQ52QlsHFq";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Classes and purposed classes (problem to solve)
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

--nextPart65806959.bQ52QlsHFq
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, November 16, 2015 23:00:59 3zl Trizonelabs wrote:
> in cases of gateway-router instabilites (short brownouts / blackouts )
>  which we have alot with thunderstorms, it would be helpful if some
> other control instance could block the gateway to be used inside the
> batman-adv routing aside from the gateway anouncing itself.

Why does it matter how long the gateway is out ? What is the advantage of 
doing long blackouts via the gateway announcement and short blackouts on the 
client ? The clients have to switch their gateway either way.


> Is there any idea how to implement some kind of  'control instance'
> for the batman-adv routing ?

That depends on your definition of 'control instance'. From a high level 
perspective how should it work ?


> That also would help to achive some dynamic routing to gateways by
> adjusting the qualtiy of those in respect L3 parameters.

This sentence does not compile. Do you mind explaining what you have in mind ?

Cheers,
Marek

--nextPart65806959.bQ52QlsHFq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWSn+yAAoJEFNVTo/uthzA/bUH/j+y9g5l1rl7R83dgX+0WtTG
Z4EhtvFQN2qkF/wsU3duM7wUcO7Bv2jIjBOxMnaNWR6+iMfkYXUHQw5MxTcSm4Cj
007XCetkTMlthX5Oh53A4rkI7qkyT1JqUSQd3aDL14kI+j27LyXv2NS1NkejUDbN
+I8Ta7MaXV52UDrFAfS3TeZPtDKN+gFrS8sHhrbM22rJZ4VGrPNgO27FhBIUVtIy
s8fNGpehsNxQj4iIF7SYhYanzsfRIBsrXtwDWgIGN2l8ntX1IUIfzp8brhAvXobY
OBUAIWYydLJljc3hqR73Ul3cfkkcT6bUfeJZmYIp6dvDSTrr+Lq0yP5EsNk/TlE=
=WVN2
-----END PGP SIGNATURE-----

--nextPart65806959.bQ52QlsHFq--

