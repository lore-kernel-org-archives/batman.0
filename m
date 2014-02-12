Return-Path: <antonio@meshcoding.com>
Message-ID: <52FB682A.8060705@meshcoding.com>
Date: Wed, 12 Feb 2014 13:25:14 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
 <1392122903-805-14-git-send-email-antonio@meshcoding.com>
 <20140212084954.GG30814@lunn.ch>
In-Reply-To: <20140212084954.GG30814@lunn.ch>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="G3O1RblC76kkOfRj2K96SAD1aVNMeiOaN"
Subject: Re: [B.A.T.M.A.N.] [RFC 13/23] batman-adv: add last_unicast_tx to
 struct neigh_node_elp
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--G3O1RblC76kkOfRj2K96SAD1aVNMeiOaN
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/02/14 09:49, Andrew Lunn wrote:
> On Tue, Feb 11, 2014 at 01:48:13PM +0100, Antonio Quartulli wrote:
>> From: Antonio Quartulli <antonio@open-mesh.com>
>>
>> This timestamp registers the last time a unicast packet was
>> sent to a given neighbour
>=20
> I think this changelog needs improving. 95% of the patch is about
> refactoring a send function into a unicast send and a broadcast send
> function. The counter makes up the other 5% of the patch.

Yeah I should definitely improve it. Actually the refactoring has been
done to allow batman-adv to easily save the last_unicast_tx time. But
you are right, I should explain it better.


Thanks!


--=20
Antonio Quartulli


--G3O1RblC76kkOfRj2K96SAD1aVNMeiOaN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJS+2guAAoJEEKTMo6mOh1V6aoP/2LYefrcQ83UdyDXh7hheUXn
cvL4GKSPE8XBwcObC+jHEGC0Eb6sMLZrAS8ivdTKKXutUlyIo5G1EKKe/0D9HrAK
SjYyUu/IOqliNttnkaOI2ESKRaUu+6UrUHjqPs8vDMVj6WS3oXQVHTHX+zQQAPsu
xm26E8SgEg8RO8LM91gcbUL9okoc8ahRmkOOj4TKiXELkFWIT/XrPx+qDtN3J0WA
LYbhmCcIzxv0jmdT6EITE3L7gTmbZUQqdSdNn/C0GTW7+PzW4mhjNy1Sd5AmQKN9
uysH2RZRn+moXyvUxldz2/P0wbqV0qsiPxv6MGRdIMbtvjtf5eV5sm3bDp27eU+x
w6reCNYboskaJyJfVFWgCjgDOBkBfC3uwQjKA/1m+I2t8pM/eVBxyWYZn2/QMueI
YsUp0/OTsyEj/gsmWBfacDUvYzkxZpzeDzi2vshzEXL/FNipog1NtFDglQV/BnSh
mgF+iJfYqDqqXEFhkoJPBqvp6YLVa6OfRE7Tcv+ESz9d+C1E46vMxHxyu6NW8vSy
1VnTUVMOOmfViffp4ELoQgdCjB/UvRIQjiYXkV80OEJLcQ5T2BX6CvS3q/E2tmV0
aURUHd1495Ze6g8WaUKw/QOw59biFrFEt5ei/LiEcx5GCyfGN3zARS3+4GEZEABa
DrinhIZRQJtMl6ym9ztb
=MPlT
-----END PGP SIGNATURE-----

--G3O1RblC76kkOfRj2K96SAD1aVNMeiOaN--
