Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 26 Jan 2019 11:47:20 +0100
Message-ID: <1895931.G10psR3j26@sven-edge>
In-Reply-To: <20190119155626.6414-1-sven@narfation.org>
References: <20190119155626.6414-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2078636.AB73lCBlle";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [RFC v4 00/19] batman-adv: netlink restructuring, part 2
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
Cc: Jiri Pirko <jiri@mellanox.com>, netdev@vger.kernel.org, linus.luessing@c0d3.blue

--nextPart2078636.AB73lCBlle
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Saturday, 19 January 2019 16.56.07 CET Sven Eckelmann wrote:
[...]
> There were also two topics which were not yet really discussed and thus
> these requests (from Linus) were not yet implemented:

@Jiri, @Linus maybe you can discuss these topics further and select the=20
correct solution.

> * convert BATADV_ATTR_MULTICAST_MODE_ENABLED to an u32 and let don't hand=
le
>   it like a boolean. Instead use it to select how multicast traffic has to
>   be handled:
>  =20
>   - 0: ignore multicast optimization and just flood it like broadcast
>     traffic
>   - 1: enabled multicast optimization
>   - 2: undefined but also some kind of multicast optimization
>   - 3: undefined but also some kind of multicast of optimization
>   - ...

Multicast mode is currently defined.

* according to batctl manpage:

    multicast_mode|mm [0|1]
           If no parameter is given the current multicast mode set=E2=80=90
           ting is displayed. Otherwise the parameter is used to en=E2=80=90
           able or disable multicast optimizations (i.e. disabling
           means always sending own multicast frames via classic
           flooding).

* according to sysfs ABI:

   What:           /sys/class/net/<mesh_iface>/mesh/multicast_mode
   Date:           Feb 2014
   Contact:        Linus L=C3=BCssing <linus.luessing@web.de>
   Description:
                   Indicates whether multicast optimizations are enabled
                   or disabled. If set to zero then all nodes in the
                   mesh are going to use classic flooding for any
                   multicast packet with no optimizations.

Both define it as boolean value and therefore it was converted to a boolean=
=20
value (via u8) in netlink.

But Linus now suggested that it is actually an u32. Most likely 0 =3D=3D to=
=20
something like BATADV_MULTICAST_MODE_FLOODING. But I have no idea what 1 is=
 or=20
what 2, 3, 4, .. would be. So I need some input here.

And Jiri said that it should be renamed to BATADV_ATTR_MULTICAST_ENABLED -
which seems to suggest that he doesn't like the idea of a u32 for some reas=
on
and prefers to use a boolean value.

And now Linus even said that it should be a bit field - which makes it even=
=20
more vague to me and I have now absolutely no idea what should be implement=
ed.

* BIT 0 for flooding vs ?
* BIT 1 for ?
* ...

> * convert BATADV_ATTR_AGGREGATION_OGM_ENABLED to u32 and use it
>   to mark which type of traffic should be aggregated:
>=20
>   - bit 0: enable aggregation of OGM(2)s
>   - bit 1: yet undefined packet type which allows some kind of aggregation
>   - bit 2: yet undefined packet type which allows some kind of aggregation
>   - ...

Aggregated OGM is currently defined as:


* according to batctl manpage:

    aggregation|ag [0|1]
           If no parameter is given the current aggregation setting
           is displayed. Otherwise the parameter is used to enable or
           disable OGM packet aggregation.

* according to sysfs ABI:

    What:           /sys/class/net/<mesh_iface>/mesh/aggregated_ogms
    Date:           May 2010
    Contact:        Marek Lindner <mareklindner@neomailbox.ch>
    Description:
                    Indicates whether the batman protocol messages of the
                    mesh <mesh_iface> shall be aggregated or not.

So sysfs is only one possible backend for the batctl command. There is=20
currently nothing which I would assume to be aggregatable beside OGMs but l=
et=20
us assume for now that there is now something and some way to aggregate thi=
ngs=20
beside OGMs in a save and backward compatible way. Let's call this FOO - so=
 we=20
have BATADV_ATTR_AGGREGATION_OGM_ENABLED and=20
BATADV_ATTR_AGGREGATION_FOO_ENABLED. Or we have BATADV_ATTR_AGGREGATION as =
an=20
u32 and just use the second bit as marker for FOO (and of course the first =
bit=20
as marker for OGM).

Would it now be more preferable to use BATADV_ATTR_AGGREGATION_OGM_ENABLED =
as=20
u8 (boolean) or to to switch to BATADV_ATTR_AGGREGATION (u32) & assign sing=
le=20
bits to packet types.

Kind regards,
	Sven
--nextPart2078636.AB73lCBlle
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlxMOrgACgkQXYcKB8Em
e0bDyA/8CnhVEH1Z182f4Dmj5zKS6xRxNgvsqI7T+MLeEt/OiRxp6MKy2QYXuwSj
E64qBVTwsYjKM8d+U2g/+sskKfCQZJwa9C8+/hbCq8Id+nX95OD7RHUHh2GVWaJC
eFakm4lt1Ehp2ImeLjMth9NWBGG7hsObQrxeCAu6+DLGASDAL96dxBSH338GgAva
P3+nuT+HDjlrNfHd75pUEheO4LsMehHaet8wFyElJ0zldn+6izGjYMvucL5vvoT9
Aibw/4Rrk+7X8RyjQHGHp5bIUC6H8zwxwlZHU+r4Cztfn6nlx2O+ZwKQO6tPb8US
Ml2mnYsw/+GtAuZQgqzErYHu0MgbofRpqBbEcE2Hw60Wgd45SdNFM8X5N4/UMuvu
90X6lwkS7tulMXV0AfvtIO4dkcX1GsRcMoHT3EeeOoRJyU0xplHLn4OZ7eetk89o
p/+lN9naor+kayy8uM3RREKHJc+WMsmVpvgO4G7WikE/AHJJb1vPnDu4frSV1mbA
k+F79v8R5XIbhP/gVfxy5Alt8YUcohnn3dbxFfw+fzZgVFf0bxKu8XXxoex4ZUaA
8HzAtFKjlOkkPmekQ4HIgzSdk2crC35Ax/SG2HfBDTvQT4EovwBPe4n7jGYV4ZCW
PfpdcL07IbFEhLkZG1xEnc8aL5JRMyKK6pj76Nw6Kfm3rNyGwyw=
=oyAF
-----END PGP SIGNATURE-----

--nextPart2078636.AB73lCBlle--



