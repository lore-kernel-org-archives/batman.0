Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
MIME-Version: 1.0
From: dan <dandenson@gmail.com>
Date: Thu, 29 Dec 2022 13:15:53 -0700
Message-ID: 
 <CAA_JP8ULjMoUymX6M-Guz7Z0AcXZd8TOm3R_E8K-LTyiaNEOgA@mail.gmail.com>
Subject: using alfred (or other means) to collect link data
Content-Type: text/plain; charset="UTF-8"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

I'm looking for a way to collect link data between nodes.  My
google-fu has failed me on how to get node-to-node data like latency
or throughput etc.  Is there any model built in to batman-adv/alfred
to poll this data?  I only really finding the batvis data which is
just returning metric.

I'm mostly wanting to see how traffic is flowing, where links are
being more heavily used especially if those are not shortest paths
(suggests I have something to fix) and to keep track of a sort of high
water mark to metric ratio.  ie, this link has done 260Mbps with the
link metric <=1.2 in the last 48 hours and it's currently doing
105Mbps at 1.08 metric.

my current plan is to run scripts to find 1 hop neighbors and either
so an arp-scan or find IP and ping directly on a schedule and store
that in alfred or just push it up to my database but this is a little
brute-forcy considering batman-adv is doing some of this work to
create the route metric in the first place.

Any advice appreciated.  Thanks.
