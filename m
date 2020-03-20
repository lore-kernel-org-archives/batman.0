Return-Path: <marcelo.leitner@gmail.com>
Date: Thu, 19 Mar 2020 22:17:09 -0300
From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Subject: Re: general protection fault in sctp_ulpevent_nofity_peer_addr_change
Message-ID: <20200320011709.GE3756@localhost.localdomain>
References: <00000000000074219d05a139e082@google.com>
 <00000000000041ca9305a13ea3e0@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000041ca9305a13ea3e0@google.com>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: syzbot <syzbot+3950016bd95c2ca0377b@syzkaller.appspotmail.com>
Cc: a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, b.zolnierkie@samsung.com, davem@davemloft.net, dri-devel@lists.freedesktop.org, kuba@kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sctp@vger.kernel.org, lkundrak@v3.sk, mareklindner@neomailbox.ch, netdev@vger.kernel.org, nhorman@tuxdriver.com, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com, vyasevich@gmail.com

On Thu, Mar 19, 2020 at 05:48:02PM -0700, syzbot wrote:
> syzbot has bisected this bug to:
> 
> commit da2648390ce3d409218b6bbbf2386d8ddeec2265
> Author: Lubomir Rintel <lkundrak@v3.sk>
> Date:   Thu Dec 20 18:13:09 2018 +0000
> 
>     pxa168fb: trivial typo fix

Certainly not ;-)
