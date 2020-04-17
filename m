Return-Path: <moritzwarning@web.de>
From: Moritz Warning <moritzwarning@web.de>
Subject: batman cpu usage of multiple instances
Message-ID: <97bf748d-16e5-d088-118f-6f3678300191@web.de>
Date: Fri, 17 Apr 2020 03:23:23 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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

Hi,

I have many batman-adv instances (~1000) running on one computer in a Linu=
x network namespace each.

Top shows me that a single kernel worker is handling batman-adv:
  PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMA=
ND
29251 root      20   0       0      0      0 R  99.3   0.0  18:03.27 kwork=
er/u32:3+bat_events

Is there a way to let those multiple batman-adv instances make use of the =
other cores?

thanks,
Moritz
