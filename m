Return-Path: <proski@gnu.org>
Date: Fri, 19 Oct 2012 11:55:17 -0400
From: Pavel Roskin <proski@gnu.org>
Message-ID: <20121019115517.7b8514a8@mj>
In-Reply-To: <1350630254.2293.183.camel@edumazet-glaptop>
References: <cover.1350618006.git.joe@perches.com>
 <1350630254.2293.183.camel@edumazet-glaptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [ath9k-devel] [PATCH net-next 00/21] treewide:
 Use consistent api style for address testing
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
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: linux-mips@linux-mips.org, b.a.t.m.a.n@lists.open-mesh.org, linux-doc@vger.kernel.org, brcm80211-dev-list@broadcom.com, users@rt2x00.serialmonkey.com, linux-sctp@vger.kernel.org, devel@open-fcoe.org, dev@openvswitch.org, linux-s390@vger.kernel.org, wimax@linuxwimax.org, linux-scsi@vger.kernel.org, linux-rdma@vger.kernel.org, bridge@lists.linux-foundation.org, lvs-devel@vger.kernel.org, coreteam@netfilter.org, b43-dev@lists.infradead.org, cbe-oss-dev@lists.ozlabs.org, devel@driverdev.osuosl.org, user-mode-linux-devel@lists.sourceforge.net, devicetree-discuss@lists.ozlabs.org, davinci-linux-open-source@linux.davincidsp.com, netfilter@vger.kernel.org, user-mode-linux-user@lists.sourceforge.net, linux-arm-kernel@lists.infradead.org, linux-nfs@vger.kernel.org, linux-parisc@vger.kernel.org, netdev@vger.kernel.org, linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, e1000-devel@lists.sourceforge.net, ath9k-devel@lists.ath9k.org, netfilter-devel@vger.kernel.org, Joe Perches <joe@perches.com>, uclinux-dist-devel@blackfin.uclinux.org, linuxppc-dev@lists.ozlabs.org

On Fri, 19 Oct 2012 09:04:14 +0200
Eric Dumazet <eric.dumazet@gmail.com> wrote:

> Yes they are some names discrepancies, thats a big deal.
> 
> And we have alloc_skb() / kfree_skb() / skb_clone() 
> 
> Why not skb_alloc() / skb_free() / skb_clone() ?
> 
> Some people actually know current code by name of functions, they dont
> want to change their mind and having to grep include files and git log
> to learn the new names of an old function, especially when traveling
> and using a laptop.

I agree.

Also, it makes sense to introduce a more consistent name for a function
when it's improved in some way and the callers need to be adjusted or
re-checked.

That way, the old name can be phased out as the code is made compatible
with the new function.

-- 
Regards,
Pavel Roskin
