MIME-Version: 1.0
In-Reply-To: <5161afcd0906111112p2cf55955o757f87dc6f75cb41@mail.gmail.com>
References: <5161afcd0906111040v1e2831ccv79c8ab6a5ca6cb58@mail.gmail.com>
	<5161afcd0906111112p2cf55955o757f87dc6f75cb41@mail.gmail.com>
Date: Thu, 11 Jun 2009 13:46:05 -0600
Message-ID: <5161afcd0906111246y446d9bc4hf145a3423ff6653e@mail.gmail.com>
From: Jacob Marble <jacobmarble@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] batman advanced in openwrt
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net

I ran iwconfig and this shows bat0.  So I did a little reading about ifconfig.

"cat /proc/net/batman-adv/originators" shows potential nexthops properly.
"battool ping ..." works.

I removed the batmand-adv package, and all is well.  This must be the
userspace version.

In summary:

Install OpenWrt.  Create an adhoc network on wifi0.  I used LuCI to do
this.  It will configure an interface ath0.

The openwrt packages required for batman-adv-kernelland to work
properly are kmod-batman-advanced and battool (handy; not required).
Installing kmod-batman-advanced also inserts the batman-adv module,
creating bat0; no insmod or reboot required.
"opkg install kmod-batman-advanced battool"

Add ath0 to bat0:
"echo ath0 > /proc/net/batman-adv/interfaces"

Configure the batman interface:
"ifconfig bat0 10.0.1.x netmask 255.255.255.0"

Do this to two or more openwrt boxes aka "mesh nodes".  Be sure that
the adhoc network is configured the same on all nodes.
