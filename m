From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 8 Feb 2009 11:50:05 +0800
References: <2ced936d0902041003g74679247i56b83a29b18e7dd2@mail.gmail.com>
	<200902072238.50756.onelektra@gmx.net>
	<2ced936d0902071444q129aed4me5dab6117a2e19fb@mail.gmail.com>
In-Reply-To: <2ced936d0902071444q129aed4me5dab6117a2e19fb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200902081150.05625.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Stable adapters for Ad Hoc networks
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>


Hi,

>      Thanks for the information. At least now I have some background
> to work on - I already have several rt73 USB dongles, some notebooks
> with Atheros, some OpenMokos (which have atheros chipsets) and a few
> Nokia N810 tablets (which have a prism chipset).

although the Openmoko Freerunner has an Atheros chip inside it does not use 
the madiwifi driver (this is the AR6001 mobile chip, in case you wonder).


>      And they mentioned about some intermediate mode, called
> Pseudo-IBSS or AHdemo mode, which allows a device to set a static
> BSSID and it is supported by some drivers. I suppose we are talking
> about the same thing here, just not giving any names (?).

AHdemo is not the same as setting the BSSID in ad-hoc mode manually. As 
mentioned on the page you linked to the AHdemo mode does not send any beacons. 
Whereas the ad-hoc mode sends beacons with a fixed BSSID. Not sending beacons 
has certain side effects: 
- your network will appear being "invisible" (the normal network manager wont 
show it)
- you have to manually configure the connection speed and other stuff as the 
usual autonegotiation is using the beacons for that
- you will have collisions (might lead to decreased performance)
- driver compat problems (only a few drivers support this mode)

Nevertheless, it will fix your cell split problem. :-)


>      When you mentioned your EEE PC, which uses an Atheros chipset,
> did you also had to set a static BSSID to the same used in the mesh
> network you use?

I think EEE PC uses the madwifi driver?! If so you can set the BSSID 
statically.

Regards,
Marek


