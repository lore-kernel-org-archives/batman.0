Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 9 Feb 2012 15:59:06 +0800
References: <1328727958-16119-1-git-send-email-martin@hundeboll.net>
In-Reply-To: <1328727958-16119-1-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201202091559.07197.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [RFC] batman-adv: Add filtering of OGM messages
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Thursday, February 09, 2012 03:05:58 Martin Hundeb=C3=B8ll wrote:
> For testing purposes, forcing specific paths in a network where all
> nodes are within reach, can be useful. This patch allows the use to
> enter addresses from which direct OGMs should be ignored.
>=20
> An address is added by echoing it into
> /sys/class/net/bat0/filter_add_addr and removed again by echoing the
> same address into /sys/class/net/bat0/filter_del_addr. The list of
> currently blocked direct OGM sources is available in
> /sys/kernel/debug/batman-adv/bat0/filter_table.

In addition to what Antonio has already pointed out:


> diff --git a/bat_sysfs.c b/bat_sysfs.c
> index 3adb183..0fc5e3e 100644
> --- a/bat_sysfs.c
> +++ b/bat_sysfs.c
> @@ -27,6 +27,7 @@
>  #include "gateway_common.h"
>  #include "gateway_client.h"
>  #include "vis.h"
> +#include "filter.h"
>=20
>  static struct net_device *kobj_to_netdev(struct kobject *obj)
>  {
> @@ -384,11 +385,49 @@ static ssize_t store_gw_bwidth(struct kobject *kobj,
> struct attribute *attr, return gw_bandwidth_set(net_dev, buff, count);
>  }

It might be better to move filter_add/filter_del into debugfs. There we hav=
e=20
less "regulation rules" and more freedom when it comes to the syntax and wh=
at=20
we add. It is for debugging purposes anyways.

Do you plan to add more "filters" in the future ? Otherwise I'd rather call=
 it=20
"block_orig/unblock_orig". Seems more obvious than the generic "filter".


> +	if ((res =3D filter_parse_addr_str(buff, count, mac)) < 0) {
> +		bat_info(net_dev, "Address has invalid format: %s\n", buff);
> +		return res;

Is there no existing kernel function for the mac address parsing ?


> +void filter_addr_add(struct bat_priv *bat_priv, const uint8_t *addr)
> +{
> +	struct orig_node *orig_node =3D orig_hash_find(bat_priv, addr);
> +
> +	if (!orig_node)
> +		return;
> +
> +	atomic_set(&orig_node->filter, FILTER_TRUE);
> +	orig_node_free_ref(orig_node);
> +}

This will only allow blocking an originator if it is already there. What if=
 I=20
configure my node before the mesh is up ? For example via scripts ?

Cheers,
Marek
