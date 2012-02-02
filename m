Return-Path: <perazim@inbox.lt>
From: Perazim <perazim@inbox.lt>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 02 Feb 2012 12:45:39 +0200
Message-ID: <1328179539.3152.44.camel@travelmate.perazim.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] some basic questions
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

I am trying batman-adv on trunk openwrt for ubiquiti bullet2. I am using
trunk because I want 2011.4.0.

In menuconfig I select Kernel Modules/Network Support/Kmod-batgat +
kmod-batman-adv + enable batctl.

Now I see that in Network/Routing and redirection/Batmand is auto
selected (I cannot deselect it)

Is this normal behavior? I see that besides the kmods, I also have
batmand installed on the router. I thought that this would have not been
included after the introduction of batman-adv.

Is this normal behavior or is there something wrong with menuconfig that
is causing batmand to be included?

Thanks,

Perazim




