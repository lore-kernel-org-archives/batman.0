Return-Path: <zukky@bb.banban.jp>
Message-ID: <4C7E2540.20704@bb.banban.jp>
Date: Wed, 01 Sep 2010 19:04:48 +0900
From: Kazuki Shimada <zukky@bb.banban.jp>
MIME-Version: 1.0
References: <4C6437BF.9080909@web.de>	<201008271159.28345.sven.eckelmann@gmx.de>	<4C7CA94A.7020103@bb.banban.jp>
	<201008311237.20104.lindner_marek@yahoo.de>
In-Reply-To: <201008311237.20104.lindner_marek@yahoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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

  Hi, Marek.

>> After network restart, wlan interfaces under bat0 are still deactivated.
>> But it's not big problem. "/etc/init.d/batman-adv restart" makes them
>> activated.
> By removing interfaces entirely, i.e. network restart, batman purges the
> settings it had regarding these interfaces.
Ah, OK.

> Note that OpenWRT allows to specify the MTU in the configuration files
> (/etc/config/network), so that you don't need to manually configure it each time
> you invoke "network restart".
Oh, thank you for your advice.
I'll try it.

Thanks,

Kazuki Shimada
