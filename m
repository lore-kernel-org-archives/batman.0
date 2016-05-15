Return-Path: <linus.luessing@c0d3.blue>
Date: Sun, 15 May 2016 14:41:38 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160515124138.GI4375@otheros>
References: <20160514145129.GD4375@otheros> <2911091.OSPWlnrdxm@sven-edge>
 <20160515120626.GG4375@otheros>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20160515120626.GG4375@otheros>
Subject: Re: [B.A.T.M.A.N.] kmalloc() vs. kmem_cache_alloc() for global TT?
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

On Sun, May 15, 2016 at 02:06:26PM +0200, Linus Lüssing wrote:
> Ok, yes, that's what I had looked at yesterday, too.

Btw., these were the results from slabinfo I got yesterday. The
first one before applying the patches, the second one after:

http://metameute.de/~tux/batman-adv/slablog/before/
http://metameute.de/~tux/batman-adv/slablog/after/

The first number is the number of lines from "batctl tg", second
one the timestamp.
