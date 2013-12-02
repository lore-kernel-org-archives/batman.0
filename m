Return-Path: <davem@davemloft.net>
Date: Mon, 02 Dec 2013 13:38:38 -0500 (EST)
Message-Id: <20131202.133838.1257454198436895412.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <201312021858.48074.sw@simonwunderlich.de>
References: <20131130191553.GA16735@n2100.arm.linux.org.uk>
 <20131130.160547.837987320410619405.davem@davemloft.net>
 <201312021858.48074.sw@simonwunderlich.de>
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
To: sw@simonwunderlich.de
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, linux@arm.linux.org.uk, mareklindner@neomailbox.ch, antonio@meshcoding.com

From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 2 Dec 2013 18:58:47 +0100

> Therefore I'd suggest to pick Russels patch, I can send a fix for 
> batadv_interface_rx() later, too.

You are ignoring the downside of Russel's patch which is that it
negatively impacts many architectures, in that now the compiler
can make no assumptions as to the alignment of a structure marked
with "packed" and therefore, for example, a 32-bit load will
be done with 4 byte loads, shifts, and masking.

Please just 4 byte align your structures.  I can't believe that
you cannot make this work cleanly.

Why can't you just include that fourth final byte in the batadv_header
structure and have the sub-header types just interpret it differently
or ignore it?

This is getting frustrating, I seemed clear to me that the non-packed
suggestions given to you so far were both reasonable and easy to
implement.
