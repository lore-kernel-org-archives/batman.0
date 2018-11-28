Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 28 Nov 2018 08:29:14 +0100
Message-ID: <1732194.WAl8XlAdAA@bentobox>
In-Reply-To: <bd7bec9a-c380-aa64-3cdd-e3cb63d0394a@r.z11.de>
References: <50dd4215-efd3-2b89-874f-bbf7330bf37a@r.z11.de>
 <bd7bec9a-c380-aa64-3cdd-e3cb63d0394a@r.z11.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart30270288.0bVaGKrfVv";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] batctl: Add section to explain gateway selection
 class for BATMAN_V
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
Cc: Ruben Barkow <github@r.z11.de>

--nextPart30270288.0bVaGKrfVv
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Dienstag, 27. November 2018 15:00:39 CET Ruben Barkow wrote:
> As mentioned here: https://www.open-mesh.org/issues/366#note-8

Applied as 26b483ce543e [1]. Thanks for taking care of the wiki entry and the 
manpage.

Please send it next time as inline patch [2]. I had to manually adjust the 
commit message because of that. Otherwise it would have looked like this:

    batctl: Add section to explain gateway selection class for BATMAN_V
    
    As mentioned here: https://www.open-mesh.org/issues/366#note-8
    
    I added a fix to the formatting, so this is the final patch:
    
    Signed-off-by: Ruben Barkow <github@r.z11.de>
    Acked-by: Antonio Quartulli <a@unstable.cc>
    
    >From c3561b556c57546b2a089b830bd78ada7cd46218 Mon Sep 17 00:00:00 2001
    From: rubo77 <github@r.z11.de>
    Date: Tue, 27 Nov 2018 13:40:29 +0100
    Subject: [PATCH] batctl: Add section to explain gateway selection class for
     BATMAN_V
    
    Signed-off-by: Ruben Barkow <github@r.z11.de>
    Signed-off-by: Sven Eckelmann <sven@narfation.org>

Kind regards,
	Sven


[1] https://git.open-mesh.org/batctl.git/commit/26b483ce543e5b4bf6869a66c0ef28ef7a00e367
[2] https://www.kernel.org/doc/html/v4.19/process/email-clients.html
--nextPart30270288.0bVaGKrfVv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlv+Q8oACgkQXYcKB8Em
e0atuxAAuaa+fGUFjyDN7G9ZsIcRavi8FIvCjItpNGyixGd1EFBE5JPttIKS4Ept
x1a+k9MemjcpuwlS6DwdHhVkK2302KKE6+J7nWFGH7ntuUFdmI3ZgEbHhOqo2hyH
0lOH0qwGh0DU5Yn9EQej0QNtRcU9fw8QZlZjtjsS6xyjwNFzZmVlTltChCy9DU8u
r7N6SSUecYwX6KoTlJ90JinEgzdSzq8RKqIiTlk64jhrkEy8Npe8ZunHMkGlTXzP
doOX8mcNXwDhWfgu6aeoDinprZn6lNhKdetkKjORxOsSZ9IxARxeS9hnR7Mlrfaq
nlU7WKaUIHcn9OvooJzEgDFrM/5a52OYh/iteZsa7hkQBIXU6c+Mvt5L6zn+boa0
Th/aq+YYOVgAPCL+pmmcRcFcVgl+NGGPK/6pPE4DMBKdluP3sqvJHpnQsHoMM30D
4FtfzTbIAKhyJiXtUZOqempSUuGeOtUSiIMNdyJ4Enn/AnQ6DZmOhJPWHMwlXUGy
OxEKenr6StHto/uvex0g84XgpVZiRN2aToRPcVL9Gkb04T2rg5WqBbJDkzrlf8Bb
QAT2y3WiOw1s4nfwfHevdM9viS6atIV7/j9ERPYE5cmRLydB21Up2ZxH/slFmsAJ
IvaSN9eOeY8KPZuSqfSt24SpekjeKf1EDK/zLkug5jLr6bPBJhA=
=d1vg
-----END PGP SIGNATURE-----

--nextPart30270288.0bVaGKrfVv--

