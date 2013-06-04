Return-Path: <ordex@autistici.org>
Date: Tue, 4 Jun 2013 09:18:17 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130604071817.GL1226@ritirata.org>
References: <1369683792-531-1-git-send-email-ordex@autistici.org>
 <1369683792-531-13-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5VuzLDXibKSJvVYD"
Content-Disposition: inline
In-Reply-To: <1369683792-531-13-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 12/12] batman-adv: make the TT CRC
 logic VLAN specific
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
Cc: Antonio Quartulli <antonio@open-mesh.com>


--5VuzLDXibKSJvVYD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2013 at 09:43:12PM +0200, Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
>=20
> Nodes may need to handle the TT table on a per-VLAN basis,
> meaning that a node may want to filter a received table and
> get only entries belonging to certain VLANs.
>=20
> When doing so, such node would re-create only a partial
> global table and would not be able to compute a correct CRC
> anymore.
>=20
> This patch splits the logic and introduces one CRC per VLAN.
> In this way a node fetching only some entries belonging to
> some VLANs is still able to compute the specific CRCs and
> check table correctness.
>=20
> With this patch the shape of the TVLV-TT is changed too
> because now a node needs to advertise all the CRCs of all
> the VLANs that it is wired to.
>=20
> To make the code simpler, also the normal LAN (bat0) is now
> considered to be a VLAN having no tag.
>=20
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>

For the next round I separated this patch in two:

1) introduces the VLAN generalisation
2) introduces the per-VLAN crc logic.


Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--5VuzLDXibKSJvVYD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRrZS5AAoJEADl0hg6qKeO43QQAKPPCrRULxUbpmKraUugYSJI
JLIso0kbLQbWYFN9u13WsOZdJzX1EAF0A3RQgqHPGaP76NdzdjR27LVtFlZcSycD
ziKOMcwHbRj5m+IO2IfydzP3YhWDr2yjGeTbnqzzxSQ6WACHtWjuVguzTwUMwlkB
dBAKJsV6V4euol3EGGnKVSBnvtZEJ8Uoc5PARUDCDcBPopQDrSP3vbQObo6DZ+kF
ZEl0GCeHU8whvUM2MblE91LVGKxElMyA25zy/HMhFK4kLbgyoDnYdHfszvTk0dUb
Vskogj9hlQseaJUYajIPDL8SsxMA8DQxIXJ2dezk7b8d5OlBmYk5BEFZ87uUV3hp
OzsSfkzm9+LmjwgzgAxetnEcHNQlCmUMFJBHZa4LGtTkz/nrNT+dp4srKR8IIxJa
W2oNEbhtfwcX4sYMqslZM2ZHJy7LJu9sLn1D4AVU3SXgrTFsxax3tZh7JCJ1Nqk2
HxUCWYUnvcYbSRvoebBCYMyqVSoCLQF8BrfpNp9bIali0gxYbVqhYniUVs2rquNZ
BPp1DI8tLui+cm/NSJep/PfzY3O5HG3iICTYs2yj1j5eR1xWqfNpxMDPXc0c+Jvc
bkXesHShbuYa0C9p4I+zTKeEPqBZA09lKNeRCEWogkorU8HSm5p+LujPmB5ITEUh
fDllSVUYKD0lIDdzgLAF
=ALNC
-----END PGP SIGNATURE-----

--5VuzLDXibKSJvVYD--
