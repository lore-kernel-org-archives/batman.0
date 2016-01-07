Return-Path: <linus.luessing@c0d3.blue>
Date: Thu, 7 Jan 2016 04:39:33 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160107033933.GA2893@otheros>
References: <1451992006-13191-1-git-send-email-sven@narfation.org>
 <1451992006-13191-12-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1451992006-13191-12-git-send-email-sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH v4 12/31] batman-adv: Add compatibility
 code for kref_get_unless_zero
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

On Tue, Jan 05, 2016 at 12:06:27PM +0100, Sven Eckelmann wrote:
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 8, 0)
> +
> +static inline int __must_check kref_get_unless_zero(struct kref *kref)
> +{
> +	return atomic_add_unless(&kref->refcount, 1, 0);
> +}
> +
> +#endif /* < KERNEL_VERSION(3, 8, 0) */
> +
> +#endif /* _NET_BATMAN_ADV_COMPAT_LINUX_KREF_H_ */
> -- 
> 2.6.4
> 

Does not compile for me on a 3.2 kernel:

-----
/home/tux/dev/batman-adv-t_x/gen-compat-autoconf.sh /home/tux/dev/batman-adv-t_x/compat-autoconf.h
make -C /lib/modules/3.2.0-4-amd64/build M=/home/tux/dev/batman-adv-t_x/net/batman-adv CONFIG_BATMAN_ADV=m CONFIG_BATMAN_ADV_DEBUG=n CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=y INSTALL_MOD_DIR=updates/net/batman-adv/   modules
make[1]: Entering directory `/usr/src/linux-headers-3.2.0-4-amd64'
  CC [M]  /home/tux/dev/batman-adv-t_x/net/batman-adv/bat_iv_ogm.o
distcc[1604] ERROR: compile /home/tux/.ccache/tmp/bat_iv_ogm.tmp.krtek.1599.i on localhost failed
In file included from /usr/src/linux-headers-3.2.0-4-common/include/linux/kobject.h:24:0,
                 from /usr/src/linux-headers-3.2.0-4-common/include/linux/device.h:17,
                 from /usr/src/linux-headers-3.2.0-4-common/include/linux/dmaengine.h:24,
                 from /usr/src/linux-headers-3.2.0-4-common/include/linux/skbuff.h:30,
                 from /home/tux/dev/batman-adv-t_x/compat-include/linux/skbuff.h:25,
                 from /usr/src/linux-headers-3.2.0-4-common/include/linux/if_ether.h:133,
                 from /home/tux/dev/batman-adv-t_x/compat-include/linux/if_ether.h:25,
                 from /usr/src/linux-headers-3.2.0-4-common/include/linux/netdevice.h:29,
                 from /home/tux/dev/batman-adv-t_x/compat-include/linux/netdevice.h:25,
                 from /home/tux/dev/batman-adv-t_x/compat.h:52,
                 from <command-line>:1:
/home/tux/dev/batman-adv-t_x/compat-include/linux/kref.h:32:95: error: redefinition of ‘kref_get_unless_zero’
/usr/src/linux-headers-3.2.0-4-common/include/linux/kref.h:47:95: note: previous definition of ‘kref_get_unless_zero’ was here
make[4]: *** [/home/tux/dev/batman-adv-t_x/net/batman-adv/bat_iv_ogm.o] Error 1
make[3]: *** [_module_/home/tux/dev/batman-adv-t_x/net/batman-adv] Error 2
make[2]: *** [sub-make] Error 2
make[1]: *** [all] Error 2
make[1]: Leaving directory `/usr/src/linux-headers-3.2.0-4-amd64'
make: *** [all] Error 2
make  0,61s user 0,20s system 67% cpu 1,203 total
-----
