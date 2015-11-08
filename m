Return-Path: <alessandro@mediaspot.net>
From: Alessandro Bolletta <alessandro@mediaspot.net>
Date: Sun, 8 Nov 2015 23:45:14 +0000
Message-ID: <F52F175DFC537F48A43937B50B44BCA2820C1278@EXCHANGE.mediaspot.local>
Content-Language: it-IT
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [B.A.T.M.A.N.] bridge detaching crash
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>

Hi,
in my Openwrt x86 testbed, I created a bridge between a vlan over eth0 and =
a vlan over bat0.
It works as expected but, when I try to restart network, bridge seems to be=
 not correctly detached and networking stack gets hanged.

This is the dmesg: http://pastebin.com/rxUUGvgX

Can you help me to debug this crash?

Thanks,
Alessandro

