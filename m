Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 16 Feb 2016 17:19:31 +0800
Message-ID: <4078590.3aHOALUhCA@voltaire>
In-Reply-To: <1455225357-15756-1-git-send-email-sven@narfation.org>
References: <1455225357-15756-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1721823.ZLXdj5yT37";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH-maint v2] batman-adv: Avoid endless loop
	in bat-on-bat netdevice check
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

--nextPart1721823.ZLXdj5yT37
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, February 11, 2016 22:15:57 Sven Eckelmann wrote:
> From: Andrew Lunn <andrew@lunn.ch>
> 
> batman-adv checks in different situation if a new device is already on top
> of a different batman-adv device. This is done by getting the iflink of a
> device and all its parent. It assumes that this iflink is always a parent
> device in an acyclic graph. But this assumption is broken by devices like
> veth which are actually a pair of two devices linked to each other. The
> recursive check would therefore get veth0 when calling dev_get_iflink on
> veth1. And it gets veth0 when calling dev_get_iflink with veth1.
> 
> Creating a veth pair and loading batman-adv freezes parts of the system
> 
>     ip link add veth0 type veth peer name veth1
>     modprobe batman-adv
> 
> An RCU stall will be detected on the system which cannot be fixed.
> 
>     INFO: rcu_sched self-detected stall on CPU
>             1: (5264 ticks this GP) idle=3e9/140000000000001/0
>     softirq=144683/144686 fqs=5249
>              (t=5250 jiffies g=46 c=45 q=43)
>     Task dump for CPU 1:
>     insmod          R  running task        0   247    245 0x00000008
>      ffffffff8151f140 ffffffff8107888e ffff88000fd141c0 ffffffff8151f140
>      0000000000000000 ffffffff81552df0 ffffffff8107b420 0000000000000001
>      ffff88000e3fa700 ffffffff81540b00 ffffffff8107d667 0000000000000001
>     Call Trace:
>      <IRQ>  [<ffffffff8107888e>] ? rcu_dump_cpu_stacks+0x7e/0xd0
>      [<ffffffff8107b420>] ? rcu_check_callbacks+0x3f0/0x6b0
>      [<ffffffff8107d667>] ? hrtimer_run_queues+0x47/0x180
>      [<ffffffff8107cf9d>] ? update_process_times+0x2d/0x50
>      [<ffffffff810873fb>] ? tick_handle_periodic+0x1b/0x60
>      [<ffffffff810290ae>] ? smp_trace_apic_timer_interrupt+0x5e/0x90
>      [<ffffffff813bbae2>] ? apic_timer_interrupt+0x82/0x90
>      <EOI>  [<ffffffff812c3fd7>] ? __dev_get_by_index+0x37/0x40
>      [<ffffffffa0031f3e>] ? batadv_hard_if_event+0xee/0x3a0 [batman_adv]
>      [<ffffffff812c5801>] ? register_netdevice_notifier+0x81/0x1a0
>     [...]
> 
> This can be avoided by checking if two devices are each others parent and
> stopping the check in this situation.
> 
> Fixes: 3d48811b27f5 ("batman-adv: prevent using any virtual device created
> on batman-adv as hard-interface") Signed-off-by: Andrew Lunn
> <andrew@lunn.ch>
> [sven@narfation.org: rewritten description, extracted fix]
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v2:
>  - fix kernel-doc warning
> 
>  net/batman-adv/hard-interface.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)

Applied in revision 2808f92.

Thanks,
Marek

--nextPart1721823.ZLXdj5yT37
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWwumjAAoJEFNVTo/uthzAzy4H/j3DgpVkCHQ/P1weXDo1uhtD
DjiWwN4VckbRTJxkhBA0NV0DJaS2rEEzkUodqImCNx1tj0uXjD0uJPJ9SRXEQ7je
VI6uEa3H6ppB2p+WDSslyFbdFxpE2kmL8GVdpiglW1NGywElqBlB49w5LLzWOXzQ
OLIvPJOd9cvL34rpEZjen7C3dzDJ4/+dY5pF/dfKXI6kpEKI+DigrZ4Ql3IqzQe7
24eNbKspd4nDysm2pQdmOi3r/6qZthxr5CijDYTq/G+yrF2VcSbEeX8fIj2ag8yX
JSkzVMg+ET4M7yzm3+8dypCA1F+i5PwmriSjC4WIUJ+ptITaCzVDqW2UHb6vwjI=
=Wm6Z
-----END PGP SIGNATURE-----

--nextPart1721823.ZLXdj5yT37--

