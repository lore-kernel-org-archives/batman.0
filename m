Return-Path: <johnzeng2013@yahoo.com>
Message-ID: <581B0429.6000206@yahoo.com>
Date: Thu, 03 Nov 2016 17:32:25 +0800
From: johnzeng <johnzeng2013@yahoo.com>
MIME-Version: 1.0
Subject: if i hope to build  relay network via batman-adv , whether i will
 obtain Networkcoding part  via config menuconfig and compile?
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


Hello Dear Sir :

if i hope to build relay network via batman-adv , whether i will obtain
Networkcoding part via config menuconfig and compile.

whether i need config other except part A ?

Part A

	 batctl nc 0
	 echo 0 > /sys/class/net/bat0/mesh/network_coding
	 ip link set dev wlan0 promisc on
	 ip link set dev wlan0 mtu 1546


           Thanks 



