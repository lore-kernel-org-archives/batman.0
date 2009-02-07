From: elektra <onelektra@gmx.net>
Date: Sat, 7 Feb 2009 22:38:50 +0100
References: <2ced936d0902041003g74679247i56b83a29b18e7dd2@mail.gmail.com>
	<200902071030.10319.lindner_marek@yahoo.de>
	<2ced936d0902071238i14ac756cmccfe2481cb56e6c7@mail.gmail.com>
In-Reply-To: <2ced936d0902071238i14ac756cmccfe2481cb56e6c7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200902072238.50756.onelektra@gmx.net>
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

I'm waiting for working drivers (particularly USB)  for IBSS mode for long 
time and was putting my hope on Ralink RT73 as well.  

The situation is improving with the mac80211 driver development in the Linux 
kernel. Recently patches went into compat-wireless that allow to fix the 
IBSSID with the

iwconfig  <interface> ap <cell-id> 

command - with some drivers, not all. 

However the situation is a little more complex than just fixing the IBSSID, 
because the drivers/firmware have to be convinced not to perform a IBSS-merge 
every time the TSF timestamp in a received beacon is a little older.  Upon a 
merge the cards may flush  their MAC table - this could happen every few 
miliseconds - like I have observed with Intel ipw4965 driver. Also TSF clock 
skews can cause race conditions.

So far ath5k and ath9k seem to work - but the only driver I can really 
recommend is Madwifi with all patches from Openwrt -  vanilla Madwifi is 
*not* working. The patched Madwifi in Openwrt Kamikaze works perfectly (I'm 
using mesh with Batman exclusively every day and I can  suspend/resume my 
EEE-PC for weeks and I'm always online ;-)

But Madwifi does not support USB...

Best bet for USB is Zydas, I guess.

cu elektra
