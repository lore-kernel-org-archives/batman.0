Return-Path: 
  <3gpRzYQkbAIs7DEzp00t6p44xs.v33v0t97t6r328t28.r31@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>
MIME-Version: 1.0
Date: Fri, 22 Oct 2021 21:50:10 -0700
In-Reply-To: <5e29e63c-d2b5-ae72-0e33-5a22e727be3c@gmail.com>
Message-ID: <000000000000d2f5fa05cefddcf0@google.com>
Subject: Re: [syzbot] WARNING in batadv_nc_mesh_free
From: syzbot <syzbot+28b0702ada0bf7381f58@syzkaller.appspotmail.com>
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
To: a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org, mareklindner@neomailbox.ch, netdev@vger.kernel.org, paskripkin@gmail.com, sven@narfation.org, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+28b0702ada0bf7381f58@syzkaller.appspotmail.com

Tested on:

commit:         9c0c4d24 Merge tag 'block-5.15-2021-10-22' of git://gi..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=d95853dad8472c91
dashboard link: https://syzkaller.appspot.com/bug?extid=28b0702ada0bf7381f58
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1553d4c4b00000

Note: testing is done by a robot and is best-effort only.
