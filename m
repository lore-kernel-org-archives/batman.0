Return-Path: <paskripkin@gmail.com>
Message-ID: <e4922538-1a57-1d21-9079-e954d742d844@gmail.com>
Date: Wed, 27 Oct 2021 14:57:20 +0300
MIME-Version: 1.0
Subject: Re: [syzbot] WARNING in batadv_v_ogm_free
Content-Language: en-US
References: <00000000000010317a05cee52016@google.com>
From: Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <00000000000010317a05cee52016@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
To: syzbot <syzbot+b6a62d5cb9fe05a0e3a3@syzkaller.appspotmail.com>, a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org, mareklindner@neomailbox.ch, netdev@vger.kernel.org, sven@narfation.org, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com

On 10/22/21 02:19, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    2f111a6fd5b5 Merge tag 'ceph-for-5.15-rc7' of git://github..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=121d909f300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d95853dad8472c91
> dashboard link: https://syzkaller.appspot.com/bug?extid=b6a62d5cb9fe05a0e3a3
> compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+b6a62d5cb9fe05a0e3a3@syzkaller.appspotmail.com
> 

Looks like bug on error handling path in batadv_mesh_init(). Must be 
fixed by my batman-adv patch.

#syz fix: net: batman-adv: fix error handling




With regards,
Pavel Skripkin
