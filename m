Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 11 May 2018 08:13:09 +0200
Message-ID: <4477321.n6vKnkidQF@sven-edge>
In-Reply-To: <20180510174428.8646-1-linus.luessing@c0d3.blue>
References: <20180510174428.8646-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2317850.DHkZhexcBF";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v3 maint] batman-adv: Fix TT sync flags
 for intermediate TT responses
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

--nextPart2317850.DHkZhexcBF
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Donnerstag, 10. Mai 2018 19:44:28 CEST Linus L=FCssing wrote:
[...]
> + * @flags: a pointer to store TT flags for the given @orig_node and @ent=
ry to
[...]
> + * @flags: a pointer to store TT flags for this client to
[...]
> + * @flags: a pointer to store TT flags to

Antonio wanted to have some changes here. From IRC:

<ecsv> ordex: any objections to T_X's last patch version? https://patchwork=
=2Eopen-mesh.org/patch/17355/
<ordex> hm is this correct: "@flags: a pointer to store TT flags for the gi=
ven @orig_node and @entry to" ?
<ordex> entry to ?
<ordex> the rest looks ok
<ecsv> maybe "@flags: a pointer to store TT flags of the given @orig_node a=
nd @entry" is better ?
<ordex> ecsv: maybe ""@flags: a pointer to store TT flags for the given @en=
try received from @orig_node"

Kind regards,
	Sven
--nextPart2317850.DHkZhexcBF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlr1NHUACgkQXYcKB8Em
e0b5TBAAtoIZF7RTdiQb+7dbPOgZiFRVkQ5iMGGiBkqLNYgufI5wgEbS5ZzjN3er
REzq5b8xaYo+5VEgInnZsE3UqWdSQHbrmBzc3j2PbXWxmzBH5IvWHY7SOz6PDHVW
n3voRHWOAD+TDtFr5RZsINj1f+GJe6P2X4OrRs4YhVS9h+/Z81Ns/5ksDjoe59vn
ufD48Wd7kcnJPbftIwb7d7fAAUXNo38/RtS0pv3QrkwpZ4C4WPnI6hvHf4hJZ4Lr
RwuqtIm8b64DgJwg2QAtH3kPWCkhkhGwa3+rgzY7MnAHG27KEqAvJZLV2P7rAPk7
N/1kEE+FhQVUyNED95Mx2/PkvJVQYX6uMtK+n7LJfTOi6/WA+O836ATMZ8xICtlp
ps8yhIdBQhu9045+Io6Wv7B2fJ+Dy9K5safVdITGbwk3oeUzoJh2GiGy7PTUaiYr
Zk0bZKN9zrBilUdP6wubVOtDoFZa0IoVzm+jCok8ARsUh0wOjLgguP1m/ZMmDctU
BhOZ+6nRwDCWJ9c6adquQ3G1IJbtMgJ1T7nDSG8A5HVQFT4meLfDdMQSpPyI2moC
PhjNoVruk43ybTcOXA74b1TGhS0/7h42P4L+E8OiITF1QslBdR8gV8UcmzfRqQ2j
Z/7HqVjXBdsTnpkEIXQ6euGkjtwvIKbqS5i64ah7LWqe7YDuH3M=
=wBmE
-----END PGP SIGNATURE-----

--nextPart2317850.DHkZhexcBF--



