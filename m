From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 6 Feb 2009 10:01:18 +0800
References: <2ced936d0902041003g74679247i56b83a29b18e7dd2@mail.gmail.com>
	<20090204205611.GA13896@pandem0nium>
	<2ced936d0902050926r1f07cf85j405bf808f0bf3f7f@mail.gmail.com>
In-Reply-To: <2ced936d0902050926r1f07cf85j405bf808f0bf3f7f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200902061001.59366.lindner_marek@yahoo.de>
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

>      I still wonder if setting up a static BSSID will stop the BSSID
> selection algorithm from ocurring. What do you think? Have tested this
> in practice?

yes, it will deactivate the selection algorithm. We used this hack to get the 
Freifunk Berlin network stable. We had a real hardware zoo (Atheros, Broadcom, 
Ralink, etc) that was impossible to control without setting the BSSID.

Regards,
Marek

