Return-Path: <bhutchings@solarflare.com>
From: Ben Hutchings <bhutchings@solarflare.com>
In-Reply-To: <201007202049.31530.sven.eckelmann@gmx.de>
References: <1279291156-5297-2-git-send-email-sven.eckelmann@gmx.de>
	<201007202023.17883.lindner_marek@yahoo.de>
	<AANLkTim4QSjgC2BbrEJEpefQahbkSgaRPPfJ-N0aPL-E@mail.gmail.com>
	<201007202049.31530.sven.eckelmann@gmx.de>
Content-Type: text/plain
Date: Tue, 20 Jul 2010 19:57:13 +0100
Message-Id: <1279652233.2110.51.camel@achroite.uk.solarflarecom.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH] net: Add batman-adv meshing protocol
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
To: Sven Eckelmann <sven.eckelmann@gmx.de>
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, siwu@hrz.tu-chemnitz.de, Marek Lindner <lindner_marek@yahoo.de>, David Miller <davem@davemloft.net>, Abraham Arce <abraham.arce.moreno@gmail.com>

On Tue, 2010-07-20 at 20:49 +0200, Sven Eckelmann wrote:
> Abraham Arce wrote:
> > Minor comments...
> > 
> > 1. Is it ok to have a README in drivers directory? why not moving it
> > to Documentation/networking?
> 
> Thanks, I will check if Documentation/networking is a better place.
> 
> > 2. Compilation error, one extra arguments passed
> > 
> > - stats = (struct net_device_stats *)dev_get_stats(skb->dev, &temp);
> > + stats = (struct net_device_stats *)dev_get_stats(skb->dev, &temp);
> > 
> >   LD      kernel/built-in.o
> > net/batman-adv/hard-interface.c: In function 'batman_skb_recv':
> > net/batman-adv/hard-interface.c:482: error: too many arguments to
> > function 'dev_get_stats'
> > make[2]: *** [net/batman-adv/hard-interface.o] Error 1
> > make[2]: *** Waiting for unfinished jobs....
> > make[1]: *** [net/batman-adv] Error 2
> > make: *** [net] Error 2
> 
> Do you use linux-next or net-next-2.6? Because this is needed to get it 
> compiled as dev_get_stats was changed some time ago (commit 
> 28172739f0a276eb8d6ca917b3974c2edb036da3), but this is not part of 2.6.35.

Even so, that cast is a bug following commit
3cfde79c6c7c8002375c4a8e5be7f602fbb9675d.

Ben.

-- 
Ben Hutchings, Senior Software Engineer, Solarflare Communications
Not speaking for my employer; that's the marketing department's job.
They asked us to note that Solarflare product names are trademarked.

