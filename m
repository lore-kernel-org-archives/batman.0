Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 22 May 2010 06:53:15 +0800
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_b7w9LI/SVPUxaHz"
Message-Id: <201005220653.15929.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] sysfs & debugfs
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

--Boundary-00=_b7w9LI/SVPUxaHz
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit


Hi,

thanks to Sven's patches we made the transition to debugfs rather quickly. All 
batman tables (originator table / gateway table / translation tables) and the 
vis data output have been relocated to debugfs. Even the former batman device 
(used for layer2 icmp data) has been moved to debugfs which brings us an 
important step closer to the multiple mesh support.

@Andrew: I attached the revised sysfs ABI files. Do you think it is feasible to 
get these last patches into 2.6.35 ?

Cheers,
Marek

--Boundary-00=_b7w9LI/SVPUxaHz
Content-Type: text/plain;
  charset="UTF-8";
  name="sysfs-class-net-batman-adv"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sysfs-class-net-batman-adv"


What:           /sys/class/net/<iface>/batman-adv/mesh_iface
Date:           May 2010
Contact:        Marek Lindner <lindner_marek@yahoo.de>
Description:
                The /sys/class/net/<iface>/batman-adv/mesh_iface file
                displays the batman mesh interface this <iface>
                currently is associated with.

What:           /sys/class/net/<iface>/batman-adv/iface_status
Date:           May 2010
Contact:        Marek Lindner <lindner_marek@yahoo.de>
Description:
                Indicates the status of <iface> as it is seen by batman.

--Boundary-00=_b7w9LI/SVPUxaHz
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

--Boundary-00=_b7w9LI/SVPUxaHz--
