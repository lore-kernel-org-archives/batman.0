Return-Path: <a@unstable.cc>
Date: Tue, 26 Jan 2016 20:53:14 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160126125314.GA25892@prodigo>
References: <1453312110-32683-1-git-send-email-andrew@lunn.ch>
 <1453312110-32683-4-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
In-Reply-To: <1453312110-32683-4-git-send-email-andrew@lunn.ch>
Subject: Re: [B.A.T.M.A.N.] [PATCH 3/4] batman-adv: Handle parent interfaces
 in a different netns
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


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 20, 2016 at 06:48:29PM +0100, Andrew Lunn wrote:
>  /**
> + * batadv_mutual_parents - check if two devices are each others parent
> + * @net_dev - 1st parent
> + * @parent_dev - 2nd parent
> + *
> + * veth devices come in pairs and each is the parent of the other!
> + *
> + * Return true if the devices are each others parent, otherwise false

Andrew, minor style issue: you should put the ':' after the word Return.
Please check the other comments in this file as example. Sven recently chan=
ged
all the comments to be coherent with this style.

Other than this, the patch looks good to me.
You can add my

Acked-by: Antonio Quartulli <a@untable.cc>

--=20
Antonio Quartulli

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWp2w6AAoJENpFlCjNi1MRJ1UP/0E5B/pMK3N2so2GAFpm079U
UMz32dtqm/l5EQgyOQbtcKafc1MwyRzi7L3KDL8CMXrSREgoGmlasb7701SC39WO
9lbtlK0vfYR6A6CYzYHo3ACPe8zEVZGEgawY5vvJgqnNMeccpD786+Ju7PQ4R66d
0DEEFGUvx2WzHkVSCq9INd8+NlkeixLg6N3bKRPSjJi2nmGF0bsMI+AsHn7nZh7z
FMx+cRzKlm2wp5RuueFcjhGMaf+SXKhRNf0ArDvIArhQKlmzIYbA0yxDQUwybNwK
oednEavs6Wqg4OuitVvSGF/p3/GH9Rbsa3nhfaG+nkimnHx/3A4NnaJQvaKmDsvU
iBV1X7iKSimgKblWdaFku8qYeMtoPIo6Pksf9VUEBHq0t76B1pvma7Dfz8rEQZr9
OgUCAgODbsvnZfbdqUmZkNXmPGZxgMs5oahWNwLbVYmzv6DKho56jrhCmuGz4k/4
xsLTWqkHnltTH5kM+ICA0WRb1nXvmJ6EzME7LNfihzdANFKgaGuWfoPgUOgXSvWs
epGeW/PRxr1tYNWSDfC6zvf2/t/ylQ9VK5xMU2ITvHAIdETrwtV64ggcmeTRRirn
UQDPqBz1iBJ2WNzeVE2pRkVDXSvfIZ1PGQKi2Wfp1j0ynOg+coCZL0Aa7/uWgiHL
0Cizk3BfEnqiIoWQxs69
=iSzI
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
