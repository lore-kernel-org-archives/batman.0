Return-Path: <johnzeng2013@yahoo.com>
Message-ID: <581B22F1.6010009@yahoo.com>
Date: Thu, 03 Nov 2016 19:43:45 +0800
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Sven Eckelmann <sven@narfation.org>


Hello Dear Sven:

there are /a clerical/ //error// about batctl nc and i compiled the part .

run these command in according to advisement for relay mode

	      batctl nc 1
	      echo 1 > /sys/class/net/bat0/mesh/network_coding
	      ip link set dev wlan0 promisc on
	      ip link set dev wlan0 mtu 1546



if i send a packet from host A to hostC via hostB, whether hostB will
open relay mode at layer2 .


Best Regards

TIger



