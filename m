Return-Path: <andi@firstfloor.org>
From: Andi Kleen <andi@firstfloor.org>
References: <1283646353-17811-1-git-send-email-sven.eckelmann@gmx.de>
Date: Wed, 08 Sep 2010 09:14:29 +0200
In-Reply-To: <1283646353-17811-1-git-send-email-sven.eckelmann@gmx.de> (Sven
	Eckelmann's message of "Sun, 5 Sep 2010 02:25:53 +0200")
Message-ID: <87sk1kiu5m.fsf@basil.nowhere.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: [B.A.T.M.A.N.] [PATCHv4] net: Add batman-adv meshing protocol
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven.eckelmann@gmx.de>
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.net, davem@davemloft.net

Sven Eckelmann <sven.eckelmann@gmx.de> writes:

> B.A.T.M.A.N. (better approach to mobile ad-hoc networking) is a routing
> protocol for multi-hop ad-hoc mesh networks. The networks may be wired or
> wireless. See http://www.open-mesh.org/ for more information and user space
> tools.

It seems rather unusual to have the complete routing protocol in
kernel. And this is a lot of code. The normal way to do such things is
to have the routing policy etc. in a user daemon and only let the kernel
provide some services to this. 

Could you elaborate a bit why this approach was not chosen?

I assume if it needs a switch it could have a switching "hot path" layer
in kernel and the policy somewhere else.

You write

> +Batman advanced was implemented as a Linux kernel driver  to  re-
> +duce the overhead to a minimum. It does not depend on any (other)

What overhead exactly?

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only.
