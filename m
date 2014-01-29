Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 29 Jan 2014 14:53:49 +0800
Message-ID: <1410522.xVbSBtgclD@diderot>
In-Reply-To: <1390816116-23804-7-git-send-email-linus.luessing@web.de>
References: <1390816116-23804-1-git-send-email-linus.luessing@web.de>
 <1390816116-23804-7-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1661973.7NAp50ygfb";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 6/6] batman-adv: Send multicast packets
	to nodes with a WANT_ALL flag
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


--nextPart1661973.7NAp50ygfb
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Monday 27 January 2014 10:48:36 Linus L=FCssing wrote:
>  /**
> + * batadv_mcast_want_all_count - number of nodes with unspecific mca=
st
> interest + * @bat_priv: the bat priv with all the soft interface
> information + * @ethhdr: ethernet header of a packet
> + * @want_all_list: pointer to a mcast want list in our bat_priv
> + *
> + * Return the number of nodes which want all IPv4 multicast traffic =
if
> + * the given ethhdr is from an IPv4 packet or the number of nodes wh=
ich
> want + * all IPv6 traffic if it matches an IPv6 packet and set the
> want_list to the + * according one in our bat_priv. For other frame t=
ypes
> leave the want_list + * untouched and return zero.
> + */
> +static int batadv_mcast_want_all_count(struct batadv_priv *bat_priv,=

> +=09=09=09=09       struct ethhdr *ethhdr,
> +=09=09=09=09       struct hlist_head **want_all_list)
> +{
> +=09int ret;
> +
> +=09switch (ntohs(ethhdr->h_proto)) {
> +=09case ETH_P_IP:
> +=09=09ret =3D atomic_read(&bat_priv->mcast.num_want_all_ipv4);
> +=09=09if (ret)
> +=09=09=09*want_all_list =3D &bat_priv->mcast.want_all_ipv4_list;
> +=09=09break;
> +=09case ETH_P_IPV6:
> +=09=09ret =3D atomic_read(&bat_priv->mcast.num_want_all_ipv6);
> +=09=09if (ret)
> +=09=09=09*want_all_list =3D &bat_priv->mcast.want_all_ipv6_list;
> +=09=09break;
> +=09default:
> +=09=09/* we shouldn't be here... */
> +=09=09ret =3D 0;
> +=09}
> +
> +=09return ret;
> +}

As far as I can tell the want_all list is returned through 3 different=20=

functions to end up in batadv_mcast_want_all_node_get() where the code =
checks=20
again for IPv4 vs IPv6. Wouldn't be much easier to make a simple IPv4/I=
Pv6 in=20
that function to retrieve the list ? Or better,=20
batadv_mcast_want_all_ipv4_node_get() / batadv_mcast_want_all_ipv6_node=
_get()=20
get bat_priv passed and use the correct list ? I see no need to pass th=
e list=20
around.


>  /**
> + * batadv_mcast_want_all_ipv4_node_get - get an orig_node with
> want_all_ipv4 + * @head: list of originators that want all IPv4 multi=
cast
> traffic + *
> + * Return the first orig_node from the given want_all_ipv4 list. Inc=
reases
> + * the refcount of the returned orig_node.
> + */
> +static struct batadv_orig_node *
> +batadv_mcast_want_all_ipv4_node_get(struct hlist_head *head)
> +{
> +=09struct batadv_orig_node *orig_node =3D NULL;
> +
> +=09rcu_read_lock();
> +=09hlist_for_each_entry_rcu(orig_node, head,
> +=09=09=09=09 mcast_want_all_ipv4_node) {
> +=09=09if (atomic_inc_not_zero(&orig_node->refcount))
> +=09=09=09break;
> +=09}
> +=09rcu_read_unlock();
> +
> +=09return orig_node;
> +}
> +
> +/**
> + * batadv_mcast_want_all_ipv6_node_get - get an orig_node with
> want_all_ipv6 + * @head: list of originators that want all IPv6 multi=
cast
> traffic + *
> + * Return the first orig_node from the given want_all_ipv6 list. Inc=
reases
> + * the refcount of the returned orig_node.
> + */
> +static struct batadv_orig_node *
> +batadv_mcast_want_all_ipv6_node_get(struct hlist_head *head)
> +{
> +=09struct batadv_orig_node *orig_node =3D NULL;
> +
> +=09rcu_read_lock();
> +=09hlist_for_each_entry_rcu(orig_node, head,
> +=09=09=09=09 mcast_want_all_ipv6_node) {
> +=09=09if (atomic_inc_not_zero(&orig_node->refcount))
> +=09=09=09break;
> +=09}
> +=09rcu_read_unlock();
> +
> +=09return orig_node;
> +}

Both functions have the same crucial bug. What will the function return=
 if we=20
have on entry in the list but are unable to increment the refcount ?


