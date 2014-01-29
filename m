Return-Path: <antonio@meshcoding.com>
Message-ID: <52E8D622.8080902@meshcoding.com>
Date: Wed, 29 Jan 2014 11:21:22 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1390836437-3014-1-git-send-email-antonio@meshcoding.com>
 <3034509.GXq9lutoyG@diderot>
In-Reply-To: <3034509.GXq9lutoyG@diderot>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="x9oJG412iSRaFCXf73TbQND1ML4xAkiWC"
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 next] batman-adv: avoid potential race
 condition when adding a new neighbour
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
--x9oJG412iSRaFCXf73TbQND1ML4xAkiWC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 29/01/14 05:40, Marek Lindner wrote:
> On Monday 27 January 2014 16:27:17 Antonio Quartulli wrote:
>> @@ -266,7 +266,7 @@ batadv_iv_ogm_neigh_new(struct batadv_hard_iface
>> *hard_iface, struct batadv_orig_node *orig_neigh)
>>  {
>>         struct batadv_priv *bat_priv =3D netdev_priv(hard_iface->soft_=
iface);
>> -       struct batadv_neigh_node *neigh_node;
>> +       struct batadv_neigh_node *neigh_node =3D NULL, *tmp_neigh_node=
;
>> =20
>>         neigh_node =3D batadv_neigh_node_new(hard_iface, neigh_addr,
>> orig_node);
>=20
> I don't quite get why neigh_node has to be initialized if we set a valu=
e in=20
> the next line.

nice catch :)
That's probably a residual from a previous approach I was trying out.

I'll send v4 soon.

Cheers,



--=20
Antonio Quartulli


--x9oJG412iSRaFCXf73TbQND1ML4xAkiWC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJS6NYmAAoJEEKTMo6mOh1VJGcQAJRdWM4iQ1ZI2/PIVboyVAqF
mmOJbBuNzHvZjv7T+jqw3pLLx6LvwUqPMv+D41n7kx2GrZYTQBBAOUDBjT8dBgwF
ffme5f7z7ou8t+KtnEAiHDh2iSAMd2NcMvcrYpKCqRR1gQVGmHN6yFCPmXzgIxym
Jb6gZ8ottumeg7GZCtTwkJH+GmD4R31eiLtzyU1OCCC2GL6w4vTIgJZst3a10peP
y31Ticv+RkAST/VENkCbJtNObIgwXaoLtWaov/T/a74hFwTNz8Kp84KZQxrNxepq
4BWnzKouNfk4F8P7BK7/gGKMrVBIgiXS2D+Sfl6HUo/3hn7OgxAFnPG8/V2Brgqa
CkFREIF7LYvpKyd9hqqaUYAS6Lnteq7QAJsRmS2muS5EvZ42P/x4vEuvojun4JIq
44KT23wo6cSKS8rm0xA7ylGdCV1wVoT0lLcKkfylgOmHso9ONa2ET5+9Xh+h7I/k
ntIJ1kBYAjqUxCRijLUxo/Sy7YdqcbuWFj2F57zfYHDe+Qj4YS8Opkqjz3k3MRaP
lJ6hZk0x8lCzVKjvqEst+2B6L9a4v7xclp4E93xwTBBzjgTIix026Z2TkJ2khTvv
QymQ8hSbkyeEKBWF0d2nufjY4PqKQj7+L/xa3mVf6Vi9yEKRlwKDq51rue8PYhvT
G4BiJctJpRSYCyaBmqQj
=W2yi
-----END PGP SIGNATURE-----

--x9oJG412iSRaFCXf73TbQND1ML4xAkiWC--
