Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Wed, 12 Jun 2013 12:14:11 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20130612101411.GA13323@pandem0nium>
References: <1370848318-18755-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
In-Reply-To: <1370848318-18755-1-git-send-email-linus.luessing@web.de>
Subject: Re: [B.A.T.M.A.N.] Basic Multicast Optimizations
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


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

I gave it a try - but there seems something off. What I did is:
 * apply your patches on 3b38a80 - multicast was enabled by default
 * start 2 VMs directly connected
 * ping6 -I bat0 ff02::1

I only got a reply locally, but not from the peer. When I disabled
multicast, I got two replies from the local host and the peer.

As far as I have tracked the problem down, it appears that
batadv_mcast_forw_mode() returns 1 correctly, but the packet is dropped
later in the process - I would guess that this happens in
batadv_send_generic_unicast_skb() where we try to select the gateway
when the destination mac is multicast instead of looking it up in the
tt table. But I leave the details to you. :)

The rest looks good, but I'll review more deeply again when it's
actually working. It does compile without problems now.

Cheers,
	Simon

On Mon, Jun 10, 2013 at 09:11:55AM +0200, Linus L=C3=BCssing wrote:
> This is the fourth revision of the basic multicast optimization patches.
>=20
> It adds a missing enum keyword to the return type of a mcast_forw_mode().
>=20
> Cheers, Linus

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlG4SfMACgkQrzg/fFk7axbDZwCg4pqgVUjeety0REGyRznmiSED
jl8AoNHximWVXYDl6uUkd2nDu5yHJgUj
=YYjP
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
