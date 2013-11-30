Return-Path: <davem@davemloft.net>
Date: Sat, 30 Nov 2013 16:05:47 -0500 (EST)
Message-Id: <20131130.160547.837987320410619405.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20131130191553.GA16735@n2100.arm.linux.org.uk>
References: <20131130191553.GA16735@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH] Fix ARM BUILD_BUG_ON() errors with
	batman-adv
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: linux@arm.linux.org.uk
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, mareklindner@neomailbox.ch, antonio@meshcoding.com

From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Sat, 30 Nov 2013 19:15:53 +0000

> so there should be no undesired side effect from this packing.

There is a huge side effect from ever using the packed attribute, in
that the compiler can assume absolutely nothing about the alignment of
any object or sub-object of the type you apply this attribute to.

Even if it is "obvious" that some members will be aligned, the
compiler cannot take advantage of this assumption because this
attribute also means that an array of such elements might have
arbitrary alignment.  So you when you get a pointer to one of these
objects, the compiler has to assume the worst possible case.

This means using 4 byte loads to load a 32-bit quantity, always,
unconditionally, no matter what.

That's why we should do whatever is necessary to align things properly
by hand, and use packed only as the last possible and least desirable
resort.

I'm not applying this, please try work to implement this more
acceptably first.

Thanks.
