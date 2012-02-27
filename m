Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 27 Feb 2012 19:19:06 +0800
References: <1330280603-25510-1-git-send-email-ordex@autistici.org>
	<1330280603-25510-6-git-send-email-ordex@autistici.org>
In-Reply-To: <1330280603-25510-6-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201202271919.06934.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv7 5/7] batman-adv: Distributed ARP Table
	- add snooping functions for ARP messages
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

On Monday, February 27, 2012 02:23:21 Antonio Quartulli wrote:
> In case of an ARP message going in or out the soft_iface, it is intercepted
> and a special action is performed. In particular the DHT helper functions
> previously implemented are used to store all the ARP entries belonging to
> the network in order to provide a fast and unicast lookup instead of the
> classic broadcast flooding mechanism.
> Each node stores the entries it is responsible for (following the DHT
> rules) in its soft_iface ARP table. This makes it possible to reuse the
> kernel data structures and functions for ARP management.

Applied in revision 79b67f7.

Thanks,
Marek
