Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 21 Jun 2010 12:38:50 +0200
References: <1276908713-28365-1-git-send-email-sven.eckelmann@gmx.de>
	<1276908713-28365-7-git-send-email-sven.eckelmann@gmx.de>
	<201006211104.54197.sven.eckelmann@gmx.de>
In-Reply-To: <201006211104.54197.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_6E0HM1CDIFH5Vqh"
Message-Id: <201006211238.51542.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 6/8] Staging: batman-adv: Add bonding
	functionality
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
Cc: Greg KH <greg@kroah.com>, b.a.t.m.a.n@lists.open-mesh.net, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

--Boundary-00=_6E0HM1CDIFH5Vqh
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit

On Monday 21 June 2010 11:04:53 Sven Eckelmann wrote:
> I noticed that the bonding file in sysfs is not documented while working on
> batctl yesterday. Can you please provide a short text for
>  http://git.kernel.org/?p=linux/kernel/git/next/linux-next.git;a=blob;f=dri
> vers/staging/batman-adv/sysfs-class-net-mesh

I attached the new file. Will that do ?

Cheers,
Marek

--Boundary-00=_6E0HM1CDIFH5Vqh
Content-Type: text/plain;
  charset="UTF-8";
  name="sysfs-class-net-mesh"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sysfs-class-net-mesh"


What:           /sys/class/net/<mesh_iface>/mesh/aggregated_ogms
Date:           May 2010
Contact:        Marek Lindner <lindner_marek@yahoo.de>
Description:
                Indicates whether the batman protocol messages of the
                mesh <mesh_iface> shall be aggregated or not.

What:           /sys/class/net/<mesh_iface>/mesh/bonding
Date:           June 2010
Contact:        Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
Description:
                Indicates whether the data traffic going through the
                mesh will be sent using multiple interfaces at the
                same time (if available).

What:           /sys/class/net/<mesh_iface>/mesh/orig_interval
Date:           May 2010
Contact:        Marek Lindner <lindner_marek@yahoo.de>
Description:
                Defines the interval in milliseconds in which batman
                sends its protocol messages.

What:           /sys/class/net/<mesh_iface>/mesh/vis_mode
Date:           May 2010
Contact:        Marek Lindner <lindner_marek@yahoo.de>
Description:
                Each batman node only maintains information about its
                own local neighborhood, therefore generating graphs
                showing the topology of the entire mesh is not easily
                feasible without having a central instance to collect
                the local topologies from all nodes. This file allows
                to activate the collecting (server) mode. Once
                activated the topology can be retrieved by reading
                the vis_data file.

--Boundary-00=_6E0HM1CDIFH5Vqh--
