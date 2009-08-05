Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 5 Aug 2009 19:53:56 +0800
References: <200908051533.26117.lindner_marek@yahoo.de>
	<200908051931.10324.lindner_marek@yahoo.de>
	<SNT107-W263AEF87A1D0726A92E172A60D0@phx.gbl>
In-Reply-To: <SNT107-W263AEF87A1D0726A92E172A60D0@phx.gbl>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200908051953.56292.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Routing help?
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

On Wednesday 05 August 2009 19:35:48 nick farrow wrote:
> Thanks very much - so advance sounds like the solution, I'll try this. Does
> the whole bridge work be default with this install or is there some special
> configuration?

For your setup I suggest you kill the bridge between ethernet and wifi since 
batman-adv will create a new brdige interface you should work with: bat0 You 
should bridge your ethernet with that device and the rest should work as you 
want to have it.


> My ipkg does list batman adv but its an alpha, is this the still the best
> current version to use?

You are using an old version of OpenWRT (7.09). There are updated batman 
packages in 8.09.

Regards,
Marek

