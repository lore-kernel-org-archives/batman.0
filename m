Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 17 May 2010 06:53:01 +0800
References: <20100508170755.GA27599@ritirata.org>
	<201005170337.45135.lindner_marek@yahoo.de>
	<20100516212754.GB2364@ritirata.org>
In-Reply-To: <20100516212754.GB2364@ritirata.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201005170653.01657.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Blocking OGMs from a node for testing purpose
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

On Monday 17 May 2010 05:27:55 Antonio Quartulli wrote:
> It is what i described just a few rows before..the problem is that
> adding wlan0 interface to a eth-bridge (using cfg80211 driver) is not
> possible (due to operation not permitted error, probably because devs
> don't want to do that :P) either with iwlagn or rt2x00

Ok, I did not quite get that the first time but it seems you are right: The wifi 
stack sets IFF_DONT_BRIDGE on any wifi interface in adhoc or station mode to 
keep it from being added to a bridge. Normally, this would be a very correct 
behaviour ..

Then we have to add ebtables support by calling some ebtables hooks that will 
tell us whether or not to drop the packet ? Is that possible (I'm not the 
ebtables expert here) ?  :-)

Cheers,
Marek
