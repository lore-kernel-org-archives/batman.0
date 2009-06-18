Return-Path: <jacobmarble@gmail.com>
MIME-Version: 1.0
Date: Thu, 18 Jun 2009 12:42:54 -0600
Message-ID: <5161afcd0906181142o4c85ef5dr85fa1c2f54376fc7@mail.gmail.com>
From: Jacob Marble <jacobmarble@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] opkg doesn't rmmod
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

Using OpenWrt SVN and batman-advanced SVN (yay!).

When I "opkg remove kmod-batman-adv-kernelland", the kernel module
stays loaded, so when I "opkg install kmod-batman-adv-[newer version]"
the old module stays loaded.  A simple rmmod gets rid of the old
module.

There is a script in the openwrt SVN called postinst that inserts the
module after install.  Very convenient.  A similar script could be
added, called prerm, that would remove the module before removing the
ipk.  There are several ways to rmmod; "rmmod -f batman-adv" might be
best for removing the package.

When I create the file in my build_dir, make just deletes it, so I
leave this up to someone else (Marek?).

Jake

-- 
Jacob Marble
435 760 4321
jacobmarble@gmail.com
