Return-Path: <gofb-b.a.t.m.a.n@m.gmane.org>
From: Rahul Amin <rahul.amin@ll.mit.edu>
Date: Tue, 22 Jul 2014 16:06:34 +0000 (UTC)
Message-ID: <loom.20140722T174753-266@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] Batman-adv support for LXC containers
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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

Hi,
 
  I am trying to set up an emulation scenario with 2 nodes 
  that uses Layer 2 routing via batman-adv. The emulation 
  creates LXC containers for the 2 nodes and I need to assign 
  wlan interfaces on each node to the bat0 interface.
 
  Following are the two things I tried:
 
  Approach 1:
  -> Set up wlanX interfaces on the host machine
  -> Assign bat0 as the mesh_iface on wlanX interfaces
  -> Move wlanX interfaces to LXC containers using 
       'ip link set wlanX netns namespace_id' command
  
  Problem with this approach is that I can't move bat0 interface 
  from host machine to both containers.

  Approach 2:
 
  -> Set up wlanX interfaces on the host machine
  -> Assign bat1 mesh_iface for wlan1 and 
       bat2 mesh_iface for wlan2
  -> Move wlan1 and bat1 interface to LXC container 1
  -> Move wlan2 and bat2 interface to LXC container 2
  
   With this setup, I got node 1 (container 1) to ping to 
   node 2 (container 2). But when I took wlan1 interface 
   down and then brought it back up, I could not ping 
   node 2 from node 1. I think both wlan1 and wlan2 
   need to be on the same mesh cloud (bat0 for example)
   instead of being on separate clouds (bat1 and bat2 
   in my setup). Correct me if I am wrong here please.
 
   I came across this thread that was created in March that 
   talked about using batman-adv in LXC containers:
   http://comments.gmane.org/gmane.org.freifunk.batman/11684. 
   They tried to do something similar as the two things I tried above.
   I was wondering if anyone was able to successfully use batman-adv
   in LXC containers. If so, please let me know the setup that worked for
   you. Otherwise, I will probably have to look at the source code next.
 
Thanks,
Rahul Amin
--
MIT Lincoln Laboratory
Airborne Networks Group

