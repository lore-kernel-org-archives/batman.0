Return-Path: <john@blastwaveinc.com>
From: John Gorkos <john@blastwaveinc.com>
Message-ID: <babe56e8-b12c-8236-7012-20bb91d400fa@blastwaveinc.com>
Date: Mon, 1 Oct 2018 11:01:25 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] B.A.T.M.A.N. port to ESP32
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

I'm working on a port of the BATMAN-ADV protocol to FreeRTOS,
specifically running on the ESP32 from EspressIF.

I'm currently sending and receiving what seem to be correctly formed OGM
messages from BATMAN IV.  For now, my goal is interoperability with
Raspberry Pis running BATMAN from stock Raspbian.

From the RasPi, I am able to see the ESP32 as a neighbor, but not as an
originator:
pi@pi-16:~ $ sudo batctl n
[B.A.T.M.A.N. adv 2017.3, MainIF/MAC: wlan0/b8:27:eb:a0:2a:53
(bat0/e6:46:65:5b:c4:c4 BATMAN_IV)]
IF             Neighbor              last-seen
        wlan0	  30:ae:a4:3b:9a:d4    0.090s
pi@pi-16:~ $ sudo batctl o
[B.A.T.M.A.N. adv 2017.3, MainIF/MAC: wlan0/b8:27:eb:a0:2a:53
(bat0/e6:46:65:5b:c4:c4 BATMAN_IV)]
   Originator        last-seen (#/255) Nexthop           [outgoingIF]

Can someone explain to me why this might be occurring, and what I'm
missing?  Currently, the code is doing two things:  sending a new OGM
with an incrementing sequence number every 1000 ms, and re-broadcasting
any received OGMs with a decremented TTL, modified TQ, and DirectLink
flag set whenever it receives them (also every 1000 ms or so).
Internally, I'm getting close to having the routing algorithm
implemented, but it looks like I'm doing something "wrong" in the eyes
of the BATMAN implementation on the Pis.  I'd be happy to provide packet
dumps on request.

Thank you in advance.
John Gorkos


