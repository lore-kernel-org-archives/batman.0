Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 11 May 2012 16:25:16 +0800
References: <20120510231649.Horde.mtJYKOanEAJPrD5R7pqW_NA@beta.mail.sapo.pt>
In-Reply-To: <20120510231649.Horde.mtJYKOanEAJPrD5R7pqW_NA@beta.mail.sapo.pt>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201205111625.16609.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Fwd: Batman-adv simple configuration example
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

On Friday, May 11, 2012 06:16:49 Pedro Nuno Costa Rodrigues wrote:
> The batman-adv-devel version didn't work...:
> 
> In the:https://dev.openwrt.org/wiki/GetSource
> 
> downloaded: svn co svn://svn.openwrt.org/openwrt/trunk/
> 
> with this feed in feeds.conf.default:
> src-svn batman http://downloads.open-mesh.org/svn/openwrt-feed/

That is the package for developers. You only want to use it if you really know 
what you are doing.


> The only thing that didn't start with the boot of the routers was the:
> -option 'gw_bandwidth' '5mbit/1024kbit'
> -option 'gw_mode' 'server'
> -option 'vis_mode' 'server'

I just tried to replicate the problem but I can't (using the latest trunk 
package). Here my simple batman-adv configuration file:

cat /etc/config/batman-adv 

config 'mesh' 'bat0'
        option 'interfaces' 'eth1'
        option 'vis_mode' 'server'
        option 'gw_mode' 'server'
        option 'gw_bandwidth' '5mbit/1024kbit'


The corresponding logread output after starting batman-adv:

root@OpenWrt:/# batman-adv start
batman_adv: bat0: Adding interface: eth1
batman_adv: bat0: Interface activated: eth1
batman_adv: bat0: Changing gateway bandwidth from: '41' to: '49' (propagating: 
4MBit/1024KBit)
batman_adv: bat0: Changing gw mode from: off to: server
batman_adv: bat0: Changing vis mode from: client to: server

Regards,
Marek
