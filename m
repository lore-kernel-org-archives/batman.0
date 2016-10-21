Return-Path: <johnzeng2013@yahoo.com>
Message-ID: <580A26A4.5030005@yahoo.com>
Date: Fri, 21 Oct 2016 22:31:00 +0800
From: johnzeng <johnzeng2013@yahoo.com>
MIME-Version: 1.0
Subject: i found time delay is very high and there are more caution info 
 , if possible , please give me some advisement
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
To: b.a.t.m.a.n@lists.open-mesh.org





-----------------------------
archlinux hostA
_____________________________

ip link set mtu 1532 dev eth0
batctl if add eth0
ip link set up dev eth0
ip link set up dev bat0

ifconfig bat0 10.10.130.88 netmask 255.255.255.0 up



-----------------------------
archlinux hostB
_____________________________

ip link set mtu 1532 dev eth0
batctl if add eth0
ip link set up dev eth0
ip link set up dev bat0

ifconfig bat0 10.10.130.66 netmask 255.255.255.0 up


my problem is :

when i try to ping hostB from hostA

i found time delay is very high and there are more caution info


because i tested between ethernet network port ( i don't test in wifi
port ) , whether it will master reason ?

ethernet network use csma/cd ,but wifi use csma/ca , and ethernet
network haven't mode ad-hoc .


if possible , please give some advisement .


Thanks again




