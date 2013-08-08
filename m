Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 8 Aug 2013 12:55:22 +0800
References: <1375916848-1874-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1375916848-1874-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201308081255.22537.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: fix memory leak in
	batadv_softif_create_vlan()
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

On Thursday, August 08, 2013 07:07:28 Antonio Quartulli wrote:
> --- a/soft-interface.c
> +++ b/soft-interface.c
> @@ -466,8 +466,10 @@ int batadv_softif_create_vlan(struct batadv_priv
> *bat_priv, unsigned short vid) atomic_set(&vlan->ap_isolation, 0);
>  
>         err = batadv_sysfs_add_vlan(bat_priv->soft_iface, vlan);
> -       if (err)
> +       if (err) {
> +               kfree(vlan);
>                 return err;
> +       }

You raise a valid point here but what about the local entry that is added 
right above ? Does it require cleanup as well ?

Cheers,
Marek
