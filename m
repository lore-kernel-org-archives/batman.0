Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 19 Feb 2013 09:08:44 +0800
References: <1361112184-9927-1-git-send-email-ordex@autistici.org>
 <20130218234904.GA24241@pandem0nium>
In-Reply-To: <20130218234904.GA24241@pandem0nium>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201302190908.44891.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: add compat support for the
	new netlink ops
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


Hi Simon,

> I've tested this (just test, no code review) in my 2.6.32 qemu (Debian
> squeeze, iproute from wheezy). It generally loads and batctl if add/del
> seems to work, but there is something weird going on with bridge
> interaction. After calling the following 3 commands:
> 
> brctl addbr br0
> batctl if add eth0
> ip link set dev eth0 master br0
> 
> I would expect that eth0 moved from bat0 to br0 (or some error is
> reported). 

I feel some confusion here. It could very well be that 2.6.32 did not yet 
support this kind of "interface transfer". You could repeat your test without 
any of the later patches (just go back to the last stable release) to see what 
happens. It is very likely that our patches have nothing to do with that.

These are the tests we should do in order to confirm the compat patch in 
question:

* batctl if add $iface && some OGMS here && batctl if del $iface
* ip link add dev bat0 type batadv && ip link set dev $iface master bat0 && 
some OGMS here && ip link set dev $iface nomaster && ip link del dev bat0

Even more interesting are combinations of those:
* batctl if add $iface && some OGMS here && ip link set dev $iface nomaster && 
ip link del dev bat0
* ip link add dev bat0 type batadv && ip link set dev $iface master bat0 && 
some OGMS here && batctl if del $iface

Thanks for testing!

Cheers,
Marek
