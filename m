Return-Path: <antonio@meshcoding.com>
Message-ID: <52E6174B.1070101@meshcoding.com>
Date: Mon, 27 Jan 2014 09:22:35 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1390553883-1940-1-git-send-email-antonio@meshcoding.com>
 <5373996.23YD93TvXH@diderot>
In-Reply-To: <5373996.23YD93TvXH@diderot>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="acC05h1k5PUfnIpRjfEnbIuggiW2o3r9x"
Subject: Re: [B.A.T.M.A.N.] [PATCH next] batman-adv: avoid potential race
 condition when adding a new neighbour
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
To: b.a.t.m.a.n@lists.open-mesh.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--acC05h1k5PUfnIpRjfEnbIuggiW2o3r9x
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 27/01/14 09:10, Marek Lindner wrote:
> On Friday 24 January 2014 09:58:03 Antonio Quartulli wrote:
>> @@ -281,14 +281,23 @@ batadv_iv_ogm_neigh_new(struct batadv_hard_iface=

>> *hard_iface, neigh_node->orig_node =3D orig_neigh;
>>  	neigh_node->if_incoming =3D hard_iface;
>>
>> -	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
>> -		   "Creating new neighbor %pM for orig_node %pM on interface %s\n",=

>> -		   neigh_addr, orig_node->orig, hard_iface->net_dev->name);
>> -
>>  	spin_lock_bh(&orig_node->neigh_list_lock);
>> -	hlist_add_head_rcu(&neigh_node->list, &orig_node->neigh_list);
>> +	tmp_neigh_node =3D batadv_neigh_node_get(orig_node, hard_iface,
>> +					       neigh_addr);
>> +	if (!tmp_neigh_node) {
>> +		hlist_add_head_rcu(&neigh_node->list, &orig_node->neigh_list);
>> +	} else {
>> +		kfree(neigh_node);
>> +		neigh_node =3D tmp_neigh_node;
>> +	}
>=20
> What about hard_iface->refcount ?

True.
hard_iface must be released if we found an already existent neighbour.
I'll put a batadv_hardif_free_ref(hard_iface); right after the
kfree(neigh_node);.

>=20
>=20
>>  /**
>> + * batadv_neigh_node_get - retrieve a neighbour from the list
>> + * @orig_node: originator which the neighbour belongs to
>> + * @hard_iface: the interface where this neighbour is connected to
>> + * @addr: the address of the neighbour
>> + *
>> + * Looks for and possibly return a neighbour belonging to this origin=
ator
>> list + * which is connected through the provided hard interface.
>=20
> 'Looks and return' does not work. Either 'look and return' or 'looks an=
d=20
> returns'.

Yap, thanks!


I'll send v2 soon!

--=20
Antonio Quartulli


--acC05h1k5PUfnIpRjfEnbIuggiW2o3r9x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJS5hdPAAoJEEKTMo6mOh1Vwb0P/R+1Se/wlgwU33m/y7NpQP1t
us87jQuJZ/ayJvXAHKPMJExt5CzhvhVWL4QOwOR/zrqUdWxF8LOxkGmxOb6S3FXb
W2AcGOT3ltIUAYCZcfZy8u9ROISlH9szoGKJ2Jpct+GK6T+pW2H4gHIEK8SFEsBX
iBz/RbyNa4obr6Xl2AZGjUPivRqWYW2JC1EPV00qeqpM4pyvV703pIKPFArlO2Ok
pGPT9SbIGiZedJPKjV4SyvGU2DxPmFs3wPZZJbOn/d1WPc4SFCrYrT5gWsQGYZP/
TZQIB5++KBBKFVq/kGFEBYf9JA9IUAnYA7vc0Pm+Ykakybyu/l7xUlez/D41/SYg
ce6CHCWM5JYwhIsH1IW6fF+HZPK9bjuoUsOGW481a81TVzGvtwQCKMZxscCKHBTl
qMpOZSmTqfn3p21D9k6AkFL/UxiT/0JAWijW/+kWd//Oz0IU6yYMGQn/0qSnWjs7
a9QUSkPzFsOjVbnVSCm85EH4HI/VQX78PPLHHadGYhr+I98XtUPNrliRnzjeWnKp
f9tEssj/EXs+yLw9Zkj5RKWcyU+WoGsWvSDJm9D7B6iTBjbjsoH+jpCBVM0CDNzr
BjeBQFw0oaSTcsh5UxHhzj/B5UpaJJD+k0bsaksft8sNEUCmFONimjdma+q3D4Gc
FC/RQxyD7d6NFXhCvnqi
=Brk4
-----END PGP SIGNATURE-----

--acC05h1k5PUfnIpRjfEnbIuggiW2o3r9x--
