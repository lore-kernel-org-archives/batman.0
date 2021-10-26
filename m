Return-Path: <kuba@kernel.org>
Date: Mon, 25 Oct 2021 17:49:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH] net: batman-adv: fix error handling
Message-ID: 
 <20211025174950.1bec22fb@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <2526100.mKikVBQdmv@sven-l14>
References: <2056331.oJahCzYEoq@sven-desktop>
	<20211024131356.10699-1-paskripkin@gmail.com>
	<2526100.mKikVBQdmv@sven-l14>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>, mareklindner@neomailbox.ch
Cc: sw@simonwunderlich.de, a@unstable.cc, davem@davemloft.net, Pavel Skripkin <paskripkin@gmail.com>, b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, syzbot+28b0702ada0bf7381f58@syzkaller.appspotmail.com

On Sun, 24 Oct 2021 16:58:30 +0200 Sven Eckelmann wrote:
> On Sunday, 24 October 2021 15:13:56 CEST Pavel Skripkin wrote:
> > Syzbot reported ODEBUG warning in batadv_nc_mesh_free(). The problem was
> > in wrong error handling in batadv_mesh_init().
> > 
> > Before this patch batadv_mesh_init() was calling batadv_mesh_free() in case
> > of any batadv_*_init() calls failure. This approach may work well, when
> > there is some kind of indicator, which can tell which parts of batadv are
> > initialized; but there isn't any.
> > 
> > All written above lead to cleaning up uninitialized fields. Even if we hide
> > ODEBUG warning by initializing bat_priv->nc.work, syzbot was able to hit
> > GPF in batadv_nc_purge_paths(), because hash pointer in still NULL. [1]
> > 
> > To fix these bugs we can unwind batadv_*_init() calls one by one.
> > It is good approach for 2 reasons: 1) It fixes bugs on error handling
> > path 2) It improves the performance, since we won't call unneeded
> > batadv_*_free() functions.
> > 
> > So, this patch makes all batadv_*_init() clean up all allocated memory
> > before returning with an error to no call correspoing batadv_*_free()
> > and open-codes batadv_mesh_free() with proper order to avoid touching
> > uninitialized fields.
> > 
> > Link: https://lore.kernel.org/netdev/000000000000c87fbd05cef6bcb0@google.com/ [1]
> > Reported-and-tested-by: syzbot+28b0702ada0bf7381f58@syzkaller.appspotmail.com
> > Fixes: c6c8fea29769 ("net: Add batman-adv meshing protocol")
> > Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>  
> 
> Acked-by: Sven Eckelmann <sven@narfation.org>

FWIW I'm marking this as "Awaiting upstream" in netdev patchwork,
please LMK if you prefer for it to be applied directly.
