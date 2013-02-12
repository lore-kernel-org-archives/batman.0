Return-Path: <carlos.reymoreno@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAPkwMUf0fN-nVMCeMvm=EvrTLzjXK6ajbJsv5-KBZBEQAJUQ-g@mail.gmail.com>
References: <CAPkwMUf0fN-nVMCeMvm=EvrTLzjXK6ajbJsv5-KBZBEQAJUQ-g@mail.gmail.com>
Date: Tue, 12 Feb 2013 07:00:33 +0200
Message-ID: <CAPkwMUfKFcpt6cQDdJ9OZYQg2vSYWHc3Whdgce_kt2nSk3urpw@mail.gmail.com>
From: Carlos Rey-Moreno <carlos.reymoreno@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [B.A.T.M.A.N.] Fwd: Beacons colliding with OGMs
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

Hi everyone,

I'm new to the list, although I've been using batman-adv for a year
now via a couple of networks I've deployed using Mesh Potatoes (based
on openwrt). Thank you very much for the work, the result is very,
very good.

In one of the networks I'm facing from the beginning some problems due
to collisions, thus reducing the TQ in some links, that I'd like to
avoid in order to optimize performance. One of the messages that could
be colliding with the OGMs are the WiFi beacons. I'm a bit confused
about the beacon transmission. I posted these questions in the
villagetelco list, but they recommended me to ask them here too. Hope
you can help me.

The mesh is created using ahdemo and according to Madwifi this mode
does not use beacons. However, athstats is showing many beacons being
transmitted. I guess those are the ones transmitted from the VAP also
configured in the same physical interface as the ahdemo.
The option sw_merge is recommended to be active in the ahdemo
interface to avoid the hardware to try to synchronize the timestamps
from the beacons. In addition, it is recommended to create the VAP
with option nosbeacon activated for the same reason.

According to athstats, beacons are being tx, I guess those from the
VAP. However, I'm not sure if athstats is reporting properly, since
the chipset does not have diversity for TX, but athstats is reporting
so.
- If there are no beacons in the mesh (due to ahdemo), or even if
there are (from the VAP), and we disable the synchronization of
timestamps with the options sw_merge and nosbeacon, how the MPs get
their time synchronization as for sharing the same reference when
using protocol timers (slottimes, DIFS, etc...) so important for
avoiding collisions?
- If there are no beacons in the mesh, how do the nodes get the
information contained in the beacons about the capabilities of their
neighbors (protection, short preamble, etc) as for allowing 11bg
seamless operation, from the VAP beacons?
- Given the network it is going to be, at least during some months,
very static (both in mesh nodes and clients) and assuming the beacons
are coming from the VAP, what values would make sense to use as beacon
interval and OGM interval, respectively, for avoiding collisions and
keeping performance?

Thank you very much in advance,

Regards

carlos



--
Note that I am using a new email account carlos.reymoreno@gmail.com,
and that the former email address crey@ehas.org will be disappearing
soon. Thanks for changing this in your contact list.

Carlos Rey-Moreno
Research Assistant
Office 1.28
Department of Computer Science
University of the Western Cape
Private Bag X17 - Bellville, 7535
Cape Town - South Africa

Tel: +27 (0) 21 959 2562
Cel: +27 (0) 76 986 3633

Skype: carlos.reymoreno
Twitter: Creym
