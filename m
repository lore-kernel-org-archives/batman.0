Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 9 May 2010 11:17:04 +0800
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_xki5LD1mNqUFJfq"
Message-Id: <201005091117.05627.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] sysfs abi documentation
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

--Boundary-00=_xki5LD1mNqUFJfq
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit


Hi,

Greg asked us to provide an ABI documentation for the files creates in the 
sysfs tree. Since I am respsonsible for the sysfs stuff, I felt it was my turn 
to draft something. Please check the attachments and let me know whether you 
think we can send it or not.

Cheers,
Marek

--Boundary-00=_xki5LD1mNqUFJfq
Content-Type: text/plain;
  charset="UTF-8";
  name="sysfs-class-net-mesh"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sysfs-class-net-mesh"


What:           /sys/class/net/<mesh_iface>/mesh/aggregate_ogm
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

What:           /sys/class/net/<mesh_iface>/mesh/originators
Date:           May 2010
Contact:        Marek Lindner <lindner_marek@yahoo.de>
Description:
                Displays the table of all batman nodes (in range) and
                the link quality towards them. Each line contains the
                following values:
                  1 - originator
                  2 - TQ (transmit quality) value of originator
                  3 - best next hop towards originator
                  4 - outgoing iface to reach best next hop
                  5 - list of alternative best next hops

What:           /sys/class/net/<mesh_iface>/mesh/transtable_global
Date:           May 2010
Contact:        Marek Lindner <lindner_marek@yahoo.de>
Description:
                Displays the table of mesh-wide announced mac
                addresses. Each line contains the following values:
                  1 - announced mac address
                  2 - originator announcing the mac address

What:           /sys/class/net/<mesh_iface>/mesh/transtable_local
Date:           May 2010
Contact:        Marek Lindner <lindner_marek@yahoo.de>
Description:
                Displays the table of mac addresses announced to the
                mesh network by this node. Each line contains the
                following values:
                  1 - announced mac address

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

What:           /sys/class/net/<mesh_iface>/mesh/vis_data
Date:           May 2010
Contact:        Marek Lindner <lindner_marek@yahoo.de>
Description:
                This file outputs the collected entire mesh topology
                information (if available) in a neutral (raw) format.
                Each line contains a set of identifiers. Values may
                or may not follow depending on their respective
                meanings:
                 * "mac" - mac address of an originator's source
                           interface (each line begins with it)
                 * "TQ mac  value" - src mac's link quality towards
                                     mac address of a neighbor
                                     originator's interface which is
                                     being used for routing
                 * "HNA mac" - HNA announced by source mac
                 * "PRIMARY" - this  is a primary interface
                 * "SEC mac" - secondary mac address of source
                               (requires preceding PRIMARY)

--Boundary-00=_xki5LD1mNqUFJfq
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

--Boundary-00=_xki5LD1mNqUFJfq--
