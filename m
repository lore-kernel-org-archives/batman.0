Return-Path: <jay.vosburgh@canonical.com>
From: Jay Vosburgh <jay.vosburgh@canonical.com>
In-reply-to: <20170118164501.1934-1-tklauser@distanz.ch>
References: <20170118164501.1934-1-tklauser@distanz.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <11020.1484761192.1@famine>
Date: Wed, 18 Jan 2017 09:39:52 -0800
Message-ID: <11021.1484761192@famine>
Subject: Re: [B.A.T.M.A.N.] [PATCH net-next] net: Remove usage of net_device
	last_rx member
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Tobias Klauser <tklauser@distanz.ch>
Cc: devel@driverdev.osuosl.org, Eric Dumazet <eric.dumazet@gmail.com>, netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Stephen Hemminger <stephen@networkplumber.org>, linux-m68k@lists.linux-m68k.org, intel-wired-lan@lists.osuosl.org, Veaceslav Falico <vfalico@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, Mirko Lindner <mlindner@marvell.com>

Tobias Klauser <tklauser@distanz.ch> wrote:

>The network stack no longer uses the last_rx member of struct net_device
>since the bonding driver switched to use its own private last_rx in
>commit 9f242738376d ("bonding: use last_arp_rx in slave_last_rx()").
>
>However, some drivers still (ab)use the field for their own purposes and
>some driver just update it without actually using it.
>
>Previously, there was an accompanying comment for the last_rx member
>added in commit 4dc89133f49b ("net: add a comment on netdev->last_rx")
>which asked drivers not to update is, unless really needed. However,
>this commend was removed in commit f8ff080dacec ("bonding: remove
>useless updating of slave->dev->last_rx"), so some drivers added later
>on still did update last_rx.
>
>Remove all usage of last_rx and switch three drivers (sky2, atp and
>smc91c92_cs) which actually read and write it to use their own private
>copy in netdev_priv.
>
>Compile-tested with allyesconfig and allmodconfig on x86 and arm.

Reviewed-by: Jay Vosburgh <jay.vosburgh@canonical.com>
