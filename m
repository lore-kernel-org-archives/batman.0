Return-Path: <surfbytes@gmail.com>
MIME-Version: 1.0
Date: Mon, 19 Nov 2012 20:25:34 -0800
Message-ID: <CAG_HyLz9B9r=u5jSw8xy+4rfG9anB6vqK+ggMGSmRossMCx4CQ@mail.gmail.com>
From: Randy Graham <surfbytes@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [B.A.T.M.A.N.] batman over 802.15.4 .
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

Hello,

I have recently discovered batman-adv and am very interesting in
getting it running on a custom embedded linux board we are developing.

I have a couple of questions:

1. Will batman-adv work over 802.15.4 ?

I have a microchip MRF24J40 802.15.4 module integrated on my linux
board (3.7.0-rc6), and can bring up wpan-phy0 and lowpan0 interfaces.

2. Can batman-adv work with either of these interfaces ?

I tried configuring these interfaces using 'batctl' but it complains
that they are an unsupported type.
'iwconfig' reports these interfaces as having 'no wireless extensions'
which I suspect is the issue.

Please let me know if running b.a.t.m.a.n. over 802.15.4 is feasible.


Thanks,

-Randy
