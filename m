Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA99C7EE25
	for <batman@archiver.kernel.org>; Fri,  9 Jun 2023 06:19:38 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0DDC881B50
	for <batman@archiver.kernel.org>; Fri,  9 Jun 2023 08:19:37 +0200 (CEST)
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1686291577;
 b=XacpiF2OIGgIO3plprPbVPbVQH+NwqziBEFmgj+qsfDrfuQJcM4lDkyYaLZuiOdTCVeos
 eAK7YVK2/ruJDsdsLe1o+3/OsRDnTKHWtG+fcdj5Swz1/K83sDZVwMXWb/lJgWqpjwS65Uw
 zCTtEJF+bKw7t1HcFMLPajhJZ4mTv/c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1686291577; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=TJYTT/UheHA0JznNARGWht/55tg3vpAm76dzCj/bLj0=;
 b=ZOmrYG78jP3iVKuKSSfsbuMbxDZt8mY5eV+CISIMIfYvbZ9yi862gMATD7N1liqKFM8vI
 lYjL0cESRhQDtMyj+BmS6JH8JLo2HyFssoKDuLUm0PV+09FZTpPXusqNVyCDCxl07wadUaY
 M3BwwawhkUSc9d4SaNIPJmwhlNl2TXY=
ARC-Authentication-Results: i=1; open-mesh.org; dkim=fail;
  arc=none (Message is not ARC signed);
  dmarc=fail (Used From Domain Record) header.from=draeger.com
 policy.dmarc=reject
