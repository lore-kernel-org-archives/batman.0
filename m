Return-Path: <3Edj1XQkbAI4AGH2s33w9s770v.y66y3wCAw9u65Bw5B.u64@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>
MIME-Version: 1.0
Date: Sat, 14 Dec 2019 22:52:01 -0800
In-Reply-To: <20191215063020.GA11512@mit.edu>
Message-ID: <0000000000002a99070599b888dd@google.com>
Subject: Re: KASAN: use-after-free Read in ext4_xattr_set_entry (2)
From: syzbot <syzbot+4a39a025912b265cacef@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: a@unstable.cc, adilger.kernel@dilger.ca, afd@ti.com, b.a.t.m.a.n@lists.open-mesh.org, chris@lapa.com.au, davem@davemloft.net, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, mareklindner@neomailbox.ch, netdev@vger.kernel.org, pali.rohar@gmail.com, sre@kernel.org, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com, tytso@mit.edu

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+4a39a025912b265cacef@syzkaller.appspotmail.com

Tested on:

commit:         dfdeeb41 Merge branch 'tt/misc' into dev
git tree:        
https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git master
kernel config:  https://syzkaller.appspot.com/x/.config?x=be3b077056d26622
dashboard link: https://syzkaller.appspot.com/bug?extid=4a39a025912b265cacef
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11b02546e00000

Note: testing is done by a robot and is best-effort only.
