Return-Path: <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH] batman-adv: don't warn when enslaving hard interface
 failed
References: <04896d08-4bc0-019b-966e-41064effdef6@i-love.sakura.ne.jp>
 <99650324-734d-54ed-cd9a-e7b55b8f3630@i-love.sakura.ne.jp>
 <19096778.Bt7unJmvIX@sven-l14>
From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <e43b78ae-7a4c-3dd2-d4a4-554f0280efa8@i-love.sakura.ne.jp>
Date: Mon, 7 Jun 2021 00:48:25 +0900
MIME-Version: 1.0
In-Reply-To: <19096778.Bt7unJmvIX@sven-l14>
Content-Type: text/plain; charset=windows-1252
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
To: Sven Eckelmann <sven@narfation.org>, Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <a@unstable.cc>
Cc: b.a.t.m.a.n@lists.open-mesh.org

On 2021/06/06 23:35, Sven Eckelmann wrote:
> Please rebase your patch in case it is really needed.

Oh, I didn't know you already applied that change, for that commit is
not yet visible from linux-next.git as of next-20210604.

> 
> And the explanation you give seems to be bogus. Or am I missing some error 
> handling in batadv_hardif_enable_interface [1]?

I told syzbot to try https://syzkaller.appspot.com/text?tag=Patch&x=100b083fd00000
and the response ( https://syzkaller.appspot.com/text?tag=CrashLog&x=1456f0ffd00000 ) was

   batman_adv: forw_packet->if_outgoing->soft_iface=0000000000000000 forw_packet->if_incoming->soft_iface=0000000039fa85b7

indicating that if_outgoing->soft_iface was NULL, and there was a memory allocation
fault injection immediately before this result.

Since if_outgoing->soft_iface becomes non-NULL if batadv_hardif_enable_interface()
succeeds, this situation indicates that batadv_hardif_enable_interface() failure
caused forw_packet->if_outgoing->soft_iface to remain NULL.

> 
> Kind regards,
> 	Sven
> 
> [1] https://git.open-mesh.org/linux-merge.git/blob/refs/heads/batadv/net-next:/net/batman-adv/hard-interface.c
> 
