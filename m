Return-Path: <davem@davemloft.net>
Date: Thu, 18 Oct 2012 15:37:36 -0400 (EDT)
Message-Id: <20121018.153736.1003806671294091595.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1350588295-22587-1-git-send-email-ordex@autistici.org>
References: <1350588295-22587-1-git-send-email-ordex@autistici.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] pull request: batman-adv 2012-10-18
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
To: ordex@autistici.org
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Antonio Quartulli <ordex@autistici.org>
Date: Thu, 18 Oct 2012 21:24:53 +0200

> here are two fixes intended for net. The first one fixes the CRC computation
> used to check for broadcast packet duplicates. The wrong result lead to many
> (more than 80%) broadcast packets being dropped and so making the network very
> slow and mostly unusable. Think about all the ARP or DHCP requests not going
> through.
> 
> The second patch fixes a potential race condition, still in the same duplicated
> broadcast check procedure, which can lead to wrong outcomes under certain
> circumstances.

Pulled, thanks.

> I would also like to enqueue patch 1/2 for sending to stable-{3.5/3.6}.

Feel free to submit this to -stable once it hits Linus's tree.

Thanks.
