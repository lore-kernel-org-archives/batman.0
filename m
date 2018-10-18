Return-Path: <guohuizou2000@sina.com>
From: "gary" <guohuizou2000@sina.com>
Date: Thu, 18 Oct 2018 13:53:44 +0800
Message-ID: <02ef01d466a6$f0c629f0$d2527dd0$@sina.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: zh-cn
Subject: [B.A.T.M.A.N.] alfred and batadv-vis issue
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


Hello guys,

I setup a testbed like this.  (BBN =3D backbone node)

Switch ---------->BBN1 --------------->MP1
        |
		------->BBN2---------------->MP2

MP1 and MP2 may select BBN1 or BBN2 as gateway.=20
On both MP1 and MP2, I enable Alfred and batadv-vis as follows:
alfred -i br0 -4 224.0.0.1 -m &
batadv-vis -i bat0 -s

when I run batadv-vis again on MP1, I can't get the info from MP2.=20
If I ping the ip address of MP2 from MP1, MP1 will get MP2's mac address =
by arp.
And then I run batadv-vis again, I can get the data from MP2 now.

Is there any configure or method to get MP2's info without ping test?

Thanks,
Gary

  =20


