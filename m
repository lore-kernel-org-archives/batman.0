Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 27 Jun 2013 05:00:04 +0800
References: <1372266127-1281-1-git-send-email-ordex@autistici.org>
 <1372266127-1281-3-git-send-email-ordex@autistici.org>
In-Reply-To: <1372266127-1281-3-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Message-Id: <201306270500.04863.lindner_marek@yahoo.de>
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCHv9 2/3] batman-adv: add sysfs framework
	for VLAN
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

On Thursday, June 27, 2013 01:02:06 Antonio Quartulli wrote:
> +static struct batadv_softif_vlan *
> +batadv_kobj_to_vlan(struct batadv_priv *bat_priv, struct kobject *obj)
> +{
> +       struct batadv_softif_vlan *vlan;
> +
> +       hlist_for_each_entry_rcu(vlan, &bat_priv->softif_vlan_list, list) {
> +               if (vlan->kobj != obj)
> +                       continue;
> +
> +               if (!atomic_inc_not_zero(&vlan->refcount))
> +                       continue;
> +
> +               return vlan;
> +       }
> +
> +       return NULL;
> +}

Aren't we missing a rcu_lock()/rcu_unlock() combo ?

Cheers,
Marek
