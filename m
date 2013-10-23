Return-Path: <davem@davemloft.net>
Date: Wed, 23 Oct 2013 17:13:03 -0400 (EDT)
Message-Id: <20131023.171303.896342188641327344.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1382544303-2694-1-git-send-email-antonio@meshcoding.com>
References: <1382544303-2694-1-git-send-email-antonio@meshcoding.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] pull request: batman-adv 2013-10-23
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Antonio Quartulli <antonio@meshcoding.com>
Date: Wed, 23 Oct 2013 18:04:47 +0200

> this is another set of changes intended for net-next/linux-3.13.
> (probably our last pull request for this cycle)
> 
> Patches 1 and 2 reshape two of our main data structures in a way that they can
> easily be extended in the future to accommodate new routing protocols.
> 
> Patches from 3 to 9 improve our routing protocol API and its users so that all
> the protocol-related code is not mixed up with the other components anymore.
> 
> Patch 10 limits the local Translation Table maximum size to a value such that it
> can be fully transfered over the air if needed. This value depends on
> fragmentation being enabled or not and on the mtu values.
> 
> Patch 11 makes batman-adv send a uevent in case of soft-interface destruction
> while a "bat-Gateway" was configured (this informs userspace about the GW not
> being available anymore).
> 
> Patches 13 and 14 enable the TT component to detect non-mesh client flag
> changes at runtime (till now those flags where set upon client detection and
> were not changed anymore).
> 
> Patch 16 is a generalisation of our user-to-kernel space communication (and
> viceversa) used to exchange ICMP packets to send/received to/from the mesh
> network. Now it can easily accommodate new ICMP packet types without breaking
> the existing userspace API anymore.
> 
> Remaining patches are minor changes and cleanups.

Pulled, thanks Antonio.
