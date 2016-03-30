Return-Path: <mika.rajala@patria.fi>
From: Mika Rajala <mika.rajala@patria.fi>
Date: Wed, 30 Mar 2016 07:31:45 +0000
Message-ID: <DB5PR01MB18642060A402BE7C992F1E0FF1980@DB5PR01MB1864.eurprd01.prod.exchangelabs.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [B.A.T.M.A.N.] Ip rule issue
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

Hi

I'm using the latest batmand with ns-3 to test routing.

I'm a bit of a newbie with this stuff, so this might be really simple

I'm not getting a ping through to 10.1.4.2, from a node that has this in it=
s routing table

ip route ls table 66
10.1.4.2 via 10.1.2.2 dev eth 0  proto static  src 10.1.2.3
// and so on

I'm guessing it's because of this
ip rule
0:                         from all lookup local
6600:                  from all to 10.1.2.0/24 lookup 66
6699:                  from all lookup 65
6700:                  from all to 10.1.2.0/24 lookup 67
32766:                from all lookup main
32767:                from all lookup default

It isn't being told to look for the route to 10.1.4.2 from the table 66 whe=
re the route is stored.

-mika
