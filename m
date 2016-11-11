Return-Path: <dandenson@gmail.com>
MIME-Version: 1.0
From: dan <dandenson@gmail.com>
Date: Fri, 11 Nov 2016 07:26:36 -0700
Message-ID: <CAA_JP8UVeCpytzkirob9WsOA0BOkhVgZyA-Wa1=p+PV0hgRx8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [B.A.T.M.A.N.] MTU for batman-adv w/ vlans?
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

I'm not 100% clear on how batman-adv works with vlans, so excuse me if
I've taken a wrong path.


I have a small 2 radio mesh node with 1 ethernet port for non-mesh
access.  wlan0 and wlan1 in bat0, bat0 and eth0 in mesh-bridge.

MTU is 1532 on WLAN0.

If I want a VLAN to pass through the eth0 interface as if it were
trunk, what needs to be done?
my thought was, increase WLAN0 MTU to 1536 and eth0 to 1504....

will that work?  or do I need to create a vlan  bat0.1 and eth0.1 and
bridge them?

Thanks
