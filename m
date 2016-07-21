Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 22 Jul 2016 00:19:54 +0200
Message-ID: <6419172.04lP9a1mmf@sven-edge>
In-Reply-To: <3501664.k16G2TetvL@sven-edge>
References: <1469137112-24094-1-git-send-email-linus.luessing@c0d3.blue>
 <1469137112-24094-2-git-send-email-linus.luessing@c0d3.blue>
 <3501664.k16G2TetvL@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5104895.8tT3Lgl9mt";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Use own timer for
	multicast TT and TVLV updates
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

--nextPart5104895.8tT3Lgl9mt
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Donnerstag, 21. Juli 2016 23:59:30 CEST Sven Eckelmann wrote:
> On Donnerstag, 21. Juli 2016 23:38:32 CEST Linus L=FCssing wrote:
> > -       struct hlist_head mla_list;
> > +       struct hlist_head mla_list; /* protected by mcast.work */
>=20
> Protected by a workqueue item? How?

Looks like you wanted to say here that it is only modified inside the worke=
r=20
queue (via the mcast.work delayed workqueue item) - unless it is not done t=
his=20
way like in batadv_mcast_free after cancel_delayed_work_sync.

Kind regards,
	Sven
--nextPart5104895.8tT3Lgl9mt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXkUqKAAoJEF2HCgfBJntGIVYP/2EVDjdt+eUkKuux31+rxDi7
OLBN9NU3D/3kZ2ODHw88O3gu685RympZp8psi/9GKV888E35CUcrOfXgD7sdA+5J
raLvbolzT/QO1zSfFFX6FIdDGYloqJUPI1SWe4XCecKIVxbkyk4wYXW+mPNo+4yJ
LwToYT4q5lIJB3aRNJvqyAB7lrnW/CnaXqBP0bfFemexta4minhLwPh3hwPfcbBz
7+CRLiAoSASuEfp0fEMQs/Y9XC666W1r7kH9PcIpNFTaSBbUsK7d1qyJ+yKul0cX
vcNG0Mcp7o54P+07If4RbL609GVpLdQWXQO4/xssEDEZ2Ejxzzli3h7+ab7AxwYW
EtwrYsKPekDz+0pO7+nd2LhieOUbEgd8QhemHZD+Jv6erF4WTB5J3uor7i049rht
Wy/5pUSAEjm4aw/lNRNeOMHGVRm4gWGv9vYadaYKNrNXTw0tl6ESi0KDGnrtyPmA
Ydy2FBJ8NxT47TgXTSDU+FwxmAeJ4mz56XHFoBr3Tewm2A81qbmXiOOL1kQz81ir
FyTYBNVV3rpWqfG2Hx5J4PYkKGQrl0C+H6+lEfn1zuqTJCz9d/xEBfa88xeqIHKq
3Sb/Avdfy/87UbnybohfNwQ2heVFhCvzFF717gtTBNzOZX/D4u2QYtJvAl5AVmTR
XtqCmJvilEgldAaqvzOH
=5Hnh
-----END PGP SIGNATURE-----

--nextPart5104895.8tT3Lgl9mt--

