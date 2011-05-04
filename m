Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 4 May 2011 13:51:34 +0200
References: <1304496393-16405-1-git-send-email-sven@narfation.org>
	<1304496393-16405-3-git-send-email-sven@narfation.org>
In-Reply-To: <1304496393-16405-3-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201105041351.35006.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/5] batman-adv: Add compatibility code
	for kfree_rcu
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

On Wednesday 04 May 2011 10:06:30 Sven Eckelmann wrote:
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 1234)
> +
> +#define BAT_KFREE_RCU0(n, x) \
> +       static void bat_kfree_rcu_##n(struct rcu_head *head) \
> +       {\
> +               unsigned long offset = (unsigned long)(x);\
> +               kfree((void *)head - offset);\
> +       }
> +
> +#define BAT_KFREE_RCU1(n,x) BAT_KFREE_RCU0(n##z,x)
> BAT_KFREE_RCU0(n##o,x+1UL) +#define BAT_KFREE_RCU2(n,x)
> BAT_KFREE_RCU1(n##z,x) BAT_KFREE_RCU1(n##o,x+2UL) +#define
> BAT_KFREE_RCU3(n,x) BAT_KFREE_RCU2(n##z,x) BAT_KFREE_RCU2(n##o,x+4UL)
> +#define BAT_KFREE_RCU4(n,x) BAT_KFREE_RCU3(n##z,x)
> BAT_KFREE_RCU3(n##o,x+8UL) +#define BAT_KFREE_RCU5(n,x)
> BAT_KFREE_RCU4(n##z,x) BAT_KFREE_RCU4(n##o,x+16UL) +#define
> BAT_KFREE_RCU6(n,x) BAT_KFREE_RCU5(n##z,x) BAT_KFREE_RCU5(n##o,x+32UL)
> +#define BAT_KFREE_RCU7(n,x) BAT_KFREE_RCU6(n##z,x)
> BAT_KFREE_RCU6(n##o,x+64UL) +#define BAT_KFREE_RCU8(n,x)
> BAT_KFREE_RCU7(n##z,x) BAT_KFREE_RCU7(n##o,x+128UL)

How about something like this (in compat.h):

static void free_rcu_gw_node(struct rcu_head *rcu)
{
       struct gw_node *gw_node;

       gw_node = container_of(rcu, struct gw_node, rcu);
       kfree(gw_node);
}

#define kfree_rcu(ptr, rcu_head) call_rcu(&ptr->rcu_head, free_rcu_##ptr);


Disclaimer: This is a proof of concept to convey the idea - I did not even try 
to compile this code.

Obviously, we would need an extra function for each kfree_rcu() call.

Regards,
Marek
