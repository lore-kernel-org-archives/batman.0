Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 04 Oct 2011 23:44:04 +0200
Message-ID: <1448578.Q1NEulQTAy@sven-desktop.home.narfation.org>
In-Reply-To: <CAFevQmMuk16mnWhsZibwiRe5Kdo4aNfu_1XZmBEigX5SBU8HTQ@mail.gmail.com>
References: <mailman.54.1312831773.1125.b.a.t.m.a.n@lists.open-mesh.org>
	<201108161311.27235.lindner_marek@yahoo.de>
	<CAFevQmMuk16mnWhsZibwiRe5Kdo4aNfu_1XZmBEigX5SBU8HTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart9091693.YB3RMJW7vo";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] Batman-adv secure
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


--nextPart9091693.YB3RMJW7vo
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

On Tuesday 04 October 2011 23:39:04 Filippo Sallemi wrote:
> Hi guys,
> I've read the open-mesh FAQ but I'm not able to resolve my problem.
> I understood that the mesh network is a public network and that every
> user have to make sure their connection is secure but i don't want
> that another node (alien) can connect to my network so i thinked about
> use ebables to block all traffic (such as policy DROP of iptables) and
> allow only certain nodes to comunicate with other.
> 
> I need some like this
> ebtables -i wlan0 DROP
> ebtables -i wlan0 --src <node mac> ACCEPT
> 
> but don't work for me

ebtables is for made for bridges. So you have to send the whole traffic over a 
bridge that does the filtering for you. But I doubt that it actually fix your 
problem with alien nodes.

Kind regards,
	Sven
--nextPart9091693.YB3RMJW7vo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJOi34kAAoJEF2HCgfBJntGhF4QAJevDRs4XDz8yIe4S601uhcf
DNeKMcuRz8P96Z8wB4T4dRmwIqWrWbz0vB20h0JY0em2KOc4Xbz5sHckYpHcNQ2K
2+opkp+QNFhpxVzgr/LA9V4Vn3IizTlFhd70ooS6gdlViH8E+CkNKE3bEiGHbWB4
PdonKyz7Ohs39ea/6vsDmm43g9ePoF19hCT3DZ/NUuqsrNX5KPdphcJ3sqtDGeF2
sRkqooRBfeQVP7ntZK6IIuUtyFe/SUUC6McIqe7fSJn8TcNR+7rN3bbGV3jXE5YX
u0nc+EgeOk1U4ZNc1Xwl65pD0xb8MXNMTLWmuYTXCiix/H06u54tXFTANzKCRWtY
s2dTpSXblNBjkU9//3BomkL0CkrhQqTr0jHmsTqFxxNwsl7cK636tFbCy9SlSr3M
dIwed+IcLqHnonuJNBrM5GsBV5zBWwlq3yiHYxZlnUf/kf2Mn4vZfAc0PZ+HNxUf
PMeVa0WaV44gUHGFU7ibVAZynroV1y88oQssW4YPSOY+wVKnRBwVvnBynW1X+o9A
W8VOJf7b92MMeGfbCwlRJ+zrvGi/ZQwogK9UMS7YBrfVjMuZjAOyPH4HnjBVDfpm
KQcmqibiM//t0Dy/rpyaFgFEntZEp2lyd5W1TrOm797SO5xGyz8Ghcv3rxwHh2C0
O5Lq5wQWL9vy+thuTUrr
=S9+J
-----END PGP SIGNATURE-----

--nextPart9091693.YB3RMJW7vo--

