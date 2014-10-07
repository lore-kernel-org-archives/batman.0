Return-Path: <syedmoulana47@gmail.com>
MIME-Version: 1.0
Date: Tue, 7 Oct 2014 17:27:50 +0800
Message-ID: <CAKKX4kEYFJoSQLndrvP7E1pYP7PehPitWkTjv38bEG9iT-tjng@mail.gmail.com>
From: syed moulana <syedmoulana47@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [B.A.T.M.A.N.] batman-adv bonding feature - unable to get data
 packets fragmented into multiple wireless interfaces
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
To: b.a.t.m.a.n@lists.open-mesh.org

hi

I tested the throughput between point to point mesh nodes using single
and 2 radios.

1.  Using single radio (ch 5180)  the resulting throughput for HT40+
           TCP max 250mbit/s
           UDP - max 320mbit/s

2. Using 2 radios with and without batctl bonding enabled (ch 5180 for
wlan0, ch 5785 for wlan1), the resulting throughput for HT40+ is same.
           with batctl bonding and fragmentation enabled I believed I
should be getting 50% gain in througput.
    When I monitor the wlan0 and wlan1 interfaces using batctl tcpdump
-p 4 wlanx I can see that iperf data are interleaved.
    There is no splitting of data frames into 2 wireless interfaces.

Please advice

Tq

Syed
