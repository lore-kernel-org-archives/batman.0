Return-Path: <me@irrelefant.net>
From: me <me@irrelefant.net>
Message-ID: <eba673b5-8caa-11ad-3317-19186263e17a@irrelefant.net>
Date: Thu, 10 May 2018 03:20:42 +0200
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------30A923DD93FB649A89B846F3"
Content-Language: de-LU
Subject: [B.A.T.M.A.N.] batman-adv: Bug: Missing TT entry leads to
 inconsistent but stable TT state
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

This is a multi-part message in MIME format.
--------------30A923DD93FB649A89B846F3
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

We have three nodes, which have the following topology:

NDS-Agenda21Haus70 <-> sn04 <-> sn03

Something happened, so they came into a stable (for hours) but inconsistent
state of their translation tables:

- sn03 has 11 entries in its translocal table and crc = 0x2b6d458c
- sn04 has only 10 entries in the table for sn03 but still crc = 0x2b6d458c
- NDS-Agenda21Haus70 has also 10 entries in the table for sn03 but crc = 0x74fb4f96

It seems as like something (erroneously) removed the entry 33:33:00:00:00:01
from table on node sn04 without recalculating the crc sum.

In the following are the outputs of the table states:

root@NDS-Agenda21Haus70:~# batctl tr 88:e6:40:20:30:01
traceroute to 88:e6:40:20:30:01 (88:e6:40:20:30:01), 50 hops max, 20 byte packets
 1: 88:e6:40:20:40:01  16.567 ms  20.593 ms  16.324 ms
 2: 88:e6:40:20:30:01  20.760 ms  19.826 ms  19.840 ms

root@NDS-Agenda21Haus70:~# batctl tg | grep 88:e6:40:20:30:01 
 * 33:33:ff:06:3e:25   -1 [....] (  3) 88:e6:40:20:30:01 (  3) (0x74fb4f96)
 * 33:33:ff:00:18:32   -1 [....] (  3) 88:e6:40:20:30:01 (  3) (0x74fb4f96)
   33:33:00:00:00:02   -1 [....] (  3) 88:e6:40:20:30:01 (  3) (0x74fb4f96)
   01:00:5e:00:00:fc   -1 [....] (  3) 88:e6:40:20:30:01 (  3) (0x74fb4f96)
   01:00:5e:00:00:01   -1 [....] (  3) 88:e6:40:20:30:01 (  3) (0x74fb4f96)
   33:33:ff:00:00:00   -1 [....] (  3) 88:e6:40:20:30:01 (  3) (0x74fb4f96)
 * 33:33:ff:00:30:01   -1 [....] (  3) 88:e6:40:20:30:01 (  3) (0x74fb4f96)
 * 2a:d7:9a:06:3e:25   -1 [....] (  3) 88:e6:40:20:30:01 (  3) (0x74fb4f96)
 * 33:33:ff:00:01:08   -1 [....] (  3) 88:e6:40:20:30:01 (  3) (0x74fb4f96)
   33:33:00:01:00:03   -1 [....] (  3) 88:e6:40:20:30:01 (  3) (0x74fb4f96)

[root@sn04]:~ # batctl tg | grep 88:e6:40:20:30:01
 * 33:33:ff:06:3e:25   -1 [....] (  3) 88:e6:40:20:30:01 (  3) (0x2b6d458c)
 * 33:33:ff:00:18:32   -1 [....] (  3) 88:e6:40:20:30:01 (  3) (0x2b6d458c)
   33:33:00:00:00:02   -1 [....] (  3) 88:e6:40:20:30:01 (  3) (0x2b6d458c)
   01:00:5e:00:00:fc   -1 [....] (  3) 88:e6:40:20:30:01 (  3) (0x2b6d458c)
   01:00:5e:00:00:01   -1 [....] (  3) 88:e6:40:20:30:01 (  3) (0x2b6d458c)
   33:33:ff:00:00:00   -1 [....] (  3) 88:e6:40:20:30:01 (  3) (0x2b6d458c)
 * 33:33:ff:00:30:01   -1 [....] (  3) 88:e6:40:20:30:01 (  3) (0x2b6d458c)
 * 2a:d7:9a:06:3e:25   -1 [....] (  3) 88:e6:40:20:30:01 (  3) (0x2b6d458c)
 * 33:33:ff:00:01:08   -1 [....] (  3) 88:e6:40:20:30:01 (  3) (0x2b6d458c)
   33:33:00:01:00:03   -1 [....] (  3) 88:e6:40:20:30:01 (  3) (0x2b6d458c)

[root@sn03]:~ # batctl tl
[B.A.T.M.A.N. adv 2018.0-3-g4b2b8c68, MainIF/MAC: mesh_fastd/88:e6:40:20:30:01 (bat0/2a:d7:9a:06:3e:25 BATMAN_IV), TTVN: 3]
Client             VID Flags    Last seen (CRC       )
33:33:ff:06:3e:25   -1 [.P....]   0.000   (0x2b6d458c)
33:33:ff:00:18:32   -1 [.P....]   0.000   (0x2b6d458c)
33:33:00:00:00:02   -1 [.P....]   0.000   (0x2b6d458c)
01:00:5e:00:00:fc   -1 [.P....]   0.000   (0x2b6d458c)
01:00:5e:00:00:01   -1 [.P....]   0.000   (0x2b6d458c)
33:33:ff:00:00:00   -1 [.P....]   0.000   (0x2b6d458c)
33:33:ff:00:30:01   -1 [.P....]   0.000   (0x2b6d458c)
2a:d7:9a:06:3e:25   -1 [.P....]   0.000   (0x2b6d458c)
33:33:ff:00:01:08   -1 [.P....]   0.000   (0x2b6d458c)
33:33:00:01:00:03   -1 [.P....]   0.000   (0x2b6d458c)
33:33:00:00:00:01   -1 [.P....]   0.000   (0x2b6d458c)

In the attachment, I added a capture of the received full table response from
sn04 -> NDS-Agenda21Haus70 taken on NDS-Agenda21Haus70. I checked, that this
is really an intermediate response of sn04 and not a direct response from sn03
(sn03 is not receiving queries from NDS-Agenda21Haus70).

Kind regards,
Leonardo Mörlein

--------------30A923DD93FB649A89B846F3
Content-Type: application/vnd.tcpdump.pcap;
 name="missing_tg_entry.pcap"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="missing_tg_entry.pcap"

1MOyoQIABAAAAAAAAAAAAAAABAABAAAAh2zzWkRDAgCqAAAAqgAAADp8+4vWN4jmQCBAAUMF
RA8yADp8+4vWM4jmQCAwAQCIAAAEAQCEFAMAASttRYwAAAAAAAAAADMz/wY+JQAAAAAAADMz
/wAYMgAADAAAADMzAAAAAgAAAAAAAAEAXgAA/AAADAAAAAEAXgAAAQAADAAAADMz/wAAAAAA
AAAAADMz/wAwAQAAAAAAACrXmgY+JQAAAAAAADMz/wABCAAADAAAADMzAAEAAwAA
--------------30A923DD93FB649A89B846F3--
