Return-Path: <ordex@autistici.org>
Date: Tue, 27 Sep 2011 00:48:48 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20110926224847.GB29572@ritirata.org>
References: <4E80E977.8090608@wifibot.com>
 <4E80EB52.2010906@wifibot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4E80EB52.2010906@wifibot.com>
Subject: Re: [B.A.T.M.A.N.] batman-adv 2011.2.0 hop somtimes does not work
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
To: laurent <laurent@wifibot.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org

Ok, I made a stupid mistake. The patch I gave you added some printk, not bat_dbg
instructions. Therefore the messages the patch wanted to print are not in that
log.....my fault. I had to tell you.

Anyway the converted patch will follow in the thread. Can you redo the same
operations with the new patch (please, try to apply it on top of the master
branch).

I apologise for the inconvenient..

Anyway, here the bug is showing us another face. Needs further investigation.

Thanks.
Cheers,

-- 
Antonio Quartulli

..each of us alone is worth nothing..
Ernesto "Che" Guevara
