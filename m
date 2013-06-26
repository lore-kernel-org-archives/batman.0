Return-Path: <jonsmirl@gmail.com>
MIME-Version: 1.0
Date: Wed, 26 Jun 2013 13:30:18 -0400
Message-ID: <CAKON4Ox2+uFUWR5ZBQ8yHdWZWW0zrxAgkd8iv-QG3DtTnVKJWQ@mail.gmail.com>
From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [B.A.T.M.A.N.] single radio routers and ap/adhoc interfaces
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

I'd like to setup batman up on single radio routers. I've installed
openwrt on three different chipsets now (RT3050, RT5350, AR9331) and
none of these wireless drivers implements support for simultaneous
adhoc and ap mode on virtual interfaces.

Yet when I google around I see lots of examples of people using single
radio routers with dual adhoc and ap mode virtual interfaces.  So
which radios support simultaneous adhoc/ap mode?

From AR9331...
valid interface combinations:
* #{ managed, WDS, P2P-client } <= 2048, #{ AP, mesh point, P2P-GO }
<= 8, #{ IBSS } <= 1,
  total <= 2048, #channels <= 1, STA/AP BI must match
* #{ AP } <= 1,
  total <= 1, #channels <= 1, STA/AP BI must match, radar detect
widths: { 20 MHz (no HT), 20 MHz }


--
Jon Smirl
jonsmirl@gmail.com