> +/**
> + * batadv_mcast_list_add - grab a lock and add a node to a head
> + * @node: the node to add
> + * @head: the head to add the node to
> + * @lock: the lock to grab while adding the node to the head
> + */
> +static void batadv_mcast_list_add(struct hlist_node *node,
> +=09=09=09=09  struct hlist_head *head,
> +=09=09=09=09  spinlock_t *lock)
> +{
> +=09spin_lock_bh(lock);
> +=09hlist_add_head_rcu(node, head);
> +=09spin_unlock_bh(lock);
> +}
> +
> +/**
> + * batadv_mcast_list_del - grab a lock and delete a node from its li=
st
> + * @node: the node to delete from its list
> + * @lock: the lock to grab while deleting the node from its list
> + */
> +static void batadv_mcast_list_del(struct hlist_node *node, spinlock_=
t
> *lock) +{
> +=09spin_lock_bh(lock);
> +=09hlist_del_rcu(node);
> +=09spin_unlock_bh(lock);
> +}
> +
> +/**
> + * batadv_mcast_list_update - update the list of a flag
> + * @flag: the flag we want to update the list for
> + * @node: a list node of an originator
> + * @head: the list head the node might be added to
> + * @lock: the lock that synchronizes list modifications
> + * @new_flags: the new capability bitset of a node
> + * @old_flags: the current, to be updated bitset of a node
> + *
> + * Update the list of the given node/head with the help of the new f=
lag
> + * information of an originator to contain the nodes which have the =
given
> + * flag set.
> + */
> +static void batadv_mcast_list_update(uint8_t flag,
> +=09=09=09=09     struct hlist_node *node,
> +=09=09=09=09     struct hlist_head *head,
> +=09=09=09=09     spinlock_t *lock,
> +=09=09=09=09     uint8_t new_flags, int old_flags)
> +{
> +=09if (new_flags & flag && !(old_flags & flag))
> +=09=09batadv_mcast_list_add(node, head, lock);
> +=09else if (!(new_flags & flag) && old_flags & flag)
> +=09=09batadv_mcast_list_del(node, lock);
> +}

Didn't we agree on banishing batadv_mcast_list_update() a while ago ?


> +/**
> + * batadv_mcast_want_all_node_get - get an orig_node with an mcast w=
ant
> list
> + * @want_all_list: list of originators that want all IPv4 or IPv6 mc=
ast
> traffic + * @bat_priv: the bat priv with all the soft interface infor=
mation
> + *
> + * Return the first orig_node from the given want_all list. Increase=
s the
> + * refcount of the returned orig_node.
> + */
> +struct batadv_orig_node *
> +batadv_mcast_want_all_node_get(struct hlist_head *want_all_list,
> +                              struct batadv_priv *bat_priv)
> +{
> +       if (want_all_list =3D=3D &bat_priv->mcast.want_all_ipv4_list)=

> +               return batadv_mcast_want_all_ipv4_node_get(want_all_l=
ist);
> +       else if (want_all_list =3D=3D &bat_priv->mcast.want_all_ipv6_=
list)
> +               return batadv_mcast_want_all_ipv6_node_get(want_all_l=
ist);
> +       else
> +               return NULL;
> +}

In case there is a good reason to keep this function: bat_priv should b=
e the=20
first argument.


> +/**
> + * batadv_send_skb_via_mcast - send an skb to a node with a WANT_ALL=
 flag
> + * @bat_priv: the bat priv with all the soft interface information
> + * @skb: payload to send
> + * @vid: the vid to be used to search the translation table
> + * @want_all_list: a list of originators with a WANT_ALL flag
> + *
> + * Get an originator node from the want_all_list. Wrap the given skb=
 into a
> + * batman-adv unicast header and send this frame to this node.
> + */
> +int batadv_send_skb_via_mcast(struct batadv_priv *bat_priv,
> +=09=09=09      struct sk_buff *skb, unsigned short vid,
> +=09=09=09      struct hlist_head *want_all_list)
> +
> +{
> +=09struct batadv_orig_node *orig_node;
> +
> +=09orig_node =3D batadv_mcast_want_all_node_get(want_all_list, bat_p=
riv);
> +=09return batadv_send_skb_unicast(bat_priv, skb, BATADV_UNICAST, 0,
> +=09=09=09=09       orig_node, vid);
> +}

Maybe I am missing the whole point of WANT_ALL but why do we maintain a=
 list=20
of WANT_ALL nodes to only send the packet to the first valid entry in t=
he list?

Cheers,
Marek

--nextPart1661973.7NAp50ygfb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJS6KWBAAoJEFNVTo/uthzAk88H/2qbwsWC+aByFEJSbzvDpoSt
jXAomC932hQVyqpUMbNKVFc1LEYyIbFXSH5AolFggmKpnIGKgNe8EHNxQu2Wv3j3
S7JPBAo0xF8J9AmjRzXuMML67WnQoVGPwMU2qJYqLTyf+Qu1oo2xk1qLGud2439o
xEQbskXKD2K/UhCLIR1pnKY7TelXq7jv+Q+yDs7nmQw6PPlM0ISgDROX4r2swOVt
k7+7bc475mZVzYY8YysgUr9lxl1jNO4JOxIiRm+76vPyWaJpsI3+lWDkyMZdsKQN
Htslrc+vNL7mSuryRJHHoCItm966P5NlCAICkvXKifdCUWfYvGMXWJGiEZcrKG4=
=nagj
-----END PGP SIGNATURE-----

--nextPart1661973.7NAp50ygfb--

