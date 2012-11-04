Return-Path: <davem@davemloft.net>
Date: Sun, 04 Nov 2012 12:26:11 -0500 (EST)
Message-Id: <20121104.122611.1457246059414191903.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <12758662.vFhVQet4vg@sven-laptop.home.narfation.org>
References: <1351968514-12357-2-git-send-email-ordex@autistici.org>
 <20121103.152226.244759041688205348.davem@davemloft.net>
 <12758662.vFhVQet4vg@sven-laptop.home.narfation.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/9] batman-adv: add UNICAST_4ADDR packet
 type
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
To: sven@narfation.org
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 04 Nov 2012 11:29:29 +0100

> Now also assume following really unusual situation: We get our data from a 
> ethernet driver and the skb stores the ethernet header. The start of the 
> ethernet header is perfectly aligned (4 or even 16 byte boundary aligned). The 
> the header is 14/18 byte long (6 byte src, 6 byte dst, 2 byte ethertype and 
> maybe 4 byte vlan). Now the payload starts only on a 2 byte boundary -> it is 
> never 4 byte boundary aligned. A 32 bit read now causes different variations 
> of problems (reminder: bus error).

Every ethernet driver must provide the networking stack with a modulo 2
aligned ethernet header, which makes sure that everything after the
ethernet header is at least 4 byte aligned.
