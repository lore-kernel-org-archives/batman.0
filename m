Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 7 Jul 2010 13:16:11 +0200
References: <201007061948.05784.clemens-john@gmx.de>
	<201007070030.30940.lindner_marek@yahoo.de>
	<201007070145.39178.clemens-john@gmx.de>
In-Reply-To: <201007070145.39178.clemens-john@gmx.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201007071316.11906.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Batman advanced and internet gateways
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

On Wednesday, July 07, 2010 01:45:30 Clemens John wrote:
> Yes we did some verry little documentation [1] but this is still the pure
> configuraion without explenations  because we are currently testing some
> different configurations for example some IPv6 stuff and a script which can
> automatically announce tinc installations with configuration and
> certificates on a central server for automatic tinc installations etc..
> 
> I hope this will get better in the next time.

That would be great!


> Our current setup makes not much sense if we use Batman advanced with
> gateway mode because we do not have a gateway in each cloud and it would
> be difficult to get one to each cloud.
> The best way would be a solution that can use all gateways available in the
> network without extra configuration for each cloud.

This sounds overly complicated. I don't fully understand your setup & 
requirements yet which is also one reason for asking for documentation. 
What your are trying to solve is this (I'm guessing here):

wifi client <> batman node <> VPN <> batman node <> batman with internet

And you have several of these "batman with internet" but not in each cloud and 
want each client to choose its best ?

Regards,
Marek
