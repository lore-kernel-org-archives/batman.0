Return-Path: <duttaabhinanda@gmail.com>
MIME-Version: 1.0
From: Abhinanda Dutta <duttaabhinanda@gmail.com>
Date: Wed, 2 Aug 2017 12:54:13 -0400
Message-ID: <CAAAG0x8tVYAFisRAE6iLdvoPuKFcpyMQ0vS_DD72+AjcUWcQ6w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [B.A.T.M.A.N.] help regarding interfacing b.a.t.m.a.n with
 mininet-wifi
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

I am currently trying to interface batman with an emulator called
Mininet-wifi. My emulator is emulating the wifi-direct where there are
4 mobile stations and there are 2 wlan. I am trying to use batman for
routing so that I can ping between stations which are not in the same
wlan through a hop.

The problem I am facing is though batctl functions are working fine,
it is not interacting with the real mininet-wifi environment.

By that I mean if I use batctl tr MAC_ADDRESS it traces the route
between nodes even if they are on 2 different wlan or batctl p
MAC_ADDRESS pings the 2 stations. However if I try to see the route in
the real Linux terminal using route or watch route command it doesn't
show the route or ping between stations.

Is there any way to make batman-adv interact with the real
mininet-wifi environment.

Thanks,
Abhinanda
