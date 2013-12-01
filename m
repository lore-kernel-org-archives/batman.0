Return-Path: <davem@davemloft.net>
Date: Sun, 01 Dec 2013 14:21:35 -0500 (EST)
Message-Id: <20131201.142135.880608909113540809.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <529B47AA.8060403@meshcoding.com>
References: <20131130230518.GC16735@n2100.arm.linux.org.uk>
 <529A8276.9060002@meshcoding.com> <529B47AA.8060403@meshcoding.com>
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
To: antonio@meshcoding.com
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, linux@arm.linux.org.uk

From: Antonio Quartulli <antonio@meshcoding.com>
Date: Sun, 01 Dec 2013 15:28:58 +0100

> Am I wrong or this is a problem in the ARM compiler not doing the
> right assumption? On x86 and x86_64 offset_of dest is 4, as expected.

These alignment behaviors are defined by the processor ABI, there is
no set of global rules that apply, so it behaves differently on
different CPUs.  What you observe is correct behavior for compilation
on ARM processors.
