Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 16 Feb 2010 18:29:19 +0800
References: <4B79BDF7.7000204@tiwoc.de>
In-Reply-To: <4B79BDF7.7000204@tiwoc.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201002161829.19535.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH v3] batman-adv: Record route for ICMP
	messages
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


Hey,

> The standard layer 3 ping utility can use the record route (RR) option
> of IP to collect route data for sent ping messages (ping -R). This
> patch introduces comparable functionality for batman-adv ICMP messages.

I don't think we need another packet type for this. I reworked your patches a 
bit. As soon as you checked if you like it this way I will commit them.

Note: I split them into 2 patches because batman-adv  & batctl reside in 
different branches. On top of that syncing distinct patches with the git repos 
is much less painful.  :)

Cheers,
Marek
