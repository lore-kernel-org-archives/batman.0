Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 4 Apr 2010 23:54:21 +0800
References: <201004020054.08840.clemens-john@gmx.de>
	<201004031254.02506.lindner_marek@yahoo.de>
	<201004041741.56665.clemens-john@gmx.de>
In-Reply-To: <201004041741.56665.clemens-john@gmx.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201004042354.22005.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Problems connecting VPN and WLAN with Batman-adv
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

On Sunday 04 April 2010 23:41:52 Clemens John wrote:
> root@OpenWrt:~# route 
> Kernel IP routing table
> Destination     Gateway         Genmask         Flags Metric Ref    Use
>  Iface
>  192.168.178.0   *               255.255.255.0   U     0      0        0
>  eth0
>  10.18.0.0       *               255.255.0.0     U     0      0       0
>  br-mesh
>  10.18.0.0       *               255.255.0.0     U     0      0        0
>  tap0 default         192.168.178.1   0.0.0.0         UG    0      0   0
>  eth0

Which interfaces did you add to batman-adv ? I guess ath1 & tap0 ?
Can you please post "batctl if" just to be sure ?!

If you added tap0 you should not "use" this interface directly anymore (don't 
assign IP address, etc). batman-adv behaves like an ordinary bridge - all 
bridged interfaces are to be ignored. Only the bridge interface itself (bat0 
in our case) can be used. 

Regards,
Marek
