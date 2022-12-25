Return-Path: <artem.chernyshev@red-soft.ru>
Date: Sun, 25 Dec 2022 12:47:42 +0300
From: Artem Chernyshev <artem.chernyshev@red-soft.ru>
Subject: Re: [PATCH] batman-adv: Check return value
Message-ID: <Y6gcPlvR18j17zlm@localhost.localdomain>
References: <20221224233311.48678-1-artem.chernyshev@red-soft.ru>
 <2038034.tdWV9SEqCh@sven-l14>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2038034.tdWV9SEqCh@sven-l14>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org, Markus Pargmann <mpa@pengutronix.de>

Hi,
On Sun, Dec 25, 2022 at 07:37:28AM +0100, Sven Eckelmann wrote:
> Subject is missing something like ..." after calling rtnl_link_register()" or
> ..."s during module initialization".
> 
> On Sunday, 25 December 2022 00:33:11 CET Artem Chernyshev wrote:
> [...]
> > diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
> > index e8a449915566..04cd9682bd29 100644kwin
> > @@ -113,7 +113,11 @@ static int __init batadv_init(void)
> >  		goto err_create_wq;
> >  
> >  	register_netdevice_notifier(&batadv_hard_if_notifier);
> > -	rtnl_link_register(&batadv_link_ops);
> > +	ret = rtnl_link_register(&batadv_link_ops);
> > +	if (ret) {
> > +		pr_err("Can't register link_ops\n");
> > +		goto err_create_wq;
> > +	}
> >  	batadv_netlink_register();
> >  
> >  	pr_info("B.A.T.M.A.N. advanced %s (compatibility version %i) loaded\n",
> > 
> 
> This looks wrong to me. You missed to destroy the batadv_hard_if_notifier in 
> this case.
> 
> And if you want to start adding the checks, you should also have added it for 
> batadv_v_init, batadv_iv_init, batadv_nc_init, batadv_tp_meter_init and 
> register_netdevice_notifier. You can use the unfinished patch from Markus 
> Pargmann as starting point.
> 
> Kind regards,
> 	Sven
> 
> [1] https://patchwork.open-mesh.org/project/b.a.t.m.a.n./patch/1419594103-10928-6-git-send-email-mpa@pengutronix.de/
>     https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/thread/QDX46YARWUC4R7OBFHR5OJKWQIXDQWRR/#QDX46YARWUC4R7OBFHR5OJKWQIXDQWRR

Thanks for review, I'll try to fix the errors in v2

Best,
Artem

