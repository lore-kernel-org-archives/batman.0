Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sun, 17 Jan 2010 21:15:58 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20100117201558.GA8696@pandem0nium>
References: <20100104182710.GA24091@pandem0nium>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
In-Reply-To: <20100104182710.GA24091@pandem0nium>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Add bonding functionality
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

i've just committed this patch in revision 1551, as no further comments and=
 critiques
came in. I would consider this patch rather simple, and as experimental fea=
ture it
is switched off by default anyways ... :)

I've changed only a small thing in the committed patch: When neighbors are =
purged,
the bonding candidate list gets updated instead of bonding switched off.

best regards,
	Simon
On Mon, Jan 04, 2010 at 07:27:10PM +0100, Simon Wunderlich wrote:
> This patch introduces bonding functionality to batman-advanced, targeted=
=20
> for the 0.3 release. As we are able to route the payload traffic as we=20
> want, we may use multiple interfaces on multihomed hosts to transfer data=
=20
> to achieve higher bandwidth. This can be considered as "light Multi Path=
=20
> Routing" for single hop connections.
>=20
> To detect which interfaces of a peer node belong to the same host, a     =
=20
> new flag PRIMARIES_FIRST_HOP is introduced. This flag is set on the first=
 hop
> of OGMs of the primary (first) interface, which is broadcasted on all  =
=20
> interfaces. When receiving such an OGM, we can learn which interfaces
> belong to the same host (by assigning them to the primary originator).
>=20
> Bonding works by sending packets in a round-robin fashion to the available
> neighbors, if multiple interfaces are available. The neighbors should be
> almost equally good to reach.
>=20
> To avoid interferences (i.e. sending on the same channel), only neighbors=
=20
> with different mac addresses and interfaces are considered as candidates.
>=20
> Bonding is deactivated by default, and can be activated by=20
>=20
> echo 1 > /proc/net/batman-adv/bonding
>=20
> for each individual node.
>=20
> Any suggestions or comments are welcome.
>=20
> Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
> ---
>=20
> Index: a/batman-adv-kernelland/types.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/batman-adv-kernelland/types.h	(revision 1532)
> +++ b/batman-adv-kernelland/types.h	(working copy)
> @@ -48,6 +48,7 @@
> =20
>  struct orig_node {               /* structure for orig_list maintaining =
nodes of mesh */
>  	uint8_t orig[ETH_ALEN];
> +	uint8_t primary_addr[ETH_ALEN];	/* hosts primary interface address */
>  	struct neigh_node *router;
>  	struct batman_if *batman_if;
>  	TYPE_OF_WORD *bcast_own;
> @@ -64,6 +65,10 @@
>  	TYPE_OF_WORD bcast_bits[NUM_WORDS];
>  	uint16_t last_bcast_seqno;  /* last broadcast sequence number received =
by this host */
>  	struct list_head neigh_list;
> +	struct {
> +		uint8_t candidates;	/* how many candidates are available */
> +		struct neigh_node *selected;	/* next bonding candidate */
> +	} bond;
>  };
> =20
>  struct neigh_node {
> @@ -74,6 +79,7 @@
>  	uint8_t tq_index;
>  	uint8_t tq_avg;
>  	uint8_t last_ttl;
> +	struct neigh_node *next_bond_candidate;
>  	unsigned long last_valid;            /* when last packet via this neigh=
bor was received */
>  	TYPE_OF_WORD real_bits[NUM_WORDS];
>  	struct orig_node *orig_node;
> Index: a/batman-adv-kernelland/packet.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/batman-adv-kernelland/packet.h	(revision 1532)
> +++ b/batman-adv-kernelland/packet.h	(working copy)
> @@ -31,6 +31,7 @@
>  #define COMPAT_VERSION 8
>  #define DIRECTLINK 0x40
>  #define VIS_SERVER 0x20
> +#define PRIMARIES_FIRST_HOP 0x10
> =20
>  /* ICMP message types */
>  #define ECHO_REPLY 0
> Index: a/batman-adv-kernelland/send.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/batman-adv-kernelland/send.c	(revision 1532)
> +++ b/batman-adv-kernelland/send.c	(working copy)
> @@ -275,9 +275,9 @@
>  	batman_packet->seqno =3D htons((uint16_t)atomic_read(&batman_if->seqno)=
);
> =20
>  	if (is_vis_server())
> -		batman_packet->flags =3D VIS_SERVER;
> +		batman_packet->flags |=3D VIS_SERVER;
>  	else
> -		batman_packet->flags =3D 0;
> +		batman_packet->flags &=3D ~VIS_SERVER;
> =20
>  	/* could be read by receive_bat_packet() */
>  	atomic_inc(&batman_if->seqno);
> @@ -332,6 +332,8 @@
> =20
>  	batman_packet->seqno =3D htons(batman_packet->seqno);
> =20
> +	/* switch of primaries first hop flag when forwarding */
> +	batman_packet->flags &=3D ~PRIMARIES_FIRST_HOP;
>  	if (directlink)
>  		batman_packet->flags |=3D DIRECTLINK;
>  	else
> Index: a/batman-adv-kernelland/proc.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/batman-adv-kernelland/proc.c	(revision 1532)
> +++ b/batman-adv-kernelland/proc.c	(working copy)
> @@ -35,6 +35,7 @@
>  static struct proc_dir_entry *proc_transt_global_file;
>  static struct proc_dir_entry *proc_vis_srv_file, *proc_vis_data_file;
>  static struct proc_dir_entry *proc_aggr_file;
> +static struct proc_dir_entry *proc_bond_file;
> =20
>  static int proc_interfaces_read(struct seq_file *seq, void *offset)
>  {
> @@ -462,6 +463,53 @@
>  	return single_open(file, proc_aggr_read, NULL);
>  }
> =20
> +static int proc_bond_read(struct seq_file *seq, void *offset)
> +{
> +	seq_printf(seq, "%i\n", atomic_read(&bonding_enabled));
> +
> +	return 0;
> +}
> +
> +static ssize_t proc_bond_write(struct file *file, const char __user *buf=
fer,
> +			       size_t count, loff_t *ppos)
> +{
> +	char *bond_string;
> +	int not_copied =3D 0;
> +	unsigned long bonding_enabled_tmp;
> +	int retval;
> +
> +	bond_string =3D kmalloc(count, GFP_KERNEL);
> +
> +	if (!bond_string)
> +		return -ENOMEM;
> +
> +	not_copied =3D copy_from_user(bond_string, buffer, count);
> +	bond_string[count - not_copied - 1] =3D 0;
> +
> +	retval =3D strict_strtoul(bond_string, 10, &bonding_enabled_tmp);
> +
> +	if (retval || bonding_enabled_tmp > 1) {
> +		printk(KERN_ERR "batman-adv: Bonding can only be enabled (1) or disabl=
ed (0), given value: %li\n", bonding_enabled_tmp);
> +	} else {
> +		printk(KERN_INFO "batman-adv:Changing bonding from: %s (%i) to: %s (%l=
i)\n",
> +		       (atomic_read(&bonding_enabled) =3D=3D 1 ?
> +			"enabled" : "disabled"),
> +		       atomic_read(&bonding_enabled),
> +		       (bonding_enabled_tmp =3D=3D 1 ? "enabled" : "disabled"),
> +		       bonding_enabled_tmp);
> +		atomic_set(&bonding_enabled,
> +						(unsigned)bonding_enabled_tmp);
> +	}
> +
> +	kfree(bond_string);
> +	return count;
> +}
> +
> +static int proc_bond_open(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, proc_bond_read, NULL);
> +}
> +
>  /* satisfying different prototypes ... */
>  static ssize_t proc_dummy_write(struct file *file, const char __user *bu=
ffer,
>  				size_t count, loff_t *ppos)
> @@ -478,6 +526,15 @@
>  	.release	=3D single_release,
>  };
> =20
> +static const struct file_operations proc_bond_fops =3D {
> +	.owner		=3D THIS_MODULE,
> +	.open		=3D proc_bond_open,
> +	.read		=3D seq_read,
> +	.write		=3D proc_bond_write,
> +	.llseek		=3D seq_lseek,
> +	.release	=3D single_release,
> +};
> +
>  static const struct file_operations proc_vis_srv_fops =3D {
>  	.owner		=3D THIS_MODULE,
>  	.open		=3D proc_vis_srv_open,
> @@ -567,6 +624,10 @@
>  	if (proc_aggr_file)
>  		remove_proc_entry(PROC_FILE_AGGR, proc_batman_dir);
> =20
> +	if (proc_bond_file)
> +		remove_proc_entry(PROC_FILE_BOND, proc_batman_dir);
> +
> +
>  	if (proc_batman_dir)
>  #ifdef __NET_NET_NAMESPACE_H
>  		remove_proc_entry(PROC_ROOT_DIR, init_net.proc_net);
> @@ -671,5 +732,15 @@
>  		return -EFAULT;
>  	}
> =20
> +	proc_bond_file =3D create_proc_entry(PROC_FILE_BOND, S_IWUSR | S_IRUGO,
> +					   proc_batman_dir);
> +	if (proc_bond_file) {
> +		proc_bond_file->proc_fops =3D &proc_bond_fops;
> +	} else {
> +		printk(KERN_ERR "batman-adv: Registering the '/proc/net/%s/%s' file fa=
iled\n", PROC_ROOT_DIR, PROC_FILE_BOND);
> +		cleanup_procfs();
> +		return -EFAULT;
> +	}
> +
>  	return 0;
>  }
> Index: a/batman-adv-kernelland/proc.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/batman-adv-kernelland/proc.h	(revision 1532)
> +++ b/batman-adv-kernelland/proc.h	(working copy)
> @@ -34,6 +34,7 @@
>  #define PROC_FILE_VIS_SRV "vis_server"
>  #define PROC_FILE_VIS_DATA "vis_data"
>  #define PROC_FILE_AGGR "aggregate_ogm"
> +#define PROC_FILE_BOND "bonding"
> =20
>  void cleanup_procfs(void);
>  int setup_procfs(void);
> Index: a/batman-adv-kernelland/soft-interface.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/batman-adv-kernelland/soft-interface.c	(revision 1532)
> +++ b/batman-adv-kernelland/soft-interface.c	(working copy)
> @@ -22,6 +22,7 @@
>  #include "main.h"
>  #include "soft-interface.h"
>  #include "hard-interface.h"
> +#include "routing.h"
>  #include "send.h"
>  #include "translation-table.h"
>  #include "types.h"
> @@ -170,11 +171,14 @@
>  	return 0;
>  }
> =20
> +
> +
>  int interface_tx(struct sk_buff *skb, struct net_device *dev)
>  {
>  	struct unicast_packet *unicast_packet;
>  	struct bcast_packet *bcast_packet;
>  	struct orig_node *orig_node;
> +	struct neigh_node *router;
>  	struct ethhdr *ethhdr =3D (struct ethhdr *)skb->data;
>  	struct bat_priv *priv =3D netdev_priv(dev);
>  	struct batman_if *batman_if;
> @@ -227,37 +231,36 @@
>  		if (!orig_node)
>  			orig_node =3D transtable_search(ethhdr->h_dest);
> =20
> -		if ((orig_node) &&
> -		    (orig_node->batman_if) &&
> -		    (orig_node->router)) {
> -			if (my_skb_push(skb, sizeof(struct unicast_packet)) < 0)
> -				goto unlock;
> +		router =3D find_router(orig_node);
> =20
> -			unicast_packet =3D (struct unicast_packet *)skb->data;
> +		if (!router)
> +			goto unlock;
> =20
> -			unicast_packet->version =3D COMPAT_VERSION;
> -			/* batman packet type: unicast */
> -			unicast_packet->packet_type =3D BAT_UNICAST;
> -			/* set unicast ttl */
> -			unicast_packet->ttl =3D TTL;
> -			/* copy the destination for faster routing */
> -			memcpy(unicast_packet->dest, orig_node->orig, ETH_ALEN);
> +		/* don't lock while sending the packets ... we therefore
> +		 * copy the required data before sending */
> =20
> -			/* net_dev won't be available when not active */
> -			if (orig_node->batman_if->if_active !=3D IF_ACTIVE)
> -				goto unlock;
> +		batman_if =3D router->if_incoming;
> +		memcpy(dstaddr, router->addr, ETH_ALEN);
> =20
> -			/* don't lock while sending the packets ... we therefore
> -			 * copy the required data before sending */
> +		spin_unlock_irqrestore(&orig_hash_lock, flags);
> =20
> -			batman_if =3D orig_node->batman_if;
> -			memcpy(dstaddr, orig_node->router->addr, ETH_ALEN);
> -			spin_unlock_irqrestore(&orig_hash_lock, flags);
> +		if (batman_if->if_active !=3D IF_ACTIVE)
> +			goto dropped;
> =20
> -			send_skb_packet(skb, batman_if, dstaddr);
> -		} else {
> -			goto unlock;
> -		}
> +		if (my_skb_push(skb, sizeof(struct unicast_packet)) < 0)
> +			goto dropped;
> +
> +		unicast_packet =3D (struct unicast_packet *)skb->data;
> +
> +		unicast_packet->version =3D COMPAT_VERSION;
> +		/* batman packet type: unicast */
> +		unicast_packet->packet_type =3D BAT_UNICAST;
> +		/* set unicast ttl */
> +		unicast_packet->ttl =3D TTL;
> +		/* copy the destination for faster routing */
> +		memcpy(unicast_packet->dest, orig_node->orig, ETH_ALEN);
> +
> +		send_skb_packet(skb, batman_if, dstaddr);
>  	}
> =20
>  	priv->stats.tx_packets++;
> Index: a/batman-adv-kernelland/hard-interface.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/batman-adv-kernelland/hard-interface.c	(revision 1532)
> +++ b/batman-adv-kernelland/hard-interface.c	(working copy)
> @@ -312,9 +312,9 @@
>  	batman_packet =3D (struct batman_packet *)(batman_if->packet_buff);
>  	batman_packet->packet_type =3D BAT_PACKET;
>  	batman_packet->version =3D COMPAT_VERSION;
> -	batman_packet->flags =3D 0x00;
> -	batman_packet->ttl =3D (batman_if->if_num > 0 ? 2 : TTL);
> -	batman_packet->flags =3D 0;
> +	batman_packet->flags =3D batman_if->if_num > 0 ?
> +			0x00 : PRIMARIES_FIRST_HOP;
> +	batman_packet->ttl =3D batman_if->if_num > 0 ? 2 : TTL;
>  	batman_packet->tq =3D TQ_MAX_VALUE;
>  	batman_packet->num_hna =3D 0;
> =20
> Index: a/batman-adv-kernelland/originator.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/batman-adv-kernelland/originator.c	(revision 1532)
> +++ b/batman-adv-kernelland/originator.c	(working copy)
> @@ -221,10 +221,15 @@
>  			orig_node->orig, (orig_node->last_valid / HZ));
>  		return true;
>  	} else {
> -		if (purge_orig_neighbors(orig_node, &best_neigh_node))
> +		if (purge_orig_neighbors(orig_node, &best_neigh_node)) {
>  			update_routes(orig_node, best_neigh_node,
>  				      orig_node->hna_buff,
>  				      orig_node->hna_buff_len);
> +			/* set bonding candidates to zero. Will be updated
> +			 * at the next incoming packet for this originator. */
> +
> +			orig_node->bond.candidates =3D 0;
> +		}
>  	}
>  	return false;
>  }
> Index: a/batman-adv-kernelland/main.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/batman-adv-kernelland/main.c	(revision 1532)
> +++ b/batman-adv-kernelland/main.c	(working copy)
> @@ -45,6 +45,7 @@
>  atomic_t originator_interval;
>  atomic_t vis_interval;
>  atomic_t aggregation_enabled;
> +atomic_t bonding_enabled;
>  int16_t num_hna;
>  int16_t num_ifs;
> =20
> @@ -85,6 +86,7 @@
>  	atomic_set(&vis_interval, 1000);/* TODO: raise this later, this is only
>  					 * for debugging now. */
>  	atomic_set(&aggregation_enabled, 1);
> +	atomic_set(&bonding_enabled, 0);
> =20
>  	/* the name should not be longer than 10 chars - see
>  	 * http://lwn.net/Articles/23634/ */
> Index: a/batman-adv-kernelland/routing.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/batman-adv-kernelland/routing.c	(revision 1532)
> +++ b/batman-adv-kernelland/routing.c	(working copy)
> @@ -352,6 +352,106 @@
>  	return is_duplicate;
>  }
> =20
> +/* mark possible bonding candidates in the neighbor list */
> +static void update_bonding(struct orig_node *orig_node,
> +				struct orig_node *orig_neigh_node,
> +				struct batman_packet *batman_packet)
> +{
> +	int candidates;
> +	int interference_candidate;
> +	int best_tq;
> +	struct neigh_node *tmp_neigh_node, *tmp_neigh_node2;
> +    struct neigh_node *first_candidate, *last_candidate;
> +
> +	/* don't care if bonding is not enabled */
> +	if (!atomic_read(&bonding_enabled)) {
> +		orig_node->bond.candidates =3D 0;
> +		return;
> +	}
> +
> +	if (batman_packet->flags & PRIMARIES_FIRST_HOP)
> +		memcpy(orig_neigh_node->primary_addr,
> +						orig_node->orig, ETH_ALEN);
> +	 else
> +		return;
> +
> +	/* update the candidates for this originator */
> +	if (!orig_node->router) {
> +		orig_node->bond.candidates =3D 0;
> +		return;
> +	}
> +
> +	best_tq =3D orig_node->router->tq_avg;
> +
> +	/* update bonding candidates */
> +
> +	candidates =3D 0;
> +
> +	/* mark other nodes which also received "PRIMARIES FIRST HOP" packets
> +	 * as "bonding partner" */
> +
> +	/* first, zero the list */
> +	list_for_each_entry(tmp_neigh_node, &orig_node->neigh_list, list) {
> +		tmp_neigh_node->next_bond_candidate =3D NULL;
> +	}
> +
> +	first_candidate =3D NULL;
> +	last_candidate =3D NULL;
> +	list_for_each_entry(tmp_neigh_node, &orig_node->neigh_list, list) {
> +
> +		/* only consider if it has the same primary address ...  */
> +		if (memcmp(orig_node->orig,
> +				tmp_neigh_node->orig_node->primary_addr,
> +				ETH_ALEN) !=3D 0)
> +			continue;
> +
> +		/* ... and is good enough to be considered */
> +		if (tmp_neigh_node->tq_avg < best_tq - BONDING_TQ_THRESHOLD)
> +			continue;
> +
> +		/* check if we have another candidate with the same
> +		 * mac address or interface. If we do, we won't
> +		 * select this candidate because of possible interference. */
> +
> +		interference_candidate =3D 0;
> +		list_for_each_entry(tmp_neigh_node2,
> +				&orig_node->neigh_list, list) {
> +
> +			if (tmp_neigh_node2 =3D=3D tmp_neigh_node)
> +				continue;
> +
> +			if ((tmp_neigh_node->if_incoming =3D=3D
> +				tmp_neigh_node2->if_incoming)
> +				|| (memcmp(tmp_neigh_node->addr,
> +				tmp_neigh_node2->addr, ETH_ALEN) =3D=3D 0)) {
> +
> +				interference_candidate =3D 1;
> +				break;
> +			}
> +		}
> +		/* don't care further if it is an interference candidate */
> +		if (interference_candidate)
> +			continue;
> +
> +		if (first_candidate =3D=3D NULL) {
> +			first_candidate =3D tmp_neigh_node;
> +			tmp_neigh_node->next_bond_candidate =3D first_candidate;
> +		} else
> +			tmp_neigh_node->next_bond_candidate =3D last_candidate;
> +
> +		last_candidate =3D tmp_neigh_node;
> +
> +		candidates++;
> +	}
> +
> +	if (candidates > 0) {
> +		first_candidate->next_bond_candidate =3D last_candidate;
> +		orig_node->bond.selected =3D first_candidate;
> +	}
> +
> +	orig_node->bond.candidates =3D candidates;
> +}
> +
>  void receive_bat_packet(struct ethhdr *ethhdr,
>  				struct batman_packet *batman_packet,
>  				unsigned char *hna_buff, int hna_buff_len,
> @@ -518,6 +618,8 @@
>  		update_orig(orig_node, ethhdr, batman_packet,
>  			    if_incoming, hna_buff, hna_buff_len, is_duplicate);
> =20
> +	update_bonding(orig_node, orig_neigh_node, batman_packet);
> +
>  	/* is single hop (direct) neighbor */
>  	if (is_single_hop_neigh) {
> =20
> @@ -788,16 +890,67 @@
>  	return ret;
>  }
> =20
> +/* find a suitable router for this originator, and use
> + * bonding if possible. */
> +struct neigh_node *find_router(struct orig_node *orig_node)
> +{
> +	struct orig_node *primary_orig_node;
> +	struct orig_node *router_orig;
> +	struct neigh_node *router;
> +	static uint8_t zero_mac[ETH_ALEN] =3D {0, 0, 0, 0, 0, 0};
> +
> +	if (!orig_node)
> +		return NULL;
> +
> +	if (!orig_node->router)
> +		return NULL;
> +
> +	/* don't care if bonding is not enabled */
> +	if (!atomic_read(&bonding_enabled))
> +		return orig_node->router;
> +
> +	router_orig =3D orig_node->router->orig_node;
> +
> +	/* if we have something in the primary_addr, we can search
> +	 * for a potential bonding candidate. */
> +	if (memcmp(router_orig->primary_addr, zero_mac, ETH_ALEN) =3D=3D 0)
> +		return orig_node->router;
> +
> +	/* find the orig_node which has the primary interface. might
> +	 * even be the same as our orig_node in many cases */
> +
> +	primary_orig_node =3D hash_find(orig_hash, router_orig->primary_addr);
> +	if (!primary_orig_node)
> +		return orig_node->router;
> +
> +	/* with less than 2 candidates, we can't do any
> +	 * bonding and prefer the original router. */
> +
> +	if (primary_orig_node->bond.candidates < 2)
> +		return orig_node->router;
> +
> +	router =3D primary_orig_node->bond.selected;
> +
> +	/* sanity check - this should never happen. */
> +	if (!router)
> +		return orig_node->router;
> +
> +	/* select the next bonding partner ... */
> +	primary_orig_node->bond.selected =3D router->next_bond_candidate;
> +
> +	return router;
> +}
> +
>  int recv_unicast_packet(struct sk_buff *skb)
>  {
>  	struct unicast_packet *unicast_packet;
>  	struct orig_node *orig_node;
> +	struct neigh_node *router;
>  	struct ethhdr *ethhdr;
>  	struct batman_if *batman_if;
>  	struct sk_buff *skb_old;
>  	uint8_t dstaddr[ETH_ALEN];
>  	int hdr_size =3D sizeof(struct unicast_packet);
> -	int ret;
>  	unsigned long flags;
> =20
>  	/* drop packet if it has not necessary minimum size */
> @@ -832,42 +985,43 @@
>  		return NET_RX_DROP;
>  	}
> =20
> -	ret =3D NET_RX_DROP;
>  	/* get routing information */
>  	spin_lock_irqsave(&orig_hash_lock, flags);
>  	orig_node =3D ((struct orig_node *)
>  		     hash_find(orig_hash, unicast_packet->dest));
> =20
> -	if ((orig_node !=3D NULL) &&
> -	    (orig_node->batman_if !=3D NULL) &&
> -	    (orig_node->router !=3D NULL)) {
> +	router =3D find_router(orig_node);
> =20
> -		/* don't lock while sending the packets ... we therefore
> -		 * copy the required data before sending */
> -		batman_if =3D orig_node->batman_if;
> -		memcpy(dstaddr, orig_node->router->addr, ETH_ALEN);
> -		spin_unlock_irqrestore(&orig_hash_lock, flags);
> +	if (!router) {
> +		spin_lock_irqsave(&orig_hash_lock, flags);
> +		return NET_RX_DROP;
> +	}
> =20
> -		/* create a copy of the skb, if needed, to modify it. */
> -		if (!skb_clone_writable(skb, sizeof(struct unicast_packet))) {
> -			skb_old =3D skb;
> -			skb =3D skb_copy(skb, GFP_ATOMIC);
> -			if (!skb)
> -				return NET_RX_DROP;
> -			unicast_packet =3D (struct unicast_packet *) skb->data;
> -			kfree_skb(skb_old);
> -		}
> -		/* decrement ttl */
> -		unicast_packet->ttl--;
> +	/* don't lock while sending the packets ... we therefore
> +	 * copy the required data before sending */
> =20
> -		/* route it */
> -		send_skb_packet(skb, batman_if, dstaddr);
> -		ret =3D NET_RX_SUCCESS;
> +	batman_if =3D router->if_incoming;
> +	memcpy(dstaddr, router->addr, ETH_ALEN);
> =20
> -	} else
> -		spin_unlock_irqrestore(&orig_hash_lock, flags);
> +	spin_unlock_irqrestore(&orig_hash_lock, flags);
> =20
> -	return ret;
> +	/* create a copy of the skb, if needed, to modify it. */
> +	if (!skb_clone_writable(skb, sizeof(struct unicast_packet))) {
> +		skb_old =3D skb;
> +		skb =3D skb_copy(skb, GFP_ATOMIC);
> +		if (!skb)
> +			return NET_RX_DROP;
> +		unicast_packet =3D (struct unicast_packet *) skb->data;
> +		kfree_skb(skb_old);
> +	}
> +
> +	/* decrement ttl */
> +	unicast_packet->ttl--;
> +
> +	/* route it */
> +	send_skb_packet(skb, batman_if, dstaddr);
> +
> +	return NET_RX_SUCCESS;
>  }
> =20
> =20
> Index: a/batman-adv-kernelland/main.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/batman-adv-kernelland/main.h	(revision 1532)
> +++ b/batman-adv-kernelland/main.h	(working copy)
> @@ -58,6 +58,11 @@
>  #define LOG_BUF_LEN 8192	  /* has to be a power of 2 */
>  #define ETH_STR_LEN 20
> =20
> +/* how much worse secondary interfaces may be to
> + * to be considered as bonding candidates */
> +
> +#define BONDING_TQ_THRESHOLD	50
> +
>  #define MAX_AGGREGATION_BYTES 512 /* should not be bigger than 512 bytes=
 or
>  				   * change the size of
>  				   * forw_packet->direct_link_flags */
> @@ -131,6 +136,7 @@
>  extern atomic_t originator_interval;
>  extern atomic_t vis_interval;
>  extern atomic_t aggregation_enabled;
> +extern atomic_t bonding_enabled;
>  extern int16_t num_hna;
>  extern int16_t num_ifs;
> =20
> Index: a/batman-adv-kernelland/routing.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/batman-adv-kernelland/routing.h	(revision 1532)
> +++ b/batman-adv-kernelland/routing.h	(working copy)
> @@ -38,3 +38,4 @@
>  int recv_vis_packet(struct sk_buff *skb);
>  int recv_bat_packet(struct sk_buff *skb,
>  				struct batman_if *batman_if);
> +struct neigh_node *find_router(struct orig_node *orig_node);
>=20
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@lists.open-mesh.net
> https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>=20

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAktTb/4ACgkQrzg/fFk7axZaZACeKaxW5APXfpOSAI8UKTNPbF/Y
w9QAn0dQ9LUx4W8Az+4qR3IjCKEZsZp1
=EUV8
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
