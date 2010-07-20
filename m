Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Tue, 20 Jul 2010 19:16:03 +0200
References: <1279291156-5297-2-git-send-email-sven.eckelmann@gmx.de>
	<201007201028.12470.sven.eckelmann@gmx.de>
	<20100720.095928.113690788.davem@davemloft.net>
In-Reply-To: <20100720.095928.113690788.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4257754.bkKK8OoFys";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201007201919.31993.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] net: Add batman-adv meshing protocol
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, siwu@hrz.tu-chemnitz.de

--nextPart4257754.bkKK8OoFys
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

On Tuesday 20 July 2010 18:59:28 David Miller wrote:
> From: Sven Eckelmann <sven.eckelmann@gmx.de>
> Date: Tue, 20 Jul 2010 10:28:10 +0200
>=20
> > I would leave that to the original author of those functions.
>=20
> Whoever you leave it to, this needs to be fixed up before this
> code can be integrated.  So if those people are not active or
> don't have time, you very much should consider the reality that
> you might have to do these fixups yourself.

They are active and informed about it. I never wanted that you integrate it=
=20
right away, but asked for a review to get everything in shape for the real=
=20
move from staging to net.

Maybe there is a misunderstanding who I am. When you look at the MAINTAINER=
S=20
file than you will notice that my name doesn't appear. I just volunteered t=
o=20
keep the different branches in sync and submitted it for a review to you an=
d=20
netdev after a discussion with Marek Lindner. He is together with Simon=20
Wunderlich the real maintainer of the codebase.

I will stop here if you prefer not to talk with an intermediary. So Marek o=
r=20
Simon have to work directly with you.

thanks,
	Sven

--nextPart4257754.bkKK8OoFys
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMRdnbAAoJEF2HCgfBJntGnP0QAK+NIV+N5vCtciLlAK7Sf15C
jGRejgaR/zBEmxvwKzO+zMmhYSWwMfzQaamIzmm+jaJnohLuVoFfqZ0nO3WgkNvq
//5r/NfyK1I/1/RpNRDaxIeW2mnNvvu7HXhNXqKbG3qi6ZPFyxdXpC6dzy6hlZmG
lK1BVnEVpYjXYmbgsf+zACa+hpyYFhEgvYazAA9e0hWUoSlwwW1dH7P1bHFWE03n
YLmc19HTIz0o6jxUExm0GEjDKAj+giW3mGLhL9ka3B5qxcu4qN7qN2Y0A5bGjabd
+wPt18eoQUTolbGIidks3loMfLS/ykMzB6nsAA1JTCfpcklt3XdjF39CTAXrYAzA
ZFdVKIkFOKc5O25WJY5udLRKNO72h6wGwXFYuh1SS1kap71POjnOcnHt+TNQxebs
jp5RTeTEpCPAzW4+/oI+M2LxXVZzOxM2dLqLszr5o3V7FNAbJXwUe4yNiKJdN8jN
0Q+jCHf0gVTwQsL38PIdGF7DALcdD4rCr4hynWLz609kQe/FOr5eElw6x09YKUpA
yhiPida6iG6cwRUOTNNrcDdrm/eEEXBbgHHiRpYElKL8tafK3qTIOH8r35KjAIhQ
q1+0H8cVneXHCOp8kBXqv61e+AT/Bs0WwDE1QtEuHP/1P7hzeyUsHIOyngPB/lmu
4eZE2KJkPS+iqF5XT11+
=Mxtn
-----END PGP SIGNATURE-----

--nextPart4257754.bkKK8OoFys--
