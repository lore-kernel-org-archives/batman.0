Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 3 Jan 2013 23:00:04 +0800
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201301032300.04942.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Packet-Loss-Peaks in a Freifunk-Network
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: Bonn und Umgebung Allgemeine Mailingliste zum Freifunk =?iso-8859-1?q?K=F6ln?= <freifunk-bonn@lists.bonn.freifunk.net>

On Thursday, January 03, 2013 22:16:32 Jan L=FChr wrote:
> We noticed a few, unusual things:
> -> regardless of the link tested (kif or fastd3) and regardless of the no=
de
> (node1, node2) small interruptions (loss-peaks) are appearing. -> These
> peaks appear almost synchronous, a few "noise" comes from different
> vpn-links and node-wan-uplinks. -> Since all links are wired, radio-noise
> won't have an impact
> -> The losses appear in batman-adv 2011.2.0 as well as in batman-adv
> 2012.4.0. Thus I suspect that batman-adv is triggering theses
> interruptions.

If you believe batman-adv is the culprit, please remove batman-adv from you=
r=20
test setup and repeat the exact same test. Otherwise we move into the realm=
 of=20
speculation.

Haven't heard of any "peak loss" due to batman-adv.

Cheers,
Marek


PS: Forgot to click "reply to all", sorry for that.
