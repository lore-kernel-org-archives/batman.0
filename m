From: Axel Neumann <axel@open-mesh.net>
Date: Mon, 10 Dec 2007 12:19:23 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200712101219.23274.axel@open-mesh.net>
Subject: [B.A.T.M.A.N.] In-the-field Protocol Migration (was: exp-rv811 and
	exp-864 non-interoperable?)
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

Hi,

On Montag 10 Dezember 2007, Predrag Balorda wrote:
> Before I go round upgrading my routers, are these two incompatible because
> it seems so? 
Yes, everyting < 863 is incompatible with revisions >= 863
> If so then I'll need to figure out the exact order of 
> upgrading (i.e furthest first - I don't want to have to climb roofs or walk
> too long)


The following should be possible even without any upgrading order - allowing a 
completely seamless, in-the-field protocol migration. May sound a bit 
oversized but is probably the only way for large-chaotic mesh networks.

In short this approach involves three steps:

1) Install the new batman version in parallel to the existing one 
   (ensure independent operation of the two protocols, more details below...)

2) Test the new batman version

3) Disable the old batman version

Now the long and detailed howto. Don't be afraid it turns out to be much 
easier than it first sounds.

0) You keep your current revision running as it is.

1) Install the new version in parallel to the existing one. 
   Do NOT enable GW-client mode (-r of -p) before step 2. 
   Configure the new version with independent:
    a) alias interfaces and IP ranges 
      ( e.g. use eth0:bmx 103.x.y.z/8 in addition to eth0:bat 105.x.y.z/8 )

Ensure that the old batmand gets (re-)started after the new alias interfaces 
and ip ranges have been configured. Thus, either 
 - you only restart the old batmand after the new interface configuration or
 - you put the bat and bmx alias-interface configuration in your startup
   scripts and reboot your device.
The reason for this is that batman learns about the networks of a node during 
its startup process and takes care that packets towards these networks are 
not routed into the batman tunnel. Because we don't want the 103.0.0.0/8 
traffic (related to the new batmand) to be routed via the bat0 tunnel of the 
old batmand, we have to make sure that the old batmand knows about it.

    b) binary name (e.g. rename the binary to /usr/sbin/bmxd)
    c) protocol port numbers ( e.g. use 14305 instead of 4305 )
    d) ip preference rules (e.g. use 14xxx instead of 6xxx)
    e) ip routing tables (e.g. use table 144-148 instead of 64-68 )
    f) gateway tunnel ip ranges 
       (e.g. use bat1 169.254.128.0/22 instead of bat0 169.254.0.0/22 )
    g) unix-socket identifier to access debug messages
 
   The good thing is, the --neta option cares for task 
   c,d,e,f,g automatically, so the only tasks left are the binary names and 
   the interface configuration (and of course the annoying firewall
   configuration)

2) Now - when the new version is installed everywhere - it can be tested. 
So fare GW-Client mode should not have been activated with the new version. 
Therefore, the first testing can only involve the routing inside the mesh, the 
cpu load of the new version,...
One note, to access the debug output of the new batman version 
use --neta -cd1 , the verbose output has moved to debug-level 8 (--neta -cd8)

To test internet connectivity I assume that the nodes which were operating in 
GW-mode with the old batmand are also operating in GW-mode with the new 
batman version.
But so fare GW-Client mode has not been activated with the new version. The 
GW-Client mode (e.g. -r 3) configures your default route and there can be 
only ONE default route per node. So here each node/user has to make a choice.
The good thing is, this choice can now be done independently at each node.
Since revision 811 (this is before the compatibility change) you can use 
-c -r 0 to dynamically deactivate GW-client mode with the old batman 
and --neta -c -r 3 to dynamically activate GW-client mode with the new 
version.

3) Once every node and user is convinced that using the new batman version for 
routing and surfing the internet pays out (thus uses -r 0 with the old batman 
and -r 3 with the new version) the old version can be gradually deactivated.



happy routing,
axel



>
> Best regards,
>
> Pele
>
> P.S. also has anyone compared network throughput between beta and exp and
> are there any benefits to beta over exp?



> P.P.S I'm experimenting with PoE and guess which process is the first that
> gets killed because of undervoltage?! :-)
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n

