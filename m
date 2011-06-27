Return-Path: <ipmax2011@googlemail.com>
MIME-Version: 1.0
Date: Mon, 27 Jun 2011 09:48:38 +0200
Message-ID: <BANLkTi=cK3LA-563FvccPOH8eZoXHurysA@mail.gmail.com>
From: Max Ip <ipmax2011@googlemail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [B.A.T.M.A.N.] batman-adv 2011.1.0 network interface setup
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hi all,

I setup the virtual interface bat0 which embeds wlan0 for my system.
As described in the batman-adv README file, I did

# insmod batman-adv.ko and
# echo bat0 > /sys/class/net/wlan0/batman_adv/mesh_iface

I can thus enable bat0 interface and start the batman-adv protocol in
multihop environment.

However, when I restart the computer, I need to again load the kernel
module and start the process from beginning.

I would like to run bat0 interface directly after restarting the
computer (like we have it for wlan0 or eth0)

Could you please help me how do I do this?

Thanks in advance

Max
