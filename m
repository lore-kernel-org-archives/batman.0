Return-Path: <3smpoXgkbACMRXYJ9KKDQ9OOHC.FNNFKDTRDQBNMSDMS.BNL@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>
MIME-Version: 1.0
Date: Tue, 10 Mar 2020 21:36:02 -0700
In-Reply-To: <0000000000002e20b9059fee8a94@google.com>
Message-ID: <00000000000019196205a08cc67d@google.com>
Subject: Re: WARNING in idr_destroy
From: syzbot <syzbot+05835159fe322770fe3d@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: a@unstable.cc, airlied@linux.ie, airlied@redhat.com, alexander.deucher@amd.com, b.a.t.m.a.n@lists.open-mesh.org, christian.koenig@amd.com, daniel@ffwll.ch, davem@davemloft.net, dri-devel@lists.freedesktop.org, gregkh@linuxfoundation.org, hdegoede@redhat.com, kraxel@redhat.com, linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com, mareklindner@neomailbox.ch, mripard@kernel.org, netdev@vger.kernel.org, noralf@tronnes.org, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com, tglx@linutronix.de, tzimmermann@suse.de

syzbot has bisected this bug to:

commit 5b3709793d151e6e12eb6a38a5da3f7fc2923d3a
Author: Thomas Zimmermann <tzimmermann@suse.de>
Date:   Wed May 8 08:26:19 2019 +0000

    drm/ast: Convert AST driver to |struct drm_gem_vram_object|

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15a66fb5e00000
start commit:   63623fd4 Merge tag 'for-linus' of git://git.kernel.org/pub..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=17a66fb5e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=13a66fb5e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5d2e033af114153f
dashboard link: https://syzkaller.appspot.com/bug?extid=05835159fe322770fe3d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14e978e3e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10b1a819e00000

Reported-by: syzbot+05835159fe322770fe3d@syzkaller.appspotmail.com
Fixes: 5b3709793d15 ("drm/ast: Convert AST driver to |struct drm_gem_vram_object|")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
