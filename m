Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 24 Mar 2010 12:52:18 +0800
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201003241252.18954.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] reorganized kernel interface patches (version 3)
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


Hi,

since my last patches did not trigger too many complaints I went ahead and 
submitted them. This opens the way for the last series of patches which 
conclude the matter. All remaining /proc files have been eliminated and moved 
over to /sys. While doing so, I reworked the interface handling to satisfy an 
old feature request: interfaces can be added & removed on the fly.

On startup batman-adv will scan the system for available interfaces to create 
a "batman_adv" subfolder in their respective /sys/class/net folder, e.g.
eth0: /sys/class/net/eth0/batman_adv
This subfolder will contain the settings which are relevant for this 
interface. You can tell batman-adv to use an interface by writing "bat0" into 
the mesh_iface file:
echo bat0 > /sys/class/net/eth0/batman_adv/mesh_iface
or write "none" to deactivate it:
echo none > /sys/class/net/eth0/batman_adv/mesh_iface
Although only "bat0" is accepted at this point, the syntax already gears 
towards multiple virtual mesh support. Later you will be able to create/name 
your virtual meshes by writing into this file. Retrieve the interface status by 
simply reading its status file:
cat /sys/class/net/eth0/batman_adv/iface_status

Note: batman-adv will continuously observe the system's interfaces. Whenever 
new interfaces appear or disappear batman will update the /sys/class/net 
folders automatically. Also, batman-adv will make sure that incompatible 
interfaces (e.g. loopback, non-ethernet, etc) won't have the subfolder, hence 
can't be activated.

The batctl interface syntax had to be modified in order to cope with these 
changes. You can run:
batctl interface
to get the list of active interfaces and their status. To add or delete 
interfaces you can run:
batctl interface add|del eth0 eth1 ..

Since removing an active interface is a tricky thing where many operations can 
go wrong I expect some crashes/race conditions in the code. I tested it a 
while on multiple machines with multiple interfaces and it works for me but 
I'm sure there are more bugs to find. 

Regards,
Marek
