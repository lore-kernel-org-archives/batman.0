Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 1 Jul 2010 12:21:52 +0200
References: <FB833AE6C7173C449F93C243719A4C8F0974886B@Exchange2010.corit.local>
In-Reply-To: <FB833AE6C7173C449F93C243719A4C8F0974886B@Exchange2010.corit.local>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201007011221.53277.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Dual radio BATMAN Advanced implementation
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

On Thursday 01 July 2010 05:22:11 Matthew Anderson wrote:
> I'm using OpenWRT with a 5.8GHz 802.11n radio for backhaul and 2.4GHz
> 802.11b/g for serving non BATMAN clients. I'm going to run BATMAN Adv on
> the backhaul network and bridge it to the client radio which would
> effectively make it one giant layer 2 mesh. In this situation, would users
> on the b/g radio's be able to roam between nodes? Am I better off removing
> the bridge between the mesh and the client radio and use layer 3 routing
> or NAT instead?

You got it right - bridge the 2.4GHz network with batman's interface (bat0) 
while batman itself runs on 5.8Ghz and your clients can happily roam around.
Layer 3 routing or NAT is not the way to go if you want roaming.

Cheers,
Marek
