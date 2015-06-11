Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 11 Jun 2015 21:20:49 +0800
Message-ID: <1912783.F1ndSkPlnl@voltaire>
In-Reply-To: <1434025163.1056.73.camel@nord-west.org>
References: <1434025163.1056.73.camel@nord-west.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1656707.vUdHzOO0Sr";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Mesh hickups with 2014.3
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
Cc: freifunk-ol-dev <freifunk-ol-dev@lists.nord-west.net>


--nextPart1656707.vUdHzOO0Sr
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, June 11, 2015 14:19:23 Bjoern Franke wrote:
> - ping via linklocal, ULA and public-IPv6 from gateway to router not
> possible
> - other routers in the same mesh can ping it via ULA etc (connected via
> the same fastd-VPN)
> 
> Public-IPv6 is announced from a gateway via radvd into the mesh.
> 
> Unfortunately we are out of ideas where we can search for the reason.

Do you have the multicast optimizations enabled ? 2014.3.0 still has a known 
bug causing these optimizations to harm multicast traffic. Either disable this 
feature or upgrade to something newer than 2014.3.0.

Cheers,
Marek

--nextPart1656707.vUdHzOO0Sr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVeYs1AAoJEFNVTo/uthzA72IH/jhV75uZrquD5jg/lTbJMuaP
4YXH+CUFMrYRtyqUWr86o1b+LTa1xJ8GL2g0Z7O3VwVvcLHkbsqE71dy9K5g2yEx
7rCW+/4hU48pT8DYrKb8x3/g3EIprVxdp7/UnN839WpjlWrStEs081s7bHFlrTws
Imw2MGcHwRLXq3yFHZaOHov6GoERSaeyA120M1mKk6k4wuKj5r42vWwUZDAcwGSz
tHOooJ7WuW4zyw1rerEEBmnO1U99+CorQEBgELozln8FXokD0bQPztC/LaXjDk0j
CLltvg4/SOUqS36duX1pmseOV+6pvSFOPdoAns/NO7fG0DNopRqMUwdVzpxA+gA=
=hnUC
-----END PGP SIGNATURE-----

--nextPart1656707.vUdHzOO0Sr--

