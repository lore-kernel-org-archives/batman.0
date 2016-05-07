Return-Path: <a@unstable.cc>
Date: Sat, 7 May 2016 17:15:14 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160507091514.GC3907@prodigo.lan>
References: <1462566429-26709-1-git-send-email-sven@narfation.org>
 <1656407.PytZZyZNAi@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jL2BoiuKMElzg3CS"
Content-Disposition: inline
In-Reply-To: <1656407.PytZZyZNAi@sven-edge>
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: Fix double
 neigh_node_put in batadv_v_ogm_route_update
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


--jL2BoiuKMElzg3CS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 07, 2016 at 09:03:13AM +0200, Sven Eckelmann wrote:
> On Friday 06 May 2016 22:27:09 Sven Eckelmann wrote:
> > The router is put down twice when it was non-NULL and either orig_ifinf=
o is
> > NULL afterwards or batman-adv receives a packet with the same sequence
> > number. This will end up in a use-after-free when the batadv_neigh_node=
 is
> > removed because the reference counter ended up too early at 0.
> >=20
> > Fixes: 667996ebeab4 ("batman-adv: OGMv2 - implement originators logic")
> > Signed-off-by: Sven Eckelmann <sven@narfation.org>
> [...]
>=20
> There is a conflict with master. I hope that Antonio can share how it can=
 be
> resolved when he submits following remaining fixes to David:
>=20
>  * batman-adv: Fix integer overflow in batadv_iv_ogm_calc_tq
>  * batman-adv: Avoid duplicate neigh_node additions
>  * batman-adv: make sure ELP/OGM orig MAC is updated on address change
>  * batman-adv: Fix unexpected free of bcast_own on add_if error
>  * batman-adv: Avoid nullptr derefence in batadv_v_neigh_is_sob
>  * batman-adv: Fix refcnt leak in batadv_v_neigh_*
>  * batman-adv: Fix double neigh_node_put in batadv_v_ogm_route_update
>=20
> The solution for the merge conflict with master is:
>=20
> --- a/net/batman-adv/bat_v_ogm.c
> +++ b/net/batman-adv/bat_v_ogm.c
> @@ -510,17 +510,10 @@
>                 goto out;
>         }
> =20
> -<<<<<<<
>         /* Mark the OGM to be considered for forwarding, and update routes
>          * if needed.
>          */
>         forward =3D true;
> -=3D=3D=3D=3D=3D=3D=3D
> -       if (router) {
> -               batadv_neigh_node_put(router);
> -               router =3D NULL;
> -       }
> ->>>>>>>
> =20
>         batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
>                    "Searching and updating originator entry of received p=
acket\n");

Thanks a lot for this.

Cheers,

--=20
Antonio Quartulli

--jL2BoiuKMElzg3CS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXLbIiAAoJEJ4aZjxxc6bKSdQQAMIZf0GnZ2Sy4s17IQWSEAsg
LsoEFFPXkXqt3BUhp9sp0sQGcHPOC2RVOtELLQ7Ei/t+GKkoJWZNinn+3pIeSqmz
FRcmKxqJDCAQtzOVQe2DD1Z0jNVIEEncSMCHv+trDB53EprQzAJVw3W4GJyJkTyW
Vw432WjQBRjIdBATFUIe96Hon7DKaIg6NX8la8Qhez3QCW2BwiXpqi9PHzpQpHTv
gaTIjAzYfTreHkdyhyGvMfO9xBoUXLxuhSnsgUYYZncJMJwXJQnlGFS7v5nichUo
mYtwob8ZeK5ZX8xa9EaZK9mk6CilRRy7p3V1kAGlQSbQ8pWzhM2YeA75Qv1Q5QkV
ry2B6vEZ1KgmCLKdnO4VcGFyQJoE3FpM4TG+1HUiuPJlK2B0jm7udJDfMeDnCspc
obcljk8zMBeBnNzraWgDGyxcBvjaOGXGZc2ze13xFFxSR/zkYKifaMBz5HAEj/UN
ggVUuz4Jc5BV23couJ+BH3AZ62d8Rsvt6ENjZh/GZtlW0MbyTkIwnbUOxU5IkiAN
PPfyiVml584MhQnkaesjYY6TC1X+iY27OuzHBU7f/iL/5gru3PtX3iyDoet5Zjot
qBIpA9C8DhvKgid68X+5g5zAaiMLUWoF/P19H59YWXzgc8GiohfzcBA/EUg1vFxi
QXLauTzATJgPMPRR0YXL
=maGb
-----END PGP SIGNATURE-----

--jL2BoiuKMElzg3CS--
