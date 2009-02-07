From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 7 Feb 2009 10:30:09 +0800
References: <2ced936d0902041003g74679247i56b83a29b18e7dd2@mail.gmail.com>
	<200902061001.59366.lindner_marek@yahoo.de>
	<2ced936d0902060925g3ab56154haee0bc6aac8ba5ff@mail.gmail.com>
In-Reply-To: <2ced936d0902060925g3ab56154haee0bc6aac8ba5ff@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200902071030.10319.lindner_marek@yahoo.de>
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

>    Have you managed to set a static BSSID to all those chipsets -
> Atheros, Broadcom, Ralink etc? Because up to now, only Atheros made
> this trick possible.

thanks to Felix from the OpenWRT project the Atheros driver has that feature 
(as you know). Broadcom is a much harder cases because the drivers a binary 
only. We mostly use the famous WRT54G and its derivates for our network. Sven-
Ola managed to write patch for that binary driver of the WRT. There also is an 
open source driver project for the broadcom chips but I'm not sure where it 
stands.
I never experimented with Ralink myself, so I can't answer that. I'm sure 
Elektra could jump in here.  :-)

Regards,
Marek

