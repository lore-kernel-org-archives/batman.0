Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 14 Dec 2016 21:12:00 +0100
Message-ID: <31536424.nRq5nXL76i@sven-edge>
In-Reply-To: <9817609.KyospJ5FZq@sven-edge>
References: <20161006064142.20003-1-linus.luessing@c0d3.blue>
 <20161006064142.20003-4-linus.luessing@c0d3.blue>
 <9817609.KyospJ5FZq@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4280069.YzI652ciIi";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 3/4] batman-adv: Introduce packet type
	independent TVLV handler API
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

--nextPart4280069.YzI652ciIi
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Mittwoch, 14. Dezember 2016 21:03:05 CET Sven Eckelmann wrote:
> On Donnerstag, 6. Oktober 2016 08:41:40 CET Linus L=FCssing wrote:
> > +       void *ctx =3D batadv_tvlv_ogm_pack_ctx(orig_node);
> > +       const struct ethhdr *ethhdr =3D eth_hdr(skb);
> > +       unsigned int tvlv_offset =3D sizeof(*ogm2);
>=20
> Haven't checked the complete code yet but isn't an increase of the
> reference counter for orig_node missing here? Things like
> batadv_gw_tvlv_ogm_handler would then have to take care of dropping
> the reference.

Ok, forget that. batadv_tvlv_containers_process2 (which is the only user of
ctx) is directly calling the function and not delaying anything. I was under
the impression that their might be an delay.

But I am really not sure why you are using batadv_tvlv_ogm_pack_ctx anyway.
You should be able to use "void *ctx" in batadv_tvlv_ogm_pack_ctx parameter
and then give it an struct batadv_orig_node *. Or is is just for the WARN_O=
N?

Same for batadv_tvlv_ogm_unpack_ctx

Kind regards,
	Sven


--nextPart4280069.YzI652ciIi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlhRp5AACgkQXYcKB8Em
e0b5bhAA2J5GwmCz4MTXnyR0DYs8L5I6teeQQWp9xCICLxOjVgASRyk6xq+UzPQ+
d+ZaoX4wIM+aKdHgrcB3obBWvcuFQOJFRKP4OZ2kCwpIA14ihnd5Fa/ZbFrbbgmt
qrOCu0goRQEeNC1v/s1Zv6w93v4VOeJ06vrUlkOMiCFTLQr8a13Qbulbv26HZiFw
h6YjBnQh8v1tz6/LrOjAo8YQlgpBD3KwrK/poLscJk1Doqr2OEiaoeaFGXsy+65z
dIalWrDj34QU3eLVeFKwp0Gkt6mZgPFBG1rN7wRW6keEGmTZ+HhtN1Ca8ak2QARc
Vy1zWQNi+Ld1174k9JSBEPKVH86gdhnxiMiRhAXNYhUVZ+3/CUy6ymYWuABafdZH
zxr/C8ZGoVxQ9XCi05Lr02RcAU/MvmDfnbJ6LflyJfloACZGb6EoB5hhGbOL/XUA
t7nJ9XMihCSclo7y8u8TOz1tfmnflxn68q25eCR5rJTOh7glo9ZMSJQh6H9AVBjG
NmxGKquPaRPKdVhiw23JB7KScO4VU6CEEJQ16R5l4QezZpGrDWVNv1WJUPqk4yDp
X0fuoDAHOBMpWobqiM2xXXIisqtMoio+gqpASc/TxeRb1ZApNg1V2QB+G094xBI+
7EP1B//wjYpnDvIt6QlEdAdSjWW75XvHRe/4nJTlnikr5nhKI7c=
=1cWu
-----END PGP SIGNATURE-----

--nextPart4280069.YzI652ciIi--

