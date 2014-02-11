Return-Path: <antonio@meshcoding.com>
Message-ID: <52FA5E39.1020705@meshcoding.com>
Date: Tue, 11 Feb 2014 18:30:33 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
 <1392122903-805-9-git-send-email-antonio@meshcoding.com>
 <20140211172212.GF24633@lunn.ch>
In-Reply-To: <20140211172212.GF24633@lunn.ch>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="4VP1r0w85GOi87Lph5vM4fHkovMG0Ceif"
Subject: Re: [B.A.T.M.A.N.] [RFC 08/23] batman-adv: OGMv2 - implement
 originators logic
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
--4VP1r0w85GOi87Lph5vM4fHkovMG0Ceif
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/02/14 18:22, Andrew Lunn wrote:
>> +static struct batadv_orig_node *
>> +batadv_v_ogm_orig_get(struct batadv_priv *bat_priv, const uint8_t *ad=
dr)
>> +{
>> +	struct batadv_orig_node *orig_node;
>> +	int hash_added;
>> +
>> +	orig_node =3D batadv_orig_hash_find(bat_priv, addr);
>> +	if (orig_node)
>> +		return orig_node;
>> +
>> +	orig_node =3D batadv_orig_node_new(bat_priv, addr);
>=20
> Can this fail and return NULL?

Yes it can. Better to check.

>=20
>> +
>> +	hash_added =3D batadv_hash_add(bat_priv->orig_hash, batadv_compare_o=
rig,
>> +				     batadv_choose_orig, orig_node,
>> +				     &orig_node->hash_entry);
>> +	if (hash_added !=3D 0) {
>> +		batadv_orig_node_free_ref(orig_node);
>> +		batadv_orig_node_free_ref(orig_node);
>=20
> Looks odd. If it is correct, it should have a comment why it is
> correct.

We have a similar problem in the current (B.A.T.M.A.N. IV) code too.
The point is that orig_node->refcounter is initialised to 2, therefore
if we want to free the object in this early phase we need to invoke the
free_ref() twice.

By the way...I was just thinking that we could invoke kfree() directly
here (the orig_node is not referenced in any other context since it has
been just allocated).

Cheers,


--=20
Antonio Quartulli


--4VP1r0w85GOi87Lph5vM4fHkovMG0Ceif
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJS+l4/AAoJEEKTMo6mOh1VVqsQAJ9QDAlI12Pm7xn/I7arX+1S
Zn7raCQANNuaal+GSmYgVA+bsQNiPMrC5ISo3SbHQw40XbHlO8+ZUPPQ1sY9x/pk
+IwNS9EllgC0nUSGN2eWgvHR7HxrJGLJBfn8a3JQDZi+Vr/7Uz2FvqEynE8qJmdY
DI2qYt7fzvgqlvSAnHPsQi6HctJ9/TGMrDF7tTYNSAIlqbsvdgmRxrrTnE2s7lI1
+/kHPA62PRyFI/uuiHVuhk4g9GfhRaquLnWSexymBQWjPPmJ8h6bfcFH/yOU/up3
/36WUx/wZjbacxf1iORJhMxrUdXFg/Tk2pSBTRtqr3O9KxQuc3IVbbxelmBIwvpe
5jkV7p92FLFhTh5mYy3ir5n8q7LSLvT35U0QW0SYP3gIJKWKBarxbB+yvYCapqJR
X4/N65tSobtEebU57Eu5sQ6sK+C6JUgLiKg9hKRG3y3Q0AOp5877pOSDKjHbqU4J
tYM0Lh7ZwEqZ6GIVfqeBfsqH6+xdrRje77Y4Mek/IUuM1UKIRiUrWEZfySOrbO9y
Z6pSvoAN5UTj+lSf+uA6qFE7JgjC7PLF3Xj3hBGJj4pIKO2keyAvXsChQy880mx9
Q842jrviisaka+EbbZTZdXoBZJOxSvlfO1dLKcjjylvzToXM58GhZttk+sWE4fzj
QnuxRoEFVXhMUPKdJAsc
=KxaB
-----END PGP SIGNATURE-----

--4VP1r0w85GOi87Lph5vM4fHkovMG0Ceif--
