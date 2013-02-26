Return-Path: <ordex@autistici.org>
Date: Tue, 26 Feb 2013 22:31:12 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130226213112.GX3523@ritirata.org>
References: <20130220144025.GP3523@ritirata.org>
 <1361372251-27623-1-git-send-email-ordex@autistici.org>
 <20130226212813.GA8249@pandem0nium>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="uWCTLymdFNG0vGYZ"
Content-Disposition: inline
In-Reply-To: <20130226212813.GA8249@pandem0nium>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: add compat support for the
 new netlink ops
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


--uWCTLymdFNG0vGYZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 26, 2013 at 10:28:13PM +0100, Simon Wunderlich wrote:
> Hey guys,
>=20
> As requested, just did a quick test again:
> * batctl if add $iface && some OGMS here && batctl if del $iface
>  --> still works fine
>  * batctl link add dev bat0 type batadv
>  --> creates the bat0 interface
>  * ip link set dev eth0 master bat0
>  --> no output, no effect
>  * ip link del dev bat0
>  --> deletes the bat0 interface
>=20
> Used: Debian stable (squeeze) with original kernel (linux-iamge-2.6.32-5-=
686, version 2.6.32-46)
> batctl (2012.1.0-1) and iproute (20120521-3) from wheezy=20
>=20
> So no difference noticed here. :)
>=20
> I've checked back with iproute package from squeeze (20120521-3):
>  * "ip link add dev bat0 type batadv" still works
>  * "ip link set dev eth0 master bat0" throws an error and does nothing:
> Error: either "dev" is duplicate, or "master" is a garbage.
>=20
> so to summarize: it compiles again, batctl works, and ip at least allows =
to add the bat0
> interface but adding interfaces into a softiface using ip doesn't.
>=20
> Hope that helps!
> Cheers,
> 	Simon
>=20
> Tested-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

Thank you very much Simon! :)
This is what we expected.

Cheers,


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--uWCTLymdFNG0vGYZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRLSmgAAoJEADl0hg6qKeO/3oQAJ5ll6XobVO/iMh9vZhV8xJr
/2zZ3Z9szPbbrEf2gz2o2/xtU0QUM7vVu3cTOvEvLC8c4I52zVsoFV92ruoKrY7r
NNXqPS5YYZYEjjN6KMq4bE8yrgeASAMBCmy0trrNjUBwUMbYqA4gV/j4Z+mOzgOl
IHNz8V4m7+C+Ve8KwQQCZweGLmjqaTtcsWuPnPxKGezun4kUuvrS6oJ1pkP/sVLE
rPQC0Mem/HK119tZmFtLHShQCkDO/Vpk3n1HxYLJ71p7LpkQgE3xlp6f9JTu7qoc
FHr6iwOMQ7K3yFju79xMmqT69z4M4qQTDg6ZurFTJYGmSFvKwXfKQmkdt1fwnkqB
7/jPMrj14bfQ4EoecvIighEvSQU3tK4Y5pVtQDIMMdTqHRVBhdnTuHYHswp+63HV
smu6bAHL78XDaCglfqNTfl8JJaTogWnVgxs+4sbkkM2n9Y3l1iaE+5sxoPeumr+b
e3xBRnsY/nzX5FB3sOaPOQzI4eHDWrx9ZY98lMHbVbsyalcr7npm9+Py4cN8HXP2
WDBiZARvf4fjIpfJArQ164w296StyBnu1CwkW0OJgFwZx4Ym1rCfmQBusiRXfY4S
MvXxz6Vz/Q+FhhynOQp/b1arUzq93V1tDNfOlAI7lw9sUZ2SfxwuV6+YUafCyLZG
q3KF0f09qEg4A+1AySLR
=Uzqn
-----END PGP SIGNATURE-----

--uWCTLymdFNG0vGYZ--
