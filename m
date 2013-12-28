Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Sat, 28 Dec 2013 14:41:51 +0100
References: <CAFkF_bJP+Ri1Q7ELxRkVkudvMUZMfC10WFmrCHceeHV0Rtd8TA@mail.gmail.com>
In-Reply-To: <CAFkF_bJP+Ri1Q7ELxRkVkudvMUZMfC10WFmrCHceeHV0Rtd8TA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201312281441.51738.sw@simonwunderlich.de>
Subject: Re: [B.A.T.M.A.N.] Using bat-adv for Wireless Video Streaming
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
Cc: Kartic Bhargav <karticbhargavinline@gmail.com>

Hi Kartic,

> I have set up the bat-adv mesh network and am able to ping each node.
> I am working on the Video forwarding from one node to another now and
> am facing problems here as I am unsure as to how to proceed. I have a
> Microsoft LifeCam Camera attached to one of my Nodes and have to hop
> the captured video packets to the next series of nodes.

Great, pinging each node is the first step to go!

> 
> I'm relatively new to bat-adv and some of its advanced functions.
> Since we are dealing with ipv6 connectivity here, the eth0 is down and
> as expected am unable to connect to the existing ipv4 LAN Network at
> my Lab. So I'm not able to use the conventional Video streaming / Port
> listening & forwarding tools. (like Netcat etc.)
> 
> Is there any specific tool/way by which I can achieve my 'Video
> Forwarding' objective via bat-adv commands like batctl etc.? How
> exactly do you make use of the connectivity between nodes? Any such
> applications that are supported to forward Video Packets?

You can use eth0 and bat0 at the same time, that should be no problem. Batman-
adv provides a layer 2 mesh, that means you'll get a virtual interface called 
bat0 by default, and you can use this interface just as you would use your 
Ethernet interface eth0. This means you should use the same tools for 
streaming which you would on a wired network, like netcat or ffmpeg or 
mjpegstreamer or whatever ... batctl is just used for controlling and 
monitoring batman-adv, nothing else.

We have some quick start guide here, which might be useful to read (even if 
you have set up the mesh already):

http://www.open-mesh.org/projects/batman-adv/wiki/Quick-start-guide

If you want to send data from one node to another, just set up IP addresses on 
bat0 (or their respective bridge interfaces if you use bridging) and start 
sending data with your favourite network tools ;)

Cheers,
    Simon
