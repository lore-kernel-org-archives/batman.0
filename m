From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 12 Jun 2009 19:13:16 +0800
References: <5161afcd0906111040v1e2831ccv79c8ab6a5ca6cb58@mail.gmail.com>
	<5161afcd0906111112p2cf55955o757f87dc6f75cb41@mail.gmail.com>
	<5161afcd0906111246y446d9bc4hf145a3423ff6653e@mail.gmail.com>
In-Reply-To: <5161afcd0906111246y446d9bc4hf145a3423ff6653e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200906121913.40206.lindner_marek@yahoo.de>
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

On Friday 12 June 2009 03:46:05 Jacob Marble wrote:
> I removed the batmand-adv package, and all is well.  This must be the
> userspace version.

Yes, you should not use the kernel version and the user space version at the 
same time. Actually, the user space version is obsolete and has been removed 
from our SVN (http://www.open-mesh.net/changeset/1283) and from OpenWRT 
lately. It created more confusion than anything else.


> The openwrt packages required for batman-adv-kernelland to work
> properly are kmod-batman-advanced and battool (handy; not required).
> Installing kmod-batman-advanced also inserts the batman-adv module,
> creating bat0; no insmod or reboot required.
> "opkg install kmod-batman-advanced battool"
>
> Add ath0 to bat0:
> "echo ath0 > /proc/net/batman-adv/interfaces"
>
> Configure the batman interface:
> "ifconfig bat0 10.0.1.x netmask 255.255.255.0"
>
> Do this to two or more openwrt boxes aka "mesh nodes".  Be sure that
> the adhoc network is configured the same on all nodes.

Great that you found your way through. We seeking to make things more obvious 
- any hints ?

Regards,
Marek

