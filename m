Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 18 Oct 2018 08:22:39 +0200
Message-ID: <2254141.JEhYi27MYC@bentobox>
In-Reply-To: <02ef01d466a6$f0c629f0$d2527dd0$@sina.com>
References: <02ef01d466a6$f0c629f0$d2527dd0$@sina.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8523421.5cif4EcB8V";
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
Cc: b.a.t.m.a.n@lists.open-mesh.org, gary <guohuizou2000@sina.com>

--nextPart8523421.5cif4EcB8V
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Donnerstag, 18. Oktober 2018 13:53:44 CEST gary wrote:
> I setup a testbed like this.  (BBN = backbone node)
> 
> Switch ---------->BBN1 --------------->MP1
>         |
> 		------->BBN2---------------->MP2
> 
> MP1 and MP2 may select BBN1 or BBN2 as gateway. 
> On both MP1 and MP2, I enable Alfred and batadv-vis as follows:
> alfred -i br0 -4 224.0.0.1 -m &
> batadv-vis -i bat0 -s

Looks like you are using the experimental IPv4 support which I don't want to 
actively support. So Jonathan Haws should take care of this.

> 
> when I run batadv-vis again on MP1, I can't get the info from MP2. 
> If I ping the ip address of MP2 from MP1, MP1 will get MP2's mac address by arp.
> And then I run batadv-vis again, I can get the data from MP2 now.
> 
> Is there any configure or method to get MP2's info without ping test?

Kind regards,
	Sven
--nextPart8523421.5cif4EcB8V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlvIJq8ACgkQXYcKB8Em
e0bAbRAAljoDP2nAeA8JimaSf6Y1SN9qO1bNbOrve3cqOtG+VVf5RrfGImbLPBIC
afvOpWoanEeCSbYFC/H+6maVS+hhXG1HZwv+nULyWRadNBudqZ+pIGOVO3Dhtwcv
pKpTI7r42prFj7p9G6mcSpyanHIqUT9f5Z1SvGD8Bp7nA7uMlfkL1S2iif1Z4U1H
vMM6moimXYM9QE/BQQxVzQ/JeUAeGG/Gd7suqYBYQK/qQ8fJUBqLiY4/+AY/KmA6
53mt2AsWfXOfTjHKijLCf8pHL/c/Xl2G2aDVHNinJ5PflFsZbvUfR2yREn/anxOd
YiFOjd3n3P7gv5kVVPr1aXDwfnPSZzBNYiN6qG0Suy9ftaLfsvJCfqtTGDh96+o3
5M0X0xKtjQgK6ln+O3/agdqd9vD5aPRUhoJKKfOhi/EVIXcfxqjKPKhb/ZcK4nq1
snCU4lDLEm0jpFXbtIATZYoJ67ve0V/d/YgwrhdyRn0QiYQII8MNWFLn10TVHY1g
jV72HPXnNI7LiyEwVLH8uXYkWFNFquAVudhfUxHV3YK7ahR8SF3iZAdyFvFRIujf
NHWOFTo4Q57RAvjS7jIV7zHu+PLwpZz/PFuYjW0tkyd3+W0aR0f3g5RmGTiAeLB1
jrDhkEsgVGTRDZUnY6q2cclUCulu2EGsD44litT1t29chnrSveg=
=r8Nm
-----END PGP SIGNATURE-----

--nextPart8523421.5cif4EcB8V--

