Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 31 Aug 2010 12:37:19 +0200
References: <4C6437BF.9080909@web.de>
	<201008271159.28345.sven.eckelmann@gmx.de>
	<4C7CA94A.7020103@bb.banban.jp>
In-Reply-To: <4C7CA94A.7020103@bb.banban.jp>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201008311237.20104.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] problem openwrt-trunk + ath5k + batman-adv-devel
	in my case
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Tuesday 31 August 2010 09:03:38 Kazuki Shimada wrote:
> After network restart, wlan interfaces under bat0 are still deactivated. 
> But it's not big problem. "/etc/init.d/batman-adv restart" makes them 
> activated.

By removing interfaces entirely, i.e. network restart, batman purges the 
settings it had regarding these interfaces.


> When activating network interfaces under bat0, What about forcing their 
> mtu value to 1527?

As Sven pointed out: There might be interfaces which do not allow to increase 
the MTU or situations in which that is not desirable.

Note that OpenWRT allows to specify the MTU in the configuration files 
(/etc/config/network), so that you don't need to manually configure it each time 
you invoke "network restart".

Cheers,
Marek
