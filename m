Return-Path: <a@unstable.cc>
Subject: Re: [PATCH maint] batman-adv: Avoid uninitialized chaddr when
 handling DHCP
References: <20200722184923.6577-1-sven@narfation.org>
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <30c2ad32-21d0-3c50-926c-331d58a47073@unstable.cc>
Date: Wed, 22 Jul 2020 21:26:20 +0200
MIME-Version: 1.0
In-Reply-To: <20200722184923.6577-1-sven@narfation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Sven Eckelmann <sven@narfation.org>
Cc: syzbot+ab16e463b903f5a37036@syzkaller.appspotmail.com

On 22/07/2020 20:49, Sven Eckelmann wrote:
> The gateway client code can try to optimize the delivery of DHCP packets to
> avoid broadcasting them through the whole mesh. But also transmissions to
> the client can be optimized by looking up the destination via the chaddr of
> the DHCP packet.
> 
> But the chaddr is currently only done when chaddr is fully inside the
> non-paged area of the skbuff. Otherwise it will not be initialized and the
> unoptimized path should have been taken.
> 
> But the implementation didn't handle this correctly. It didn't retrieve the
> correct chaddr but still tried to perform the TT lookup with this
> uninitialized memory.
> 
> Reported-by: syzbot+ab16e463b903f5a37036@syzkaller.appspotmail.com
> Fixes: 2d5b555644b2 ("batman-adv: send every DHCP packet as bat-unicast")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Acked-by: Antonio Quartulli <a@unstable.cc>

-- 
Antonio Quartulli
