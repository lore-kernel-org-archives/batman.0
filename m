Return-Path: <ordex@autistici.org>
Date: Tue, 15 Nov 2011 21:32:19 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20111115203218.GC3304@ritirata.org>
References: <1320752062-21776-1-git-send-email-ordex@autistici.org>
	<1320752062-21776-8-git-send-email-ordex@autistici.org>
	<20111115202723.GA619@pandem0nium>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20111115202723.GA619@pandem0nium>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 7/7] batman-adv: add Distributed ARP
 Table compile option
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

On Tue, Nov 15, 2011 at 09:27:23PM +0100, Simon Wunderlich wrote:
> > +#ifdef CONFIG_BATMAN_ADV_BAT
> 
> Took me some time to find this typo :P
> please use CONFIG_BATMAN_ADV_DAT, not CONFIG_BATMAN_ADV_BAT or else it won't compile.

nice catch! Don't ask me when I introduced this typ0 because I don't know!
Thank Simon,


-- 
Antonio Quartulli

..each of us alone is worth nothing..
Ernesto "Che" Guevara
