Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 2 May 2010 01:13:40 +0800
References: <1272719410-406-1-git-send-email-andrew@lunn.ch>
	<1272719410-406-3-git-send-email-andrew@lunn.ch>
	<201005011837.42615.sven.eckelmann@gmx.de>
In-Reply-To: <201005011837.42615.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201005020113.40372.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/4] batman-adv: Import sparse fixes from
	mainline.
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

On Sunday 02 May 2010 00:34:56 Sven Eckelmann wrote:
> This has not real something to do with this patch (which is good), but 
> to_net_dev was added in v2.6.20-236-g43cb76d and the README still states
>  that  we are compatible with linux 2.6.20. I think we must change that to
>  2.6.25 (explanation below).

I ran into a bat_sysfs issue today regarding  kobject_create_and_add() on 
2.6.21 and made a fix for it. With that patch it compiles fine but it needs some 
more testing though. I did not see any complaints about to_net_dev. It seems 
to be there: include/linux/netdevice.h line 538. 
We still might have some issues on 2.6.20 ..

Cheers,
Marek
