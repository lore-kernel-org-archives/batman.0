Return-Path: <benxuelan0402@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: jammy <benxuelan0402@gmail.com>
Message-Id: <A533453E-8AA5-4ADE-9E76-E0A56CA8130A@gmail.com>
Date: Thu, 9 Oct 2014 11:26:31 +0800
Mime-Version: 1.0 (1.0)
Subject: [B.A.T.M.A.N.] help for batman-adv with monitor WiFi card
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
To: "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>


Hi all=EF=BC=8C

Now i have build a mesh network with batman-adv routing algorithm=EF=BC=88ba=
tman-adv-2014.2.0=EF=BC=89and Linux 3.3.8. Each mesh node have one WiFi card=
 which is configued to the adhoc mode =EF=BC=88according to the suggestion o=
f openmesh website=EF=BC=89and 11A protocol.

But the data rate between two mesh nodes is only 8Mbps=EF=BC=8Cwhile if I co=
nfigure the same WiFi card in mesh node to AP mode and client mode=EF=BC=8Ct=
he datarate between them can achive 40Mbps.

I think the reason of the low data rate is caused by the adhoc mode=EF=BC=88=
my wireless driver is ath9k=EF=BC=8Cthe datarate of adhoc mode is slower ind=
eed=EF=BC=89

My questions are=EF=BC=9A
1. How can I raise the data rate to 30M+ if I use the adhoc mode=EF=BC=9F
2. can I use the monitor mode of WiFi card with batman-adv=EF=BC=9Fsomeone t=
ells that it can be done=EF=BC=8Cbut when I batctl addif wlan0 =EF=BC=88wlan=
0 is configured in monitor=EF=BC=89=EF=BC=8Cit shows that interface type not=
 support by batman-adv.

I am waiting for your replies and thank you very much.

from jammy's iPhone=
