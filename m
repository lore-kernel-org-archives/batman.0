Return-Path: <a@unstable.cc>
Date: Thu, 28 Jan 2016 12:06:38 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160128040638.GE22112@prodigo.lan>
References: <1453953259-30022-1-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ey/N+yb7u/X9mFhi"
Content-Disposition: inline
In-Reply-To: <1453953259-30022-1-git-send-email-andrew@lunn.ch>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batctl: Add support for network
	namespaces
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Andrew Lunn <andrew@lunn.ch>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--ey/N+yb7u/X9mFhi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 28, 2016 at 04:54:19AM +0100, Andrew Lunn wrote:
> When running within a network namespace, access to files within
> debugfs have to take into account the network name space. Each
> namespace has its own directory under
> /sys/kernel/debug/batman_adv/netns.

Thanks for providing the batctl patch Andrew.

What do you think about documenting this feature in the README file as well?
Imho a few words in the "How does it work?" section plus an example on how =
to
use it would be really nice!


Cheers,

--=20
Antonio Quartulli

--ey/N+yb7u/X9mFhi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWqZPOAAoJENpFlCjNi1MRTx8P/2YFTW/vs1bbVDNPP/TTTubj
9j0IvyB8pNxXzLpDXMHCM9OQDTacLxhwXZ8r8snVin2J8tcdiRMN79aJk0Y+iwHA
YGRgq3k7JF6MQOBopcKrBmNMRfAdNro0xpkJXJJfwfWR22B160XrqhPyOb1nhD4y
VjhibDEpAu9vLqTzJ5WfrF2kifDRNx9kuq9dQnCS3pKStilmfKW0ngz2kfWm0wJI
vV8ptDNwghk1+JJeO9ErX/3qL/znvK1ByITupAq2mwOj2IRlU7JjLPn4JU3adM5b
w6sqxsfnHDbom1b89SOycsuif6LoBQqA5CxysSAkp9YBBKSdEM2q2P0KzQOD9J+m
GIDspfTJcuz80RUXJkDwgRSIn2RUrcGmK3OfKg5KriiR/04uKXkVAZc0SgrjPKEL
ufV3CnTqkly4vZT4Dz2qAkA0sQSkspb+1qBEFcaxaomITAd8iwV4j+WYMuPi20FD
tJwBMPLfm4VxHym7zExyPbxeyrrwXZHP8lb0ulvh06S7B2jffhn4m/lzj3/5g7KF
jDzoiluBuAEZhzrb3kPDi+zUdq5HBljJtlwqVV/dYOT2KGir+hZKA9wdgLGFEZbE
fJWiClbZc3iV9lL2TGRHzrwRKik1ksPPlBjWuaR9GRUDOmpUYcU6M7QR5u/ibU2G
2rHEJE6q3hoe3+8A/ltf
=HF/j
-----END PGP SIGNATURE-----

--ey/N+yb7u/X9mFhi--
