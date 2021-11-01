Return-Path: <mudongliangabcd@gmail.com>
MIME-Version: 1.0
References: <20211101040103.388646-1-mudongliangabcd@gmail.com>
 <3170956.dbteMgFBTL@ripper>
In-Reply-To: <3170956.dbteMgFBTL@ripper>
From: Dongliang Mu <mudongliangabcd@gmail.com>
Date: Mon, 1 Nov 2021 16:11:18 +0800
Message-ID: 
 <CAD-N9QUFFchS=rWjy1GN14CKM+9NXE0C4tnR7zS3h-jZR_T9wA@mail.gmail.com>
Subject: Re: [PATCH] net: batman-adv: fix warning in batadv_v_ogm_free
Content-Type: text/plain; charset="UTF-8"
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <a@unstable.cc>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Antonio Quartulli <antonio@open-mesh.com>, b.a.t.m.a.n@lists.open-mesh.org, "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

On Mon, Nov 1, 2021 at 3:46 PM Sven Eckelmann <sven@narfation.org> wrote:
>
> On Monday, 1 November 2021 05:01:02 CET Dongliang Mu wrote:
> > Call Trace:
> >  __cancel_work_timer+0x1c9/0x280 kernel/workqueue.c:3170
> >  batadv_v_ogm_free+0x1d/0x50 net/batman-adv/bat_v_ogm.c:1076
> >  batadv_mesh_free+0x35/0xa0 net/batman-adv/main.c:244
> >  batadv_mesh_init+0x22a/0x240 net/batman-adv/main.c:226
> >  batadv_softif_init_late+0x1ad/0x240 net/batman-adv/soft-interface.c:804
> >  register_netdevice+0x15d/0x810 net/core/dev.c:10229
>
> This is definitely not a backtrace of the current code and its error handling.
> Please check the current code [1] and explain the situation against this
> version.

Yes, you're right. The error handling code in the upstream is not
prone to this bug.

My local syzkaller instance is fuzzing on 5.14-rc5


>
> Kind regards,
>         Sven
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/net/batman-adv/main.c?id=ae0393500e3b0139210749d52d22b29002c20e16#n237
