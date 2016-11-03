Return-Path: <johnzeng2013@yahoo.com>
Message-ID: <581B086E.8040400@yahoo.com>
Date: Thu, 03 Nov 2016 17:50:38 +0800
From: johnzeng <johnzeng2013@yahoo.com>
MIME-Version: 1.0
Subject: Re: if i hope to build  relay network via batman-adv , whether i
 will obtain Networkcoding part  via config menuconfig and compile?
References: <581B0429.6000206@yahoo.com>
In-Reply-To: <581B0429.6000206@yahoo.com>
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
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


Hello Dear SIr :

When i compile the part , whether i need make
CONFIG_BATMAN_ADV_BATMAN_V=y at batman-adv-2016.2


Thanks
> Hello Dear Sir :
>
> if i hope to build relay network via batman-adv , whether i will obtain
> Networkcoding part via config menuconfig and compile.
>
> whether i need config other except part A ?
>
> Part A
>
> 	 batctl nc 0
> 	 echo 0 > /sys/class/net/bat0/mesh/network_coding
> 	 ip link set dev wlan0 promisc on
> 	 ip link set dev wlan0 mtu 1546
>
>
>            Thanks 
>
>
>

