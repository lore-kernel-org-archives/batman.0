Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 18 Jan 2017 09:11:06 +0100
Message-ID: <2711856.7t1cvRFbFD@bentobox>
In-Reply-To: <1484716332.8609.3.camel@sdl.usu.edu>
References: <1484596174-16341-1-git-send-email-jhaws@sdl.usu.edu>
 <1560076.ER48KEDWps@bentobox> <1484716332.8609.3.camel@sdl.usu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1913411.s9AXQLH1F6";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] IPv4 multicast distribution support.
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
Cc: "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>

--nextPart1913411.s9AXQLH1F6
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Mittwoch, 18. Januar 2017 05:12:12 CET Jonathan Haws wrote:
> Is there a typical test routine that is used to ensure proper operation
> of alfred?  Should I simply add a third node to my setup and configure
> it as a slave and make sure things operate properly or is there a more
> automated test or better approach?

I would not be aware of some special test setup which is used for alfred.

And yes, you could simply add a slave to your setup which also tries to insert 
data. All master nodes should then be able to retrieve the data from this 
slave (after sync).

Kind regards,
	Sven
--nextPart1913411.s9AXQLH1F6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlh/IxoACgkQXYcKB8Em
e0YYXg/+JzGl5PazE+ZSdiORausiXroTsl4RlcQhqN3cbURUrDDj10AIdxjB7dAD
/8aUUMQJ4OHKGg1iXDWQKfHWyxm+X1aQ//iBqP6LV7UhP1zQ1LPcglobkOIAP+4i
H40iIE0+SEhLP1MWtxGtoITNFHDZxwIZf8BOIeH/iJvB+hkzl6qH6aAI3GCYOJj1
e/SY06x2dEh8igSNj3nPXuLi5G7OezSzx9GBHX80+9SUexlZze5gjrCYM0qkNMSb
Z2onjCRsDMwQNqkWtk/9KZHDTg/q4iN8Uew3pKQbR8ZUsUaoLrKWu9v5nclMJXrK
b2qX7s5J/cjgTt4jYdgTFhkjXPNubH/J2tP6NK/Y34d4RPcNqqM+NSF7jWETBy92
UePNatnJzxFvnfk2lCJFkcHitbB7o8yWMaWXzf+Nkqk2X50YnBOjyqXrEc06t7Qs
CxxZDjR+7R0fCuTU0JD8Q2URqddtl6/5tNKsXUZE3MuMv29jHj6Dt1GeTa352RL/
db7nkKsm9FquH6szi5rHwU/qQClMTtEa+IURzNBVRCdqgEplANNHokJiSdLqMHNK
5ZE0FChghddFOP5y3+wsgABdnPKDL7sXxMUzowwHoRBPt8d7z0FDNoL8ge/b/xfJ
4ocS20/1JyQALoLHJ+NsxqCCEBBp7IqgDsHCCwQnRz6XbZm5LO0=
=Re3U
-----END PGP SIGNATURE-----

--nextPart1913411.s9AXQLH1F6--

