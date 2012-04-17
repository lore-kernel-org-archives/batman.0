Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 17 Apr 2012 12:35:05 +0200
References: <1334658294-2413-1-git-send-email-ordex@autistici.org>
	<1334658294-2413-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1334658294-2413-2-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201204171235.05470.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/3] batman-adv: introduce a boolean
	switch to enable/disable DAT
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

On Tuesday, April 17, 2012 12:24:53 Antonio Quartulli wrote:
> +static void arp_change_timeout(struct net_device *soft_iface, bool
> enable_dat) +{
> +       struct in_device *in_dev = in_dev_get(soft_iface);
> +       if (!in_dev) {
> +               pr_err("Unable to set ARP parameters for the batman
> interface '%s'\n", +                      soft_iface->name);
> +               return;
> +       }
> +
> +       if (enable_dat) {
> +               /* Introduce a delay in the ARP state-machine transactions.
> +                * Entries will be kept in the ARP table for the default
> time +                * multiplied by 4
> +                */
> +               in_dev->arp_parms->base_reachable_time *=
> ARP_TIMEOUT_FACTOR; +               in_dev->arp_parms->gc_staletime *=
> ARP_TIMEOUT_FACTOR; +               in_dev->arp_parms->reachable_time *=
> ARP_TIMEOUT_FACTOR; +       } else {
> +               in_dev->arp_parms->base_reachable_time /=
> ARP_TIMEOUT_FACTOR; +               in_dev->arp_parms->gc_staletime /=
> ARP_TIMEOUT_FACTOR; +               in_dev->arp_parms->reachable_time /=
> ARP_TIMEOUT_FACTOR; +       }
> +
> +       in_dev_put(in_dev);
> +}

One more thing: Are we never going to release the in_dev ?

Regards,
Marek
