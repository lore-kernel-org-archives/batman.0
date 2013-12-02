Return-Path: <davem@davemloft.net>
Date: Mon, 02 Dec 2013 11:20:42 -0500 (EST)
Message-Id: <20131202.112042.875349112345949903.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <529C8226.2040000@meshcoding.com>
References: <20131201171309.GD16735@n2100.arm.linux.org.uk>
 <AE90C24D6B3A694183C094C60CF0A2F6026B7451@saturn3.aculab.com>
 <529C8226.2040000@meshcoding.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH] Fix ARM BUILD_BUG_ON() errors
 withbatman-adv
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
Cc: netdev@vger.kernel.org, David.Laight@ACULAB.COM, linux@arm.linux.org.uk, b.a.t.m.a.n@lists.open-mesh.org

From: Antonio Quartulli <antonio@meshcoding.com>
Date: Mon, 02 Dec 2013 13:50:46 +0100

> This may work with the structures I reported in a previous email, but
> it is not a good solution for us because we have other more complex
> substructs that cannot be packed that way.
> 
> I think we will simply duplicate the members and avoid substructs in
> our packets.

I would strongly suggest just making everything a multiple of 4 bytes in
size.
