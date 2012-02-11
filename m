Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 12 Feb 2012 01:20:09 +0800
References: <1807712.xKAsDcUsSn@g10h4cklab>
	<201202111758.29202.lindner_marek@yahoo.de>
	<1590796.df4KKcFED8@g10h4cklab>
In-Reply-To: <1590796.df4KKcFED8@g10h4cklab>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201202120120.10360.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] batman openwrt
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

On Sunday, February 12, 2012 00:51:53 Gioacchino Mazzurco wrote:
> root@OpenWrt:~# cat /etc/config/batman-adv 
> 
> config 'mesh' 'bat0'
>         option 'fragmentation' '1'
>         option 'gw_mode' 'client'
>         list 'interfaces' 'clients'
>         list 'interfaces' 'nmeshwifi0'


Are you sure this configuration ever worked ?

The default config looks like this:

config 'mesh' 'bat0'
        option 'interfaces' 'mesh'
        option 'aggregated_ogms'
        option 'ap_isolation'
        option 'bonding'
        option 'fragmentation'
        option 'gw_bandwidth'
        option 'gw_mode'
        option 'gw_sel_class'
        option 'log_level'
        option 'orig_interval'
        option 'vis_mode'

# yet another batX instance
# config 'mesh' 'bat5'
#       option 'interfaces' 'second_mesh'


Pay close attention to the "interfaces" option - it is not a list and never 
was.

Regards,
Marek
