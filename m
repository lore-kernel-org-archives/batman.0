Return-Path: <gregkh@suse.de>
Date: Sat, 22 May 2010 07:32:44 -0700
From: Greg KH <gregkh@suse.de>
Message-ID: <20100522143244.GA4070@suse.de>
References: <201005221616.46785.sven.eckelmann@gmx.de>
	<1274537833-2512-10-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1274537833-2512-10-git-send-email-sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 10/10] Documentation: ABI: Add
 information about batman-adv sysfs entries
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
To: Sven Eckelmann <sven.eckelmann@gmx.de>
Cc: Marek Lindner <lindner_marek@yahoo.de>, b.a.t.m.a.n@lists.open-mesh.net

On Sat, May 22, 2010 at 04:17:13PM +0200, Sven Eckelmann wrote:
> From: Marek Lindner <lindner_marek@yahoo.de>
> 
> Add documents about new sysfs entries in
>  * /sys/class/net/<iface>/batman-adv/mesh_iface
>  * /sys/class/net/<mesh_iface>/mesh/vis_mode
> 
> Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
> Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
> ---
>  .../ABI/testing/sysfs-class-net-batman-adv         |   14 ++++++++++
>  Documentation/ABI/testing/sysfs-class-net-mesh     |   27 ++++++++++++++++++++

For now, can you keep this within the drivers/staging/batman/ directory,
just so everything is nice and self-contained?  When it moves to the
main part of the kernel tree, then it can move into the
Documentation/ABI/testing/ directory, ok?

> +What:           /sys/class/net/<mesh_iface>/mesh/vis_mode
> +Date:           May 2010
> +Contact:        Marek Lindner <lindner_marek@yahoo.de>
> +Description:
> +                Each batman node only maintains information about its
> +                own local neighborhood, therefore generating graphs
> +                showing the topology of the entire mesh is not easily
> +                feasible without having a central instance to collect
> +                the local topologies from all nodes. This file allows
> +                to activate the collecting (server) mode. Once
> +                activated the topology can be retrieved by reading
> +                the vis_data file.

Isn't the vis_data file in debugfs now?  If so, shouldn't this file move
there as well?  Or at least don't point to a file that doesn't exist in
sysfs :)

thanks,

greg k-h
