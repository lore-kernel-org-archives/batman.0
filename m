Return-Path: <hannes.harms@tu-bs.de>
From: "Harms, Hannes" <hannes.harms@tu-bs.de>
Message-ID: <7dba317c-2fbb-2d4b-6d3f-17545395adbd@tu-bs.de>
Date: Thu, 20 Apr 2017 16:10:02 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] batman-adv route selection parameters
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

Hi community,

consider the following wireless network:

A <-- 60Mbit --> B <-- 60Mbit --> C
A < ----------5Mbit-------------------> C

Node A can talk to Node C via Node B
Node A can talk to C directly, but with a significant lower throughput.
All links have a  relative low package loss.

I run into the problem that batman-adv sometimes routes traffic directly 
from Node A to C.
with gives me 5 Mbit throughput, and sometimes route A-B-C is chosen, 
resulting in 25 Mbit throughput.

I have adjusted the originator interval to 200 ms, and the hop penalty 
to 1 without significant improvements.

Are the other ways to force batman-adv to chose route A-B-C ?

Thanks,
Hannes

-- 
Dipl.-Ing. Hannes Harms
Technische Universität Braunschweig
Institut für mobile Maschinen und Nutzfahrzeuge
Langer Kamp 19a
D-38106 Braunschweig

Durchwahl: +49 (0)531 391-7197
E-Mail:  hannes.harms@tu-braunschweig.de
http://www.tu-braunschweig.de/imn

