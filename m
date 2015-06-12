Return-Path: <carlosmeralto@gmail.com>
MIME-Version: 1.0
Date: Fri, 12 Jun 2015 13:31:54 +0100
Message-ID: <CALaFpeVMwOE5DtHoDWVA+CBXq2jMuKLdmU-CcOWhCNRkHQ9F5w@mail.gmail.com>
From: Carlos Meralto <carlosmeralto@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [B.A.T.M.A.N.]  batman-adv: Force line topology
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

Hello, I am developing my thesis on mesh networks. And I'm currently
doing some tests with batman-adv.
So my question is:
I need to create a line topology. For example:
A-> B-> C-> D

Of all the options I tried, I could not find a solution to do this
https://lists.open-mesh.org/pipermail/batman/2012-September/008019.html
https://lists.open-mesh.org/pipermail/batman/2011-July/005169.html

I can not use the ebtables because I am using the wlan0 interface. And
when I try to create a bridge on the interface (wlan0) gives me an
error.

root@OpenWrt:~# batctl if del adhoc0
root@OpenWrt:~# brctl addbr bridgeWlan
root@OpenWrt:~# brctl addif bridgeWlan adhoc0
brctl: bridge bridgeWlan: Operation not supported

There is already a way to force a topology in batman-adv?

I'm blocked with no solution.

Thanks in advance.
