Return-Path: <ordex@autistici.org>
Date: Sun, 26 May 2013 16:02:40 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130526140240.GO1679@ritirata.org>
References: <1368793673-27539-1-git-send-email-mihail.costea2005@gmail.com>
 <1368793673-27539-3-git-send-email-mihail.costea2005@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="h9WqFG8zn/Mwlkpe"
Content-Disposition: inline
In-Reply-To: <1368793673-27539-3-git-send-email-mihail.costea2005@gmail.com>
Subject: Re: [B.A.T.M.A.N.] [RFC 3/4] batman-adv: added necessary functions
 for NDP,
 like checking if a packet is valid or creating a Neighbor Advertisement
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--h9WqFG8zn/Mwlkpe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2013 at 03:27:51PM +0300, Mihail wrote:
> From: "mihail.costea90@gmail.com" <mihail.costea90@gmail.com>
>=20
> Added functions needed for NDP snooping, like getting the IPv6 addresses
> or getting the target HW address from an Neighbor Advertisement (NA).
> Also added functions to create NA for Neighbor
> Solicitations that have already the HW address in DAT.
>=20
> Problems: I have to generate router and override flags for NA. For now
> I don't now exactly how to get them. From what I've seen, batman could
> now which nodes are routers, but for override flag, we should find a
> mechanism to know if the node is proxy or has anycast address.
> For inspiration I have used the code at: <net/ipv6/ndisc.c>.

What is the concept you have in mind?
Maybe you first explain a bit more about your idea so that we can help you =
in
find a way to implement that.

You want to edit the router address and flags carried by the NA?

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--h9WqFG8zn/Mwlkpe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRohYAAAoJEADl0hg6qKeO2v0QALpnWlC5zpj3AtngQDMsHIry
7ak9f7fZBanMeqv2gJ41sBIY9jRB9WfUjRE4YNfW3jVXtzbuPsL4N3t7/kZTNh40
/Fjw6Gw1+QGcR8aGfUvLDK4+sj6OFlxT7PCMI8rdOqkYEgLLbhrqNLt/zVbPOi+m
bJ1CvS0uwrjFooM7AUfg5/Bw09J2seKNfAmnufzmHPMZm2gbaOgojTA0LIIF5Sfz
DS+Ek0lJ3+vg6ybcaXCHtaI0BG1ZncobBL5KVD5ie9xhsS5nht1x9u1uBOS9WzyY
UEyUsS8N+Yn+zCA0r7YwoZazzXvx8869f+T8XlbR61rewsplyrfNlbvknhiZkcTh
sV/PiuaGNSA02DW3JDppHZcr4hUZ6rAXq6NOJ+Yn1kALI+vZi3X7Wt5CHWfjdtSF
CIRSHAYroR4rxZQU4Asu90CN7A8GB02MPq/wjAUVpsnUviXAnuP+j7/koVJTTKy/
crBzH8YqDjbIC1sIjuIN/jfaMM+YPswkuRONkVMj3evgAe0qJKwwOELeElXoFIkj
+2VI3/dU3GYiLkzIcxH2zRlOJc+eMVknAT0mj0Gi7wpM7FXoM/nRXRb8QtSpa6nT
kZHCc38q2+Hw1QlsRYJQCVmEREvOrd1+xczH4y9Pu8tKQEHYfPwOCObqMOXezFGT
+kpfQB6MHtPJX4BlJz59
=ygtN
-----END PGP SIGNATURE-----

--h9WqFG8zn/Mwlkpe--
