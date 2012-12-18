Return-Path: <ordex@autistici.org>
Date: Tue, 18 Dec 2012 23:54:55 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20121218225455.GD23011@ritirata.org>
References: <cover.1355466678.git.martin@hundeboll.net>
 <67167faccab90f98beb606e16b5234c0e0b9ad21.1355466678.git.martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="wULyF7TL5taEdwHz"
Content-Disposition: inline
In-Reply-To: <67167faccab90f98beb606e16b5234c0e0b9ad21.1355466678.git.martin@hundeboll.net>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 3/7] batman-adv: Detect coding nodes
 and remove these after timeout
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
Cc: Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@hundeboll.net>


--wULyF7TL5taEdwHz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 14, 2012 at 07:32:48 +0100, Martin Hundeb=C3=B8ll wrote:
[...]

> +/**
> + * batadv_nc_purge_orig_nc_nodes - go through list of nc nodes and purge=
 stale
> + *  entries
> + * @bat_priv: the bat priv with all the soft interface information
> + * @list: list of nc nodes
> + * @lock: nc node list lock
> + * @to_purge: function in charge to decide whether an entry has to be pu=
rged or
> + *	      not. This function takes the nc node as argument and has to ret=
urn
> + *	      a boolean value: true is the entry has to be deleted, false

typo here? is -> if ?

> + *	      otherwise
> + */
> +static void
> +batadv_nc_purge_orig_nc_nodes(struct batadv_priv *bat_priv,
> +			      struct list_head *list,
> +			      spinlock_t *lock,
> +			      bool (*to_purge)(struct batadv_priv *,
> +					       struct batadv_nc_node *))

[...]

>  /**
> + * batadv_can_nc_with_orig - checks whether the given orig node is suita=
ble for
> + *  coding or not
> + * @bat_priv: the bat priv with all the soft interface information
> + * @orig_node: neighboring orig node which may be used as nc candidate
> + * @ogm_packet: incoming ogm packet also used for the checks
> + *
> + * Returns true if:
> + *  1) The OGM must have the most recent sequence number.
> + *  2) The TTL must be incremented by one and only one.

mh..should be decremented here? or maybe I misunderstood the condition.

> + *  3) The OGM must be received from the first hop from orig_node.
> + *  4) The TQ value of the OGM must be above bat_priv->nc.min_tq.
> + */
> +static bool batadv_can_nc_with_orig(struct batadv_priv *bat_priv,
> +				    struct batadv_orig_node *orig_node,
> +				    struct batadv_ogm_packet *ogm_packet)
> +{
> +	if (orig_node->last_real_seqno !=3D ogm_packet->seqno)
> +		return false;
> +	if (orig_node->last_ttl !=3D ogm_packet->header.ttl + 1)
> +		return false;
> +	if (!batadv_compare_eth(ogm_packet->orig, ogm_packet->prev_sender))
> +		return false;
> +	if (ogm_packet->tq < bat_priv->nc.min_tq)
> +		return false;
> +
> +	return true;
> +}

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--wULyF7TL5taEdwHz
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQ0PQ/AAoJEADl0hg6qKeOoN4P/0uK/tqgpDnLbH5Y+m1CLN85
WISEF6aNOkbdEzNjmq2bgEQHU+el/jxmAiKSe+ZGRYqggoHT2Uq+lcUd2fsTQqse
vh75t1CyFvsiBdoJu7KQ/HPjBPYFSD+k8hmcFRtO1fOfVYv4oIsD7A3AGpd3aITH
b8o6FKIjrutCZtBBsrpmtLmAPO1oq+ySuxC3v+lqMBCtdEABHzkjX5aoaDrnZzOj
Loikwucfdj0bIvxUpBqQn8evIoxgbwRi6unau+Ll12SrIPJYmI6LcFE2Nq3Hzfq+
TLSdjeyQ+6SDAYKL839JLPLVQMudFcPHQZd6fNGXxGKpa+UfvzxmFvAKxgOeAmWQ
jk0qQgXhH1Gh1zbllI4u8veSOI+PFDyQD0GbvhEU3ZvPmT6c57K9Xe/s9kXORnUf
+NdaTpZP5J/KKu5HPdohoalxaZxqjOZGu5VHHlRjeY2/710VyfN/J+X8vZvxu2bA
pQiYN3UHfxfkoKt9CM2ysI8Px3LLm4p59STNAYnW454QxwI+zS+EQwQ6MV5n2A4I
O2A+Eiy3aCxpMJvEqAJWKkhFAxH6r6ZNINYN6Pse73bUF9shLo8dO2ll2FR8UeBJ
IXinAayQYWu1IkBznJiHq7zMJaKx2doGes56CB5JcLVdQkP1fNTqyjxTJm6JaLvQ
pl7YifnMJl2b4bTjGrkk
=bY7A
-----END PGP SIGNATURE-----

--wULyF7TL5taEdwHz--
