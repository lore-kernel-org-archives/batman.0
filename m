Return-Path: <davem@davemloft.net>
Date: Thu, 16 Dec 2010 14:52:28 -0800 (PST)
Message-Id: <20101216.145228.27818669.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <201012162321.11580.sven@narfation.org>
References: <1292275168-19882-1-git-send-email-sven@narfation.org>
	<20101216.140153.232733922.davem@davemloft.net>
	<201012162321.11580.sven@narfation.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCHv8] net: Add batman-adv meshing protocol
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
To: sven@narfation.org
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 16 Dec 2010 23:21:09 +0100

> This brings me to another topic. How do you want to get patches for batman-
> adv? Do you prefer to pull changes from a git tree or do you want do have them 
> sent to netdev and you as real patches? Do you have special restrictions on 
> the time were you want to except feature patches for the next kernel version 
> (before Linus' merge window)?

Patches or GIT tree is fine.  Either way it should be based upon
net-next-2.6

If you use a GIT tree, you should still post the individual patches
for review on netdev.
