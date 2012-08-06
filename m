Return-Path: <gmazzurco89@gmail.com>
Message-ID: <501FC12D.3040608@gmail.com>
Date: Mon, 06 Aug 2012 15:05:49 +0200
From: Gioacchino Mazzurco <gmazzurco89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] multicast packet loss
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
To: b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <ordex@autistici.org>

Hi all!

I am experiencing a multicast packet loss on batman-adv mesh, this can
appear normal but it is not because the mesh is on top of wired Ethernet
link!

the host fe80::c8e0:2cff:fe9b:6d1f is sending a multicast hello message
every 4 seconds on bat0 interface, but as you can see from the dump
timing on a machine attached on the same switch they are not arriving
regurarly so what is happening? Is this normal?

here is the dump

eigenServer ~ # tcpdump -n -i bat0 udp port 6696 and host
fe80::c8e0:2cff:fe9b:6d1f                                    [4/323]
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on bat0, link-type EN10MB (Ethernet), capture size 96 bytes
14:45:19.295707 IP6 fe80::c8e0:2cff:fe9b:6d1f.6696 > ff02::1:6.6696:
UDP, length 151
14:45:40.133468 IP6 fe80::c8e0:2cff:fe9b:6d1f.6696 > ff02::1:6.6696:
UDP, length 76
14:45:53.357606 IP6 fe80::c8e0:2cff:fe9b:6d1f.6696 > ff02::1:6.6696:
UDP, length 76
14:46:01.118909 IP6 fe80::c8e0:2cff:fe9b:6d1f.6696 > ff02::1:6.6696:
UDP, length 76
14:46:01.227914 IP6 fe80::c8e0:2cff:fe9b:6d1f.6696 > ff02::1:6.6696:
UDP, length 79
14:46:03.210770 IP6 fe80::c8e0:2cff:fe9b:6d1f.6696 > ff02::1:6.6696:
UDP, length 79
14:46:04.161707 IP6 fe80::c8e0:2cff:fe9b:6d1f.6696 > ff02::1:6.6696:
UDP, length 76
14:46:04.308875 IP6 fe80::c8e0:2cff:fe9b:6d1f.6696 > ff02::1:6.6696:
UDP, length 79
14:46:09.058416 IP6 fe80::c8e0:2cff:fe9b:6d1f.6696 > ff02::1:6.6696:
UDP, length 76
14:46:21.473697 IP6 fe80::c8e0:2cff:fe9b:6d1f.6696 > ff02::1:6.6696:
UDP, length 53
14:47:12.359258 IP6 fe80::c8e0:2cff:fe9b:6d1f.6696 > ff02::1:6.6696:
UDP, length 76
14:47:13.063186 IP6 fe80::c8e0:2cff:fe9b:6d1f.6696 > ff02::1:6.6696:
UDP, length 76
14:47:14.094512 IP6 fe80::488e:c5ff:fee9:8901.6696 >
fe80::c8e0:2cff:fe9b:6d1f.6696: UDP, length 24
14:47:14.115996 IP6 fe80::c8e0:2cff:fe9b:6d1f.6696 >
fe80::488e:c5ff:fee9:8901.6696: UDP, length 40
14:47:18.288823 IP6 fe80::c8e0:2cff:fe9b:6d1f.6696 > ff02::1:6.6696:
UDP, length 76
14:47:24.098438 IP6 fe80::c8e0:2cff:fe9b:6d1f.6696 > ff02::1:6.6696:
UDP, length 76
14:47:31.905127 IP6 fe80::c8e0:2cff:fe9b:6d1f.6696 > ff02::1:6.6696:
UDP, length 151
14:47:36.944597 IP6 fe80::c8e0:2cff:fe9b:6d1f.6696 > ff02::1:6.6696:
UDP, length 76
14:47:51.131644 IP6 fe80::c8e0:2cff:fe9b:6d1f.6696 > ff02::1:6.6696:
UDP, length 60
14:48:11.621499 IP6 fe80::c8e0:2cff:fe9b:6d1f.6696 > ff02::1:6.6696:
UDP, length 151
14:48:24.418458 IP6 fe80::c8e0:2cff:fe9b:6d1f.6696 > ff02::1:6.6696:
UDP, length 76
14:48:27.608263 IP6 fe80::c8e0:2cff:fe9b:6d1f.6696 > ff02::1:6.6696:
UDP, length 151
14:48:30.003085 IP6 fe80::c8e0:2cff:fe9b:6d1f.6696 > ff02::1:6.6696:
UDP, length 20
14:48:31.567988 IP6 fe80::c8e0:2cff:fe9b:6d1f.6696 > ff02::1:6.6696:
UDP, length 76

batman version is the same on both host
eigenServer ~ # batctl -v
batctl gentoo-2012.2.0 [batman-adv: 2012.2.0]

thanks for help!
