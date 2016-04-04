Return-Path: <linus.luessing@c0d3.blue>
Date: Tue, 5 Apr 2016 01:15:58 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160404231558.GG3002@otheros>
References: <1459513651.4076.17.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1459513651.4076.17.camel@gmail.com>
Subject: Re: [B.A.T.M.A.N.] Need some help to understand the code
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Fri, Apr 01, 2016 at 02:27:31PM +0200, Philipp Psurek wrote:
> If you have some spare time please recommend me some literature that
> has helped you on your way to write batman-adv code. I've two, three
> weeks to prepare myself and evaluate if I understand the code (or some
> parts of it) or participate in fixing some other Freifunk related
> issues.

Hi Philipp,

A few of the basics would be lists and locking as they are used
everywhere in the code and would be something you would need to
use and understand for batman-adv coding.

For lists, for instance:
http://www.makelinux.net/ldd3/chp-11-sect-5
http://kernelnewbies.org/FAQ/LinkedLists

Or the kerneldoc for lists themselves :) :
http://lxr.free-electrons.com/source/include/linux/list.h


For locking, two kinds of locks are mostly used in batman-adv. The
easy ones are spin-locks:
http://lxr.free-electrons.com/source/Documentation/locking/spinlocks.txt

And then there is the fancy but super awesome RCU locking :) :
https://lwn.net/Articles/262464/


Finally, knowing how SKBs work is something you should look into
for Linux network coding:
http://vger.kernel.org/~davem/skb.html


A friend of mine had written a small (< 300 lines) but fun kernel module:
https://github.com/Gnoxter/devcat

Maybe you could set up a KVM instance and play a little with its
code in there? Try out lists and spinlocks etc. in there without
crashing the VM instance :).

Cheers, Linus

PS: If you need any help, feel free to query me in #batman on
Freenode (nick: T_X).
