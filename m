Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 12 Jun 2018 21:47:41 +0200
Message-ID: <2837973.EqbrSDaRnS@sven-edge>
In-Reply-To: <20180606224624.10141-2-linus.luessing@c0d3.blue>
References: <20180606224624.10141-1-linus.luessing@c0d3.blue>
 <20180606224624.10141-2-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4211026.D8PdUcQnky";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint 2/2] batman-adv: Fix multicast TT
 issues with bogus ROAM flags
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

--nextPart4211026.D8PdUcQnky
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Donnerstag, 7. Juni 2018 00:46:24 CEST Linus L=FCssing wrote:
> When a (broken) node wrongly sends multicast TT entries with a ROAM
> flag then this causes any receiving node to drop all entries for the
> same multicast MAC address announced by other nodes, leading to
> packet loss.
>=20
> Fix this DoS vector by only storing TT sync flags. For multicast TT
> non-sync'ing flag bits like ROAM are unused so far anyway.
>=20
> Fixes: 405cc1e5a81e ("batman-adv: Modified forwarding behaviour for multi=
cast packets")
> Reported-by: Leonardo M=F6rlein <me@irrelefant.net>
> Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>

Added as c7054ffae0c3 [1]

Thanks,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/c7054ffae0c3b08bb4bef3c=
ffee1e0a543e14096
--nextPart4211026.D8PdUcQnky
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlsgI14ACgkQXYcKB8Em
e0Yh6Q/8Di0pMALrWMHB/w2BZZGVm33tjIusgEnf5CzwMu4SKwe1s/lXRur2+V74
gmRmkg1PxxAKQL+BSf4RJYQcG607A1PWEy2zuVNwx49IQfWQAypGYBLCZ3HVe3Va
Wbrd//g8sntI7I/HgGmuE7KK5T8RhfB1wcftMoSVf2ByBj3kpGe60SEp2fq9kEbV
p5kyzyJmnfWYOYrjnRh5JRSzNwVV/l/nNbUhwqY6bJYzt0k8oUstxCvBKK8U8qvF
s7yC08m7gnNv52Mni8iXINKSrG2EbCWUasDCQHfUcE9wooNnBhqNK0SBd+yODzNM
enqZj6ablmmMOGHa65g9PI8pZ46zikOGkTiZ3RdFA4nPeImIY9zXEbLG19L+ISmZ
BuEjLncJxfIcbhmXrYSw8ATx1JhzfWoGH7kOnb4e8ejBrLhYC2+LVPmTR/HZKq//
Cs1vQX+nI7u412nrDh6NFiu1c0UeP/SoM3mj7lTtHw8i/cdZKsJ/wPwBdEVuOd3O
xFZwRRxuH6g4MtEConuWq46eW31AuuGW9hLP3HC70HJO0ETVxGDTZfAYbfVYcOdo
iRenLlpR94KvUtphdww6CQnFPAqAWRvNP7PeSr9HQUZ3fckuwoFVJfLOjb6conqT
yF3LN3nAevGKdax+F0d24hT6m/bPuj7wUryhhzfkLffj6R04EK8=
=7YjR
-----END PGP SIGNATURE-----

--nextPart4211026.D8PdUcQnky--



