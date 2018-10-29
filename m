Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 29 Oct 2018 17:48:34 +0100
Message-ID: <17712655.F8A4oun0WA@sven-edge>
In-Reply-To: <98bb1f935c1da5ecdb978b7c95e243ec5c81f04a.camel@sdl.usu.edu>
References: <02ef01d466a6$f0c629f0$d2527dd0$@sina.com>
 <042f01d46c41$fe24ddd0$fa6e9970$@sina.com>
 <98bb1f935c1da5ecdb978b7c95e243ec5c81f04a.camel@sdl.usu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1935235.JuemjrhhlH";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] alfred and batadv-vis issue
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Jonathan Haws <jhaws@sdl.usu.edu>
Cc: "guohuizou2000@sina.com" <guohuizou2000@sina.com>, "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>

--nextPart1935235.JuemjrhhlH
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Montag, 29. Oktober 2018 17:07:26 CET Jonathan Haws wrote:
[...]
> One thing to note (and Sven, maybe you can tell me if this is
> expected): in my testing I found that alfred is getting into this
> ipv4_arp_request call for the local node as well, thus the very first
> ioctl() will fail with "No such device or address". Should there be a
> check for this being the local node and just discard it before making
> the check or is making the check all the time then discarding okay?

Uhm, this sounds extremely wrong to me. Why would you receive your own UDP 
packets (push_data, announce_master, status_txend) again in the first place? 
See netsock_own_address for the code which drops such packets in the main recv 
function - you should know it because you've tried to modify it for IPv4 
support.

But your memory initialization is completely broken and have to be fixed. 
Right now, you are just comparing uninitialized memory regions against each 
other.

Kind regards,
	Sven
--nextPart1935235.JuemjrhhlH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlvXOeIACgkQXYcKB8Em
e0ZuHw/9Hxj98EcW0f0GyOlfGOJ8R78cGjQiXHH4iLNzsVTJpMuEzX/2RDauyhY4
T2qxyxEzWXYyPNcM6zKC0+VsdeBugQLnLTncv/XpFPOCtOold5NCEvo1848PtF3q
3slYanAiMjSFXm6n9i8JL6yVlC7vorNpuE4QMtjW2LUwk1vhkZXwtulDeH/jwI3d
1vCCNcTf0NZEiXGpQ6dBA+Z6XxdInkm/OdHDHIRBvDUVDmfS+TLAwmk4a0/8Ewcx
aQezGGwNeNWDYDnwN1mri8Pq1FaFofGYxYcEojeL5GF+naf0yda9DQb8DdSwCpOP
lFni7JhfPpECj7wPa5f5MnQy9Ze+k82sB+5ZFUN4f3wN9ePi9vNy5IMFPifoBXk4
TWmN/FvFKzeymwGd5vyl1hU8c9iczAYwMsc0/JRJyFbutfsh/7O6OfuEgYZGoCPA
4aBP8bOBB3r0BUEL2k4Qp/+GTzdbVWGw4Y/3DpiIuA7TtkrhAE6ryGWQLSzwG6q2
t2SeqEEMz/+tdXNzJfwyuIJ3HS1aXm1bIQCl+ZOQs79wriATZJkeLp/EaRZPhWVU
GCAk6FCYGJfM5cKnhBkOpOxpsVpUwOO9n5lagTvvzUzdG4kS3W1AXWNcbmwA4Xh4
k32O4CfWg98QTdrKIgT8tUtG4UFZs7c8ZL+6d43v41vk92xr7lk=
=xxkk
-----END PGP SIGNATURE-----

--nextPart1935235.JuemjrhhlH--



