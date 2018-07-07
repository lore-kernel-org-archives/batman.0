Return-Path: <dandenson@gmail.com>
MIME-Version: 1.0
From: dan <dandenson@gmail.com>
Date: Sat, 7 Jul 2018 13:31:16 -0600
Message-ID: <CAA_JP8U1Y43WmPgG4g_+US-oOt+ZXEs7Wtnh9+A1a7cai8cLYg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [B.A.T.M.A.N.] What is link throughput used for?
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

I'm not finding a document describing how link throughput is used in
routing decisions but I see in 2016.1 setting this value (and the
default of learning it) are described:

Throughput override
Available since: batman-adv 2016.1

Defines the throughput value to be used by B.A.T.M.A.N. V when
estimating the link throughput for all neighbors connected to this
interface. If the value is set to 0 then batman-adv will try to
estimate the throughput by itself by either querying the WiFi driver
or the Ethernet interface. B.A.T.M.A.N. IV ignores the setting
entirely.

cat /sys/class/net/eth0/batman_adv/throughput_override
0.0 MBit


How is this used?  Where's the documentation?

Thanks.
