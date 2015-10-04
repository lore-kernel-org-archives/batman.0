Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 04 Oct 2015 18:27:54 +0200
Message-ID: <4946773.CRg2Vnx3gp@sven-edge>
In-Reply-To: <6D3C26E9-B62A-4577-B738-E21AC08114F4@heidler.eu>
References: <56113660.8080506@heidler.eu> <5450614.1BWUbN25GJ@sven-edge>
 <6D3C26E9-B62A-4577-B738-E21AC08114F4@heidler.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4377335.G9VsVXxskk";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Alfred update-command
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Dominik Heidler <dominik@heidler.eu>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart4377335.G9VsVXxskk
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday 04 October 2015 18:22:54 Dominik Heidler wrote:
> ah so the update hook is only executed, when the master gets the data update
> via UDP. In my testsetup I updated the master data directly via Unix socket
> on  the master.

Correct. Usually you don't need to inform the local  system that the system 
itself updated the state of the alfred data :)

But feel free to discuss it with Anatoliy here on the mailing list (so we can 
follow the pros/cons of a design change).

Kind regards,
	Sven
--nextPart4377335.G9VsVXxskk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJWEVOKAAoJEF2HCgfBJntGoHUP/1aidoBoaPc4g2jvDFIc4anJ
WKymYcMIwfljDuoGP51wFDpbAci1Ub++H0mOAKLg6KBaSyF2dCfo/ft+6iDCdvyN
h6bwE72mgIoXY1RQ4xV9C/rU8dK/oVkbI3K5U9ZL5ciVCkZBmifoU2qDDOoSyosb
ugzQtHwoMv65aXhc6qlRnn1PGS82iyZW6bj06MK9hlVoSKvEIwd6vp8PR+VGsQtf
ZyULAZ57lgfVoJq7a611cSENZQctHHVxphf5p3T66QkU+qaJ6YWHRHpWv7jFy8TA
AqiQua1DHDvPnnUNdUjUxqjBuOOci0+chCk2HN8m0SjhEbKEMKGwiixHHm09lp4h
kneZx0Ku9uUQX+1b/4z0DR2cSQE0dURz9735eBIQ78r7dfVLfsN3gyDXMel2Wljk
ctUvOM/JK+Lyy6tniVDJt9GYvmuDlDA/C3t/cxNn0IZyIB6MI0ahWzUZCUTib9N6
juWlOegpqp13Zxsg9EYKhT/OzJ9UbQLWHv3hTJsbooFFjrNxs6mBTtOp2NV5U6Qb
/3WCJ21cuVJS2CsKJQf8+uYTJjycEklD8WtE2E/h+w+EDOZbBx0vXecurLxVVbsg
ED2NZnNUefBfkfwVRdyyjM1hscTBmckblSOQsijTytU3zndYBmYdmcxGGHGDJxBw
3eQTAOjrOKNDXH8qTSeY
=MGMd
-----END PGP SIGNATURE-----

--nextPart4377335.G9VsVXxskk--

