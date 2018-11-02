Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 02 Nov 2018 09:25:46 +0100
Message-ID: <13886251.QuPRaKNnKz@sven-edge>
In-Reply-To: <fa0e399a-2234-33ee-0a3e-78decfd9618c@blastwaveinc.com>
References: <fa0e399a-2234-33ee-0a3e-78decfd9618c@blastwaveinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5688932.JWSEEc3EpB";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Question on 'batctl o'
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

--nextPart5688932.JWSEEc3EpB
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Freitag, 2. November 2018 01:39:28 CET John Gorkos wrote:
> What does the leading asterisk indicate by an originator in 'batctl o'?
[...]

The best nexthop towards the originator [1]. But this doesn't mean that it
is the only way it sends packets to this originator (see alternating [2],
bonding).

Kind regards,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/blob/6f6cc4f54909127b236069207fe5691d31c29b24:/net/batman-adv/bat_iv_ogm.c#l1918
[2] https://www.open-mesh.org/projects/batman-adv/wiki/Multi-link-optimize
--nextPart5688932.JWSEEc3EpB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlvcCgoACgkQXYcKB8Em
e0ai5Q/+P0SWjr4d8IH+63MxorL1y7oPiERPLnN+Cp9MCJGcGYGVC52xlYY6mMsA
J3VXIm3GsNRH9ICPCjjnrzvY9jrnCXgWSiXvVFIJaQjfCAvbZ/jp919vozobJa3d
22eRPbrVoD6Zkk9oi1b0wD6RInZbBI5Hmhbad160Cf0QmQnhHr/8/fZmzgJ8hctO
0ZxPslCHrQowKLoTPaKTD3Fbw+k3c0En85JNDatv9Yy8x8GUcvJ+JkNy/OZi8tLn
ObqocENzMgLDttEJr7ckP3t2ZYyzFXTNvLptj60qT/o4XId124Eqa2VGczEa1idc
GixM3Hv2EmLXUmgjZuHkcTVnHqGWteAaj9AZIn1qRr8JSY1+14xxXn7JN/yhLowr
K1z+aLnNo3LJiJsoGEPIuiCOMl5FK12PuYglDNp0tpeS7pGhU4sNWN+zRUvXlusb
f5Yh6ps6cNJ4WKdR4hq9IMgEW7hSkBXCfsB5FtONnfDvnADMhnY7WhPFkiqtbSI7
0xvbGkJVH/YhG4Fo5u4Nv4amgRoqJn67mSPmHYqmv4VqzwDWmpa0TfUanglx0bIy
QcN1UCGOItweW6gIe7+tglooq8JxLpX8T/5iQukyEmpmDC/aW4YU6Py14H2nRX16
9IW7agrvHrfXjRT7YWMYXf8BnLOiJSGa/PsntzMC5eiC7IwQ/pQ=
=SqhF
-----END PGP SIGNATURE-----

--nextPart5688932.JWSEEc3EpB--



