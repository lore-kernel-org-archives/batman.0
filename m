From: elektra <onelektra@gmx.net>
Date: Sun, 8 Feb 2009 12:47:50 +0100
References: <2ced936d0902041003g74679247i56b83a29b18e7dd2@mail.gmail.com>
	<2ced936d0902071444q129aed4me5dab6117a2e19fb@mail.gmail.com>
	<200902081150.05625.lindner_marek@yahoo.de>
In-Reply-To: <200902081150.05625.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200902081247.51109.onelektra@gmx.net>
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

Hi -

some EEE PC models use a Atheros mPCI wireless card (the 701 for example) but 
my 901 was shipped with a Ralink rt2870 (802.11 abgn) that I replaced with an 
Atheros abg card ASAP...

Actually I'm using Ahdemo mode in my EEE-PC which works nicely together with 
other devices with 'normal' IBSS-mode but fixed IBSS-ID - in our local mesh 
we use Madwifi with OpenWRT patches and Broadcom-based devices (WRT54G/GL/GS, 
Asus WL500GP) with OpenWRT Whiterussian and Broadcom proprietary driver with 
fixed IBSS-ID hack (Freifunk Firmware).

Rate adaption with the Ministrel algorithm works well in Ahdemo mode - and you 
have the possibility to set up a AP VAP on the same interface, too.

Performance is fine. That may be different if you run a Ahdemo-only network in 
range with other wireless networks - they won't detect collisions, hence 
performance can suffer.

Cheers,
elektra



