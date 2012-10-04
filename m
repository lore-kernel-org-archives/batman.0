Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 04 Oct 2012 18:32:45 +0200
Message-ID: <1934520.YmdkrNAjpg@bentobox>
In-Reply-To: <16662960.TUJbz1tKdU@bentobox>
References: <CA+h5VgqB82br1u9Cdg423Eedd8m23wMO=PWo86q+TTAXVtuy8Q@mail.gmail.com>
 <16662960.TUJbz1tKdU@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2388137.mZrRHOCG7q";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] mac address from packet
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
Cc: Dominic Follett-Smith <dominicfollett@gmail.com>


--nextPart2388137.mZrRHOCG7q
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 04 October 2012 18:30:25 Sven Eckelmann wrote:
> On Thursday 04 October 2012 18:21:02 Dominic Follett-Smith wrote:
> > Hi,
> > 
> > is there a way to get the mac address of the station that sent the
> > bat_packet? We want to get hold of parameters such as signal strength. We
> > could do this by using the radiotap header, or by looking at the iw
> > station
> > dump of a neighbour. The second option requires the use of the mac
> > address.
> 
> Hm? What is a bat_packet? And the sender is encoded in the ethernet mac
> header before any batman-adv header fields.

Ok, next time please write that you are speaking about batmand. But it is 
still the same. The mac is part of the ethernet mac header at the beginning of 
the frame.

Kind regards,
	Sven
--nextPart2388137.mZrRHOCG7q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJQbbotAAoJEF2HCgfBJntGDBIQANak/OQCRGPbVedbV0HT2nVm
6gL9uZjCzMABmieocpJnZzA2MJkz1Q+tcvHcvlsoRJiR8hAiYBoktsTxbxhkFctE
GPkDl81M3cnZ8/MOy1Gumel1UJ7dY6gGMzDcKbBRaKByoSxz7XQ3jjA2amhMtuO4
k3Fm6Zq0To6zyk7N98uqJIdZ0Ws5aVTCGRvBK5yViGoBhD9f2gVuIR/v+vhfnp80
uBJNvZsN+bYDxk1f8xfV44ORH/hrgAXPlgnWj+iYdF5sZyhcMVfA2N0rTW0Rp8su
yv9olB3DeG3abMLNDbm8tnkxYsx50qXCOH2oNYWsvP/gKl9zv9ryzGWVK60uOB0u
kDjoRDsKuX8gcZcLiuw7bvKzrkacUuKngHhInINEGvp0x/c8I/0v0YtUmcrP/x/Y
WFyVXXbALqMuNlhpn6K7bIwqDMFoH4X5Plg3wwgTCcnB9f7NxmSuIEr3CezbAoiw
yiss0/U6TVJKKnQNO8xrBpRWZQR5ZFg1RXcsQVcbgPUk7rzabTHULKvjd3OF7KJY
85v0PVLkr/J7FneVoSlS1h8mvaCYw6+EP9yxOz2pACIzFJtno2vGt14W/drMorDY
VzPTQ1Ez9WK8bueMoeRNrASx3Z7s1/4v2evHzoBsftv4jY/xcofm6+k4U7O17x3r
b1S3qBWGNyjTzf0f98JT
=a+u9
-----END PGP SIGNATURE-----

--nextPart2388137.mZrRHOCG7q--

