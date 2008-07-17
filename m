Message-ID: <487F60E5.5000003@reglue.org>
Date: Thu, 17 Jul 2008 10:10:29 -0500
From: Don Davis <dondavis@reglue.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] Batman 0.3 + Freifunk setup questions
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
To: batman <b.a.t.m.a.n@open-mesh.net>

Hello,

I had batman 0.2 + freifunk working.

Each router was  10.0.0.* and had the same wlan address.  Something 
happened and then batman just started silently dying on the gateway 
router 10.0.0.1 (with the address 10.0.2.146 from the router connected 
to the internet).  I erased nvram and reinstalled with separate 10.0.5.* 
addresses for the wlan and that seemed to work (with no http access to 
the routers and ssh via the 10.0.5.* addresses).

I had wanted to stay with batman 0.2 because of the web interface. 
That's no longer practical.  0.3 is the preferred batman, so I should 
use it.  I've taken a look at the docs:
  https://dev.open-mesh.net/svn/batman/trunk/batman/INSTALL

and
"RoutingVoodoo."

assuming a fresh install of freifunk with *no OLSR* running what 
parameters would I want to set:

	adsl
	|	
  	10.0.2.1 [home router ppoe]
	|
	freifunk 1 [gateway]
	does subnet matter?
      	lan 10.0.0.1
	wlan do I want 10.0.0.1 or 10.0.5.1?
	wan via dhcp?
	essid, bssid, channel all the same for ff routers
	myessid, 02:CA:FF:EE:BA:BE, 12, ad-hoc
         what batman parameters will I want to pass?
	shall I create an init script or is there one?  0.2 had the init 	and 
the minutely 'watchout4batman'
		|
		|
		|
	freifunk n non-gateway nodes
	lan 10.0.0.n?
	wlan?
	wan via dhcp?
     	batman -p 10.0.0.1 -r 3 (or 10.0.2.146 freifunk 1's wan address) 
  	eth1 br0 vlan1?


Anything else I should be aware of?  Any other recommendations?  (e.g. 
"Scrap that this is exactly how you do it: 1. 2. 3. "





