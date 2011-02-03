Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 3 Feb 2011 18:56:37 +0100
References: <1296668238-19323-1-git-send-email-linus.luessing@ascom.ch>
	<1296744201-11542-1-git-send-email-linus.luessing@ascom.ch>
In-Reply-To: <1296744201-11542-1-git-send-email-linus.luessing@ascom.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4133594.CVSjBksrfP";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201102031856.39736.sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: Correct rcu refcounting
	for gw_node
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Linus =?iso-8859-1?q?L=FCssing?= <linus.luessing@ascom.ch>

--nextPart4133594.CVSjBksrfP
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> For another the rcu protected macros rcu_dereference() and
> rcu_assign_pointer() for the bat_priv->curr_gw and curr_gw->orig_node
> need to be used.

What? Since when is curr_gw::orig_node rcu protected?

> -	return curr_gateway_tmp->orig_node;
> +	orig_node =3D rcu_dereference(curr_gateway_tmp->orig_node);
> +	if (orig_node) {
> +		rcu_read_unlock();
> +		return NULL;
> +	}
> +
> +	rcu_read_unlock();
> +	return orig_node;
>  }


And you cannot return the (it is not, but when it would be) rcu protected=20
element without increasing the refcounter.

> +		orig_node =3D rcu_dereference(gw_node->orig_node);
> +		if (!orig_node->router)
>  			continue;

Same here

> -	if (bat_priv->curr_gw !=3D curr_gw_tmp) {
> -		if ((bat_priv->curr_gw) && (!curr_gw_tmp))
> +	if (curr_gw !=3D curr_gw_tmp) {
> +		orig_node =3D rcu_dereference(curr_gw_tmp->orig_node);
> +		if ((curr_gw) && (!curr_gw_tmp))

And here

> -	if (bat_priv->curr_gw !=3D curr_gw_tmp) {
> -		if ((bat_priv->curr_gw) && (!curr_gw_tmp))
> +	if (curr_gw !=3D curr_gw_tmp) {
> +		orig_node =3D rcu_dereference(curr_gw_tmp->orig_node);
> +		if ((curr_gw) && (!curr_gw_tmp))

Here again

> -	if (bat_priv->curr_gw !=3D curr_gw_tmp) {
> -		if ((bat_priv->curr_gw) && (!curr_gw_tmp))
> +	if (curr_gw !=3D curr_gw_tmp) {
> +		orig_node =3D rcu_dereference(curr_gw_tmp->orig_node);
> +		if ((curr_gw) && (!curr_gw_tmp))

Here....

> -	gw_bandwidth_to_kbit(gw_node->orig_node->gw_flags, &down, &up);
> +	rcu_read_lock();
> +	curr_gw =3D rcu_dereference(bat_priv->curr_gw);
> +	orig_node =3D rcu_dereference(gw_node->orig_node);
> +	gw_bandwidth_to_kbit(orig_node->gw_flags, &down, &up);

=2E...

> diff --git a/batman-adv/unicast.c b/batman-adv/unicast.c
> index 6a9ab61..8816102 100644
> --- a/batman-adv/unicast.c
> +++ b/batman-adv/unicast.c
> @@ -298,7 +298,6 @@ int unicast_send_skb(struct sk_buff *skb, struct
> bat_priv *bat_priv) if (!orig_node)
>  			goto trans_search;
>=20
> -		kref_get(&orig_node->refcount);
>  		goto find_router;
>  	} else {
>  		rcu_read_lock();

Why? Maybe this should be part of the patch 3/3?

And please to merge the refcounting stuff with the rcu pointer in one patch=
=2E..=20
and maybe it is better to merge patch 2/3 with the rcu pointer patch.

Best regards,
	Sven

--nextPart4133594.CVSjBksrfP
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJNSuxWAAoJEF2HCgfBJntGunoQALWqBlie8LIvK87vxLkPAf9h
dqyEqDVGuRz6dWHdiVou8wes/Tw10sWrGXnjRL9Kzd3aCclqYqLPRvwIG0dShibj
i0B18UbUJoUkM6lkQDXxQJ/xQQFoCedGfzxc5cUJEt8ISJ8eyWT5Nwh8w+wuP/JV
ybcgIZ5D5CZMGL8uwmFXEeLSTXmbPqFnw8qukQXC/2jRJbQN9P7Yr6Yaw322P1vF
70AtYW6FTqW19bsk66zpdSyx1A/C2K/K2cDzv6tqr6W4vBRT5DIXWwIuhBNx9Cp4
Hx3WUIsEJDCaP29l/wXGBJmpLOZmn0MvjUh8LBTcdA/15VDWSON8svVK2ClCtajX
NfaUQFYnuK3qaRR34EHO74lxhQ4h86C34As+j9YNxbWFcuNWC9kKo4E0hG+rWyvN
B9UBtK5riAULpL1HZRTcWW18Fs8f0e5NIZXdSpTk4FNLMNUOYv9lMJIgimufn95X
5T0yJ/xL9hE5JmqYPOBv3jd8gGqdQsShA2rinWZJijgOqS9Kdp0fe1xD0M5YATEA
UWdFrZaLU1SVBLKDTJHlkF6PxQJ2FRBOTDRnybwY/F5G8Q9gSbUMIkb+10z6f0Pl
mW6lawnWqUjDbTiE+dZ6AVFZJsfCCGV1dOAoXKZVSMDAMM4GkqZF++G1KdacJtup
vu4HfwugYC5HettCZR3n
=MjKU
-----END PGP SIGNATURE-----

--nextPart4133594.CVSjBksrfP--
