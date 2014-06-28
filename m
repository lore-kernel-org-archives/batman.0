Return-Path: <julia.lawall@lip6.fr>
Date: Sat, 28 Jun 2014 22:14:03 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
In-Reply-To: <53AF1C42.6000108@meshcoding.com>
Message-ID: <alpine.DEB.2.02.1406282212540.2022@localhost6.localdomain6>
References: <20140628183628.GA9946@himangi-Dell>
 <1403982781.9064.33.camel@joe-AO725> <53AF1C42.6000108@meshcoding.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Use kasprintf
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
To: Antonio Quartulli <antonio@meshcoding.com>
Cc: Marek Lindner <mareklindner@neomailbox.ch>, netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org, julia.lawall@lip6.fr, Himangi Saraogi <himangi774@gmail.com>, Joe Perches <joe@perches.com>, "David S. Miller" <davem@davemloft.net>

On Sat, 28 Jun 2014, Antonio Quartulli wrote:

> Hi all,
> 
> On 28/06/14 21:13, Joe Perches wrote:
> > diff --git a/net/batman-adv/sysfs.c b/net/batman-adv/sysfs.c
> > index f40cb04..d6fba94 100644
> > --- a/net/batman-adv/sysfs.c
> > +++ b/net/batman-adv/sysfs.c
> > @@ -896,7 +896,7 @@ int batadv_throw_uevent(struct batadv_priv *bat_priv, enum batadv_uev_type type,
> >  {
> >  	int ret = -ENOMEM;
> >  	struct kobject *bat_kobj;
> > -	char *uevent_env[4] = { NULL, NULL, NULL, NULL };
> > +	char *uevent_env[3];
> 
> 
> Joe, why are you shortening this? kobject_uevent_env() expect a
> NULL-terminating array (that is the forth cell).
> 
> ...
> 
> >  
> >  	ret = kobject_uevent_env(bat_kobj, KOBJ_CHANGE, uevent_env);
> 
> And how is this change reducing the code space?
> 
> For what concerns the labels, we use this pattern mostly all over the
> code: one single label/exit-point with the related NULL checks. Do you
> think that we can improve something by changing this? (I am not talking
> about the fastpath here).

Most of the kernel uses specific labels for each possible failure.
From my selfish point of view, it makes the code easier to analyze and 
understand, because what is done at the exit label is only what needs to 
be done.

julia
