Return-Path: <antonio.quartulli@open-mesh.com>
Date: Tue, 3 May 2016 01:53:59 +0800
From: Antonio Quartulli <antonio.quartulli@open-mesh.com>
Message-ID: <20160502175359.GA11201@prodigo.lan>
References: <1459508076-29674-1-git-send-email-sven@open-mesh.com>
 <1459508076-29674-3-git-send-email-sven@open-mesh.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="huLXOlJ1ghGp/P5+"
Content-Disposition: inline
In-Reply-To: <1459508076-29674-3-git-send-email-sven@open-mesh.com>
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 3/3] batman-adv: throughput meter
 implementation
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
Cc: Sven Eckelmann <sven.eckelmann@open-mesh.com>


--huLXOlJ1ghGp/P5+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Sven,

a comment is inline.

On Fri, Apr 01, 2016 at 12:54:36PM +0200, Sven Eckelmann wrote:

[...]

> +/**
> + * batadv_tp_send - main sending thread of a tp meter session
> + * @arg: address of the related tp_vars
> + *
> + * Return: nothing, this function never returns
> + */
> +static int batadv_tp_send(void *arg)
> +{
> +	struct batadv_tp_vars *tp_vars =3D3D arg;
> +	struct batadv_priv *bat_priv =3D3D tp_vars->bat_priv;
> +	struct batadv_hard_iface *primary_if =3D3D NULL;
> +	struct batadv_orig_node *orig_node =3D3D NULL;
> +	size_t payload_len, packet_len;
> +	int err =3D3D 0;
> +
> +	if (unlikely(tp_vars->role !=3D3D BATADV_TP_SENDER)) {
> +		err =3D3D BATADV_TP_DST_UNREACHABLE;
> +		goto out;
> +	}
> +
> +	orig_node =3D3D batadv_orig_hash_find(bat_priv, tp_vars->other_end);
> +	if (unlikely(!orig_node)) {
> +		err =3D3D BATADV_TP_DST_UNREACHABLE;
> +		goto out;
> +	}
> +
> +	primary_if =3D3D batadv_primary_if_get_selected(bat_priv);
> +	if (unlikely(!primary_if)) {
> +		err =3D3D BATADV_TP_DST_UNREACHABLE;
> +		goto out;
> +	}

in case of error we modify err and then we jump to out, but:

[...]

> +out:
> +	if (likely(primary_if))
> +		batadv_hardif_put(primary_if);
> +	if (likely(orig_node))
> +		batadv_orig_node_put(orig_node);
> +
> +	batadv_tp_sender_end(bat_priv, tp_vars);
> +	batadv_tp_sender_cleanup(bat_priv, tp_vars);
> +
> +	batadv_tp_vars_put(tp_vars);
> +
> +	do_exit(0);
> +}

shouldn't we propagate the value saved in err to tp_vars->reason ?

We found this error while using the tp_meter, because we tried to run it
against a non-existing originator and batctl crashed.


Cheers,


--=20
Antonio Quartulli

--huLXOlJ1ghGp/P5+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXJ5Q3AAoJEJ4aZjxxc6bKekEP/1n2t+K4BwcIeupYr2MXBWhJ
njaVQyUa9CTWATwjGwSDoy3v4JtOgaN1dZedbk1wWR3dfBMjwll/r9yUGUviVfnm
o9TQRCzxdu//ph3282LFq/BD5bDLwFgaX22905ccmQL9Jr1+Ic/+hUcgIp9teqef
jusWZDoh4ghqQ5FOEoZM2TDtSXdSDNPM7QtlIEITAK4LOVHwjIf6cMvCJ9Pufn8a
UhUxM4Bru5pdJg0lL44fBJAluX1GCoc14Zowt6+J5y7SNCUSSayL1p4NqR+PSTC9
mwv+Z3RdhPmLVqpq9DZx6D13xDy3/my/heXzLhkeV5IRIVtski8UhDfgHalBJ65n
wiYWFMHqjbwrlTFDQNx6Zad0MhSbufnZbh1KSLeYFNGDPoNh9IZsAVlvig9zPKKs
rnqJtbr1XqQFSn9i0JyLTGrgsw0656Y3G6JvkgBcEuxyjBweu7e3qA6Jv3fARgJq
ILabk29v13gdVBHd0wvZ2t0ty17wYODfKTjbpxtta8QSBfY/JgQ4tUFCSl9vxIcE
xpJXdx2Mr5raOjCdt6CLuY0aZBT2untsA23wXGfe1P72wbFvLoEGqASi4/9Qov70
HAdJynyCxZABd8LDsSjPVWzfadZYCSXUwG6fQKHqzAJ5QBfrem9vg3wnpl3635zB
taki8dLrdzEwsPH/Jm4A
=G20Z
-----END PGP SIGNATURE-----

--huLXOlJ1ghGp/P5+--
