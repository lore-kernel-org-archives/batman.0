Return-Path: <linus.luessing@c0d3.blue>
Date: Mon, 26 Jun 2017 03:30:24 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20170626013024.GA5829@otheros>
References: <20170623154826.7792-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170623154826.7792-1-linus.luessing@c0d3.blue>
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: fix TT sync flag
 inconsistencies
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

On Fri, Jun 23, 2017 at 05:48:26PM +0200, Linus Lüssing wrote:
> [...]
> This patch fixes this issue by storing the flags used in the CRC
> calculation on a a per TT orig entry basis to be able to respond with
> the correct, original flags in an intermediate TT Response for one
> thing. And to be able to correctly unset sync flags once all nodes
> announcing a sync flag vanish for another.
> 
> Fixes: fa614fd04692 ("batman-adv: fix tt_global_entries flags update")
> [...]

By the way, I was able to reliably reproduce the issue within
network namespaces with following two scrips (with the latter
running the former):

https://metameute.de/~tux/batman-adv/setup-batman-netns.sh
https://metameute.de/~tux/batman-adv/test-batman-bla.sh

The scripts create a simple three node topology like:

A === B === C
      |     |
      -------
         |
         c

A, B, C are connected in a line topology, B and C share the same
BLA backbone. There is only one host, c, in the upper mesh layer.

The scripts turn on the extended isolation just on B for a few
seconds via the isolation mark / ebtables and then disables it
again.

So, in the end, the local translation table for B and C looks
sane again, with no wifi or isolation flag. However A continues
sending TT Requests while receiving invalid TT Responses for C.

(I used "batctl tracedump" to check, as "batctl log" unfortunately
does not work with network namespaces yet)


After applying this patch, the endless TT Requests/Replies do
not appear for me anymore. And the global translation table on
all three nodes looks fine again, too (that is the isolation flag
is gone again as it is supposed to while it wrongfully persisted
for A without this patch).

Regards, Linus