Authentication-Results: open-mesh.org; dkim=fail;
 arc=none (Message is not ARC signed);
 dmarc=fail (Used From Domain Record) header.from=draeger.com
 policy.dmarc=reject
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 990D680611
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu,  8 Jun 2023 22:38:23 +0200 (CEST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Error - mac address of the ping destination could not be resolved and
 is not a
 bat-host name
From: mark.mundy@draeger.com
To: b.a.t.m.a.n@lists.open-mesh.org
Date: Thu, 08 Jun 2023 20:38:23 -0000
Message-ID: <168625670360.986.1615951581894902714@diktynna.open-mesh.org>
User-Agent: HyperKitty on https://lists.open-mesh.org/
X-MailFrom: mark.mundy@draeger.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1
Message-ID-Hash: T5U5QHMTQSNQJZLTL4KPTXGG4NBBUGXN
X-Message-ID-Hash: T5U5QHMTQSNQJZLTL4KPTXGG4NBBUGXN
X-Mailman-Approved-At: Fri, 09 Jun 2023 08:19:04 +0200
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/T5U5QHMTQSNQJZLTL4KPTXGG4NBBUGXN/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

What is the best way to figure out why 2 nodes that are connected on a WMN can see each other through 'batctl n', but 'batman ping' fails with the message "Error - mac address of the ping destination could not be resolved and is not a bat-host name"?

Node at eth1 - 10.1.1.1, wlan0 mac ether 04:f0:21:59:38:c9
root@jammy-newport:~# batctl n
[B.A.T.M.A.N. adv 2021.3, MainIF/MAC: wlan0/04:f0:21:59:38:c9 (bat0/72:85:90:2a:95:06 BATMAN_IV)]
IF             Neighbor              last-seen
        wlan0     c4:4b:d1:90:02:90    0.500s
root@jammy-newport:~# batctl ping 10.2.1.1
Error - mac address of the ping destination could not be resolved and is not a bat-host name: 10.2.1.1


Node at eth1 - 10.2.1.1, wlan0 mac ether c4:4b:d1:90:02:90
root@focal-newport:~# batctl n
[B.A.T.M.A.N. adv 2021.3, MainIF/MAC: wlan0/c4:4b:d1:90:02:90 (bat0/6e:87:15:7e:f3:14 BATMAN_IV)]
IF             Neighbor              last-seen
        wlan0     04:f0:21:59:38:c9    0.708s
root@focal-newport:~# batctl ping 10.1.1.1
Error - mac address of the ping destination could not be resolved and is not a bat-host name: 10.1.1.1

My intention is to be able to reach a computer on the far side of the WMN connected to eth1 10.2.1.1 from my host computer connected to the same network on eth1 10.1.1.1. It should look something like this.
network -> eth1 10.1.1.1 -> wlan0 -> bat0 (inet 10.1.1.4) -> BATMAN -> bat0 (inet 10.2.1.4) -> wlan0 -> eth1 10.2.1.1 -> non-BATMAN computer

My intention is to have eth1 10.1.1.1 connected to the main network as an interface for bat0 able to communicate over bat0. On the other end, eth1 10.2.1.1 The interfaces for eth1 and wlan0 show as active for both computers. 

For completeness, I'm working in Ubuntu 20.04
/etc/network/interfaces for 10.1.1.1
source-directory /etc/network/interfaces.d

allow-hotplug eth0
auto eth0
iface eth0 inet dhcp

allow hotplug eth1
auto eth1
iface eth1 inet static
        address 10.1.1.1
        netmask 255.0.0.0
        gateway 10.0.0.1
#        dns-nameservers 1.1.1.1 8.8.8.8 8.8.4.4

allow hotplug bat0
auto bat0
iface bat0 inet static
        address 10.1.1.4
        netmask 255.0.0.0
        up ip link set up dev $IFACE
        pre-up ip link set up dev wlan0
        pre-up iw dev wlan0 del
        pre-up iw phy phy0 interface add wlan0 type mesh
        pre-up iw dev wlan0 set channel 149 80MHz
        pre-up ip link set up dev wlan0
        pre-up iw dev wlan0 mesh join mesh149
        pre-up batctl if add wlan0
        pre-up batctl if add eth1
        down ip link set down dev $IFACE
        batman-adv-bridge yes
        batman-adv-mesh-id bat0
        batman-adv-multicast-mode 1
        batman-adv-ttl 50
        batman-adv-originator-ttl 50
        batman-adv-gateway-mode server
        batman-adv-hard-interface wlan0
        batman-adv-hard-interface eth1


ifconfig output:
bat0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 10.1.1.4  netmask 255.0.0.0  broadcast 10.255.255.255
        inet6 fe80::7085:90ff:fe2a:9506  prefixlen 64  scopeid 0x20<link>
        ether 72:85:90:2a:95:06  txqueuelen 1000  (Ethernet)
        RX packets 299  bytes 12606 (12.6 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 1  bytes 90 (90.0 B)
        TX errors 0  dropped 14 overruns 0  carrier 0  collisions 0

eth0: flags=4099<UP,BROADCAST,MULTICAST>  mtu 1500
        ether 00:d0:12:21:f7:d6  txqueuelen 1000  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

eth1: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 10.1.1.1  netmask 255.0.0.0  broadcast 10.255.255.255
        inet6 fe80::2d0:12ff:fe21:f7d7  prefixlen 64  scopeid 0x20<link>
        ether 00:d0:12:21:f7:d7  txqueuelen 1000  (Ethernet)
        RX packets 4556  bytes 328215 (328.2 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 7817  bytes 486324 (486.3 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 25  bytes 1425 (1.4 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 25  bytes 1425 (1.4 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

wlan0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet6 fe80::6f0:21ff:fe59:38c9  prefixlen 64  scopeid 0x20<link>
        ether 04:f0:21:59:38:c9  txqueuelen 1000  (Ethernet)
        RX packets 5822  bytes 353632 (353.6 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 6119  bytes 532058 (532.0 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0


/etc/network/interfaces for 10.2.1.1
source-directory /etc/network/interfaces.d

allow-hotplug eth0
auto eth0
iface eth0 inet dhcp

allow hotplug eth1
auto eth1
iface eth1 inet static
        address 10.2.1.1
        netmask 255.0.0.0
        gateway 10.0.0.1
#        dns-nameservers 1.1.1.1 8.8.8.8 8.8.4.4

allow hotplug bat0
auto bat0
iface bat0 inet static
        address 10.2.1.4
        netmask 255.0.0.0
        up ip link set up dev $IFACE
        pre-up ip link set up dev wlan0
        pre-up iw dev wlan0 del
        pre-up iw phy phy0 interface add wlan0 type mesh
        pre-up iw dev wlan0 set channel 149 80MHz
        pre-up ip link set up dev wlan0
        pre-up iw dev wlan0 mesh join mesh149
        pre-up batctl if add wlan0
        pre-up batctl if add eth1
        down ip link set down dev $IFACE
        batman-adv-bridge yes
        batman-adv-mesh-id bat0
        batman-adv-multicast-mode 1
        batman-adv-ttl 50
        batman-adv-originator-ttl 50
        batman-adv-gateway-mode server
        batman-adv-hard-interface wlan0
        batman-adv-hard-interface eth1

ifconfig output:
bat0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 10.2.1.4  netmask 255.0.0.0  broadcast 10.255.255.255
        inet6 fe80::6c87:15ff:fe7e:f314  prefixlen 64  scopeid 0x20<link>
        ether 6e:87:15:7e:f3:14  txqueuelen 1000  (Ethernet)
        RX packets 42  bytes 1764 (1.7 KB)
        RX errors 0  dropped 5  overruns 0  frame 0
        TX packets 2  bytes 180 (180.0 B)
        TX errors 0  dropped 19 overruns 0  carrier 0  collisions 0

eth0: flags=4099<UP,BROADCAST,MULTICAST>  mtu 1500
        ether 00:d0:12:93:f7:83  txqueuelen 1000  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

eth1: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 10.2.1.1  netmask 255.0.0.0  broadcast 10.255.255.255
        inet6 fe80::2d0:12ff:fe93:f784  prefixlen 64  scopeid 0x20<link>
        ether 00:d0:12:93:f7:84  txqueuelen 1000  (Ethernet)
        RX packets 74  bytes 4826 (4.8 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 796  bytes 49010 (49.0 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 354  bytes 27080 (27.0 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 354  bytes 27080 (27.0 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

wlan0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet6 fe80::c64b:d1ff:fe90:290  prefixlen 64  scopeid 0x20<link>
        ether c4:4b:d1:90:02:90  txqueuelen 1000  (Ethernet)
        RX packets 508  bytes 33612 (33.6 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 528  bytes 48806 (48.8 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
