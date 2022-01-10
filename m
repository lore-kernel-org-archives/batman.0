Return-Path: <fw@strlen.de>
Date: Mon, 10 Jan 2022 12:48:50 +0100
From: Florian Westphal <fw@strlen.de>
Subject: Re: [syzbot] WARNING: suspicious RCU usage in __dev_queue_xmit
Message-ID: <20220110114850.GD317@breakpoint.cc>
References: <000000000000ca1d2005d537ebac@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000ca1d2005d537ebac@google.com>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: syzbot <syzbot+e163f2ff7c3f7efd8203@syzkaller.appspotmail.com>
Cc: a@unstable.cc, alobakin@pm.me, andrii@kernel.org, ast@kernel.org, atenart@kernel.org, b.a.t.m.a.n@lists.open-mesh.org, bpf@vger.kernel.org, coreteam@netfilter.org, daniel@iogearbox.net, davem@davemloft.net, fw@strlen.de, john.fastabend@gmail.com, jonathan.lemon@gmail.com, kadlec@netfilter.org, kafai@fb.com, kpsingh@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, lukas@wunner.de, mareklindner@neomailbox.ch, netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, pablo@netfilter.org, songliubraving@fb.com, sven@narfation.org, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com, yhs@fb.com

syzbot <syzbot+e163f2ff7c3f7efd8203@syzkaller.appspotmail.com> wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    4c375272fb0b Merge branch 'net-add-preliminary-netdev-refc..
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=164749a9b00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2b8e24e3a80e3875
> dashboard link: https://syzkaller.appspot.com/bug?extid=e163f2ff7c3f7efd8203
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11493641b00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11ac6aceb00000

> include/linux/netfilter_netdev.h:97 suspicious rcu_dereference_check() usage!

#syz fix: netfilter: egress: avoid a lockdep splat
